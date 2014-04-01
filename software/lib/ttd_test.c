#include <stdio.h>

#include "simple-eb.h"
#include "ttd_lib.h"
#include "hw/trigger_tx_regs.h"
#include "hw/trigger_rx_regs.h"
#include "hw/trigger_shared_regs.h"

#include "fdelay_lib.h"


int config_output(eb_device_t dev,int out, int id, int delay)
{


	ebs_write(dev, 0x86000 + out * 0x1000+TRX_REG_CR, 0);
	ebs_write(dev, 0x86000 + out * 0x1000+TRX_REG_DELAY_C, delay);
	ebs_write(dev, 0x86000 + out * 0x1000+TRX_REG_DELAY_F, 10);
	ebs_write(dev, 0x86000 + out * 0x1000+ TRX_REG_CR, TRX_CR_ENABLE | TRX_CR_RST_CNT| TRX_CR_RST_HIST| TRX_CR_ID_W(id));

}

int rx_stats(eb_device_t dev,int out)
{
	int i;
		printf("TrigCR: %x\n", ebs_read(dev, 0x86000 +out*0x1000+ TRX_REG_CR));
		for(i=0;i<512;i++)
		{
			printf("%04d ", ebs_read(dev, 0x89000 +out*0x1000+ TRX_DHB_RAM_BASE + i*4));
			if(i%16==0)
			printf("\n");
		}



}

main(int argc, char *argv[])
{
	eb_device_t dev;
	uint32_t tmp [1024];
	int i=0, count = argc > 1 ? atoi(argv[1]) : 4;
	int configured = 1;
	ebs_init();
	
	ebs_open(&dev,  "udp/192.168.10.12");
	if(configured)
		ebs_write(dev, 0x80000 + TTS_REG_CR, TTS_CR_CONFIGURED);
	
	ebs_write(dev, 0x82000 + TTX_REG_ADJ_C, 0);
	ebs_write(dev, 0x82000 + TTX_REG_ADJ_F, 0);
	ebs_write(dev, 0x82000 + TTX_REG_CR, TTX_CR_ENABLE | TTX_CR_RST_CNT | TTX_CR_ID_W(1));
	
//	for(;;)
	{
		sleep(1);
		printf("TrigCR: %x\n", ebs_read(dev, 0x82000 + TTX_REG_CR));
		printf("TrigADJ: %x\n", ebs_read(dev, 0x82000 + TTX_REG_ADJ_C));
		printf("TrigCnt: %d\n", ebs_read(dev, 0x82000 + TTX_REG_CNTR));
	}

	ebs_close(dev);
	ebs_open(&dev,  "udp/192.168.10.13");
//	if(configured)
//		ebs_write(dev, 0x80000 + TTS_REG_CR, TTS_CR_CONFIGURED);

	ebs_write(dev, 0x81000 + TTX_REG_CR, 0);
	ebs_write(dev, 0x82000 + TTX_REG_CR, 0);
	ebs_write(dev, 0x83000 + TTX_REG_CR, 0);
	ebs_write(dev, 0x84000 + TTX_REG_CR, 0);
	ebs_write(dev, 0x85000 + TTX_REG_CR, 0);

	config_output(dev, 0, 1, 5000);
	config_output(dev, 1, 1, 5000);
	config_output(dev, 2, 1, 5000);
	config_output(dev, 3, 1, 5000);
	config_output(dev, 4, 1, 5000);
	

	for(;;){
//		sleep(1);
		 rx_stats(dev, 1);

	}
	ebs_close(dev);
	return 0;
}


