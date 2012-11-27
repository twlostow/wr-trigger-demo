#include <stdio.h>

#include "simple-eb.h"
#include "ttd_lib.h"
#include "hw/trigger_tx_regs.h"
#include "hw/trigger_rx_regs.h"
#include "hw/trigger_shared_regs.h"

#include "fdelay_lib.h"


main(int argc, char *argv[])
{
	eb_device_t dev, dev1,dev2;
	uint32_t tmp [1024];
	int i=0, count = argc > 1 ? atoi(argv[1]) : 4;

#if 1

	fdelay_device_t *fd = fdelay_create();
	fdelay_probe(fd, "eb:192.168.10.104");
	
	fdelay_time_t t;
	memset(&t, 0, sizeof(t));
	fdelay_init(fd, 0);

	fdelay_configure_sync(fd, FDELAY_SYNC_WR);
	fdelay_configure_trigger(fd, 1, 1);
	while(!fdelay_check_sync(fd))
	{
		fprintf(stderr,".");
		sleep(1);
	}
	fprintf(stderr,"\n");
	
	fdelay_configure_output(fd, 1, 1, 500000, 500000, 1000000, 1);



	fdelay_release(fd);
#endif
//	return 0;
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
	

	ebs_init();
	ebs_open(&dev1,  "udp/192.168.10.101");
	
	ebs_write(dev1, 0x82000 + TTX_REG_ADJ_C, 0);
	ebs_write(dev1, 0x82000 + TTX_REG_ADJ_F, 0);
	ebs_write(dev1, 0x82000 + TTX_REG_CR, TTX_CR_ENABLE | TTX_CR_RST_CNT | (11 << TTX_CR_ID_SHIFT));

	ebs_open(&dev2,  "udp/192.168.10.104");
	
	ebs_write(dev2, 0x82000 + TRX_REG_DELAY_C, 3000);
	ebs_write(dev2, 0x82000 + TRX_REG_DELAY_F, 0);
	ebs_write(dev2, 0x82000 + TRX_REG_CR, TRX_CR_ENABLE | (11 << TRX_CR_ID_SHIFT));


	
	for(;;)
	{
		printf("TXTrigCnt: %d\n", ebs_read(dev1, 0x82000 + TTX_REG_CNTR));
		printf("RXTrigCnt: %d\n", ebs_read(dev2, 0x82000 + TRX_REG_CNTR_RX));
		sleep(1);
	}
	
	return 0;
}


