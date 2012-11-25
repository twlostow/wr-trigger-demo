#include <stdio.h>

#include "simple-eb.h"
#include "ttd_lib.h"
#include "hw/trigger_tx_regs.h"
#include "hw/trigger_shared_regs.h"

#include "fdelay_lib.h"


main(int argc, char *argv[])
{
	eb_device_t dev;
	uint32_t tmp [1024];
	int i=0, count = argc > 1 ? atoi(argv[1]) : 4;
	ebs_init();
	ebs_open(&dev,  "udp/192.168.10.11");

	int configured = ebs_read(dev, 0x90000 + TTS_REG_CR) & TTS_CR_CONFIGURED ? 1 : 0;

	ebs_close(dev);

	fdelay_device_t *fd = fdelay_create();
	fdelay_probe(fd, "eb:192.168.10.11");
	
	if(!configured || argc > 2)
	{
		fdelay_time_t t;
		memset(&t, 0, sizeof(t));
		fdelay_init(fd, 0);
		fdelay_set_time(fd, t);
		fdelay_configure_trigger(fd, 1, 1);
		configured = 1;
	}


	fdelay_release(fd);
	
#if 0
	for(;;)
	{
  	ebs_block_read(dev, 0, tmp, count, 1);

	//	for(i=0;i<count;i++)
	//		printf("%03x: %08x\n", i, tmp[i]);
		i++;
		fprintf(stderr,"%d\n", i);
	}
#endif
	
	
	ebs_open(&dev,  "udp/192.168.10.11");
	if(configured)
		ebs_write(dev, 0x90000 + TTS_REG_CR, TTS_CR_CONFIGURED);
	
	ebs_write(dev, 0x91000 + TTX_REG_ADJ_C, 1000);
	ebs_write(dev, 0x91000 + TTX_REG_ADJ_F, 0);
	ebs_write(dev, 0x91000 + TTX_REG_CR, TTX_CR_ENABLE | TTX_CR_RST_CNT);
	
	for(;;)
	{
		printf("TrigCnt: %d\n", ebs_read(dev, 0x91000 + TTX_REG_CNTR));
		sleep(1);
	}
	
	return 0;
}


