#include <stdio.h>

#include "simple-eb.h"
#include "ttd_lib.h"
#include "hw/trigger_tx_regs.h"

main()
{
	eb_device_t dev;
	ebs_init();
	ebs_open(&dev, "udp/192.168.0.100");
	
	ebs_write(dev, 0x82000 + TTX_REG_ADJ_C, 1000);
	ebs_write(dev, 0x82000 + TTX_REG_ADJ_F, 0);
	ebs_write(dev, 0x82000 + TTX_REG_CR, TTX_CR_ENABLE | TTX_CR_RST_CNT);
	
	for(;;)
	{
		printf("TrigCnt: %d\n", ebs_read(dev, 0x82000 + TTX_REG_CNTR));
		sleep(1);
	}
	
	return 0;
}


