#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <getopt.h>

#include "fdelay_lib.h"
#include "simple-eb.h"

//#include "spec/tools/speclib.h"
#include "fdelay_lib.h"

void printk() {};

#if 0
static void fd_spec_writel(void *priv, uint32_t data, uint32_t addr)
{
	spec_writel(priv, data, addr);
}

static uint32_t fd_spec_readl(void *priv, uint32_t addr)
{
	return spec_readl(priv, addr);
}

static int spec_fdelay_create(fdelay_device_t *dev, int bus, int dev_fn)
{
	uint32_t base;

	dev->priv_io = spec_open(bus, dev_fn);

	if(!dev->priv_io)
	{
	 	fprintf(stderr,"Can't map the SPEC @ %x:%x\n", bus, dev_fn);
	 	return -1;
	}

	dev->writel = fd_spec_writel;
	dev->readl = fd_spec_readl;
	dev->base_addr = base;

	//spec_vuart_init(dev->priv_io, 0xe0500); /* for communication with WRCore during DMTD calibration */

    return 0;
}
#endif


static void fd_eb_writel(void *priv, uint32_t data, uint32_t addr)
{
	ebs_write((eb_device_t) priv, addr, data);
}

static uint32_t fd_eb_readl(void *priv, uint32_t addr)
{
	return ebs_read((eb_device_t) priv, addr);
}



#define VENDOR_CERN 0xce42
#define DEVICE_FD_CORE 0xf19ede1a
#define DEVICE_VUART 0xe2d13d04


int fdelay_probe(fdelay_device_t *dev, const char *location)
{
	int bus = -1, dev_fn = -1;
	char ip_addr[128];
	int use_eb = 0;
	uint32_t base_core;

	if(!strncmp(location, "eb:", 3))
	{
		snprintf(ip_addr, sizeof(ip_addr), "udp/%s", location+3);
		use_eb = 1;
	} else if (!strncmp(location, "spec:"), 5) {
		sscanf(location+5, "%d,%d", &bus, &dev_fn);
	}

	if(use_eb)
	{
		dbg("Probing with Etherbone [%s]\n", ip_addr);

		if(	ebs_init() != EB_OK)
		{
	 		fprintf(stderr,"Can't initialize Etherbone library.\n");
	 		return -1;
		}

		if(ebs_open((eb_device_t*) &dev->priv_io, ip_addr) != EB_OK)
		{
		 	fprintf(stderr,"Can't connect to Etherbone device %s.\n", location);
	 		return -1;
		}

		if(!ebs_sdb_find_device((eb_device_t ) dev->priv_io, VENDOR_CERN, DEVICE_FD_CORE, 0, &base_core))
		{
		 	fprintf(stderr,"Can't detect the FD core. Is the bitstream loaded?\n", location);
	 		return -1;
		}

		dev->writel = fd_eb_writel;
		dev->readl = fd_eb_readl;
		dev->base_addr = base_core;

		dbg("Found FD core @ 0x%x\n", base_core);

	} else {
		dbg("Sorry, SPEC temporarily unsupported\n.");
		return -1;
	}
	
}

int fdelay_release(fdelay_device_t *dev)
{
	ebs_close(dev->priv_io);
	return 0;
}

fdelay_device_t *fdelay_create()
{
	return (fdelay_device_t *) malloc(sizeof(fdelay_device_t));
}
