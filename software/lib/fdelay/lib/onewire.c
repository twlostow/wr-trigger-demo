#include  <stdio.h>
#include <stdint.h>

#include "fdelay_lib.h"
#include "fdelay_private.h"

#define   R_CSR  0x0
#define   R_CDR  0x4

#define   CSR_DAT_MSK  (1<<0)
#define   CSR_RST_MSK  (1<<1)
#define   CSR_OVD_MSK  (1<<2)
#define   CSR_CYC_MSK  (1<<3)
#define   CSR_PWR_MSK  (1<<4)
#define   CSR_IRQ_MSK  (1<<6)
#define   CSR_IEN_MSK  (1<<7)
#define   CSR_SEL_OFS  8
#define   CSR_SEL_MSK  (0xF<<8)
#define   CSR_POWER_OFS  16
#define   CSR_POWER_MSK  (0xFFFF<<16)
#define   CDR_NOR_MSK  (0xFFFF<<0)
#define   CDR_OVD_OFS  16
#define   CDR_OVD_MSK  (0xFFFF<<16)


#define ow_writel(data, addr) dev->writel(dev->priv_io, data, (hw->base_onewire + (addr)))
#define ow_readl(addr) dev->readl(dev->priv_io, (hw->base_onewire + (addr)))

#define CLK_DIV_NOR 624/2
#define CLK_DIV_OVD 124/2

static void ow_init(fdelay_device_t *dev)
{
	fd_decl_private(dev);
    ow_writel(((CLK_DIV_NOR & CDR_NOR_MSK) | (( CLK_DIV_OVD << CDR_OVD_OFS) & CDR_OVD_MSK)), R_CDR);
}

static int ow_reset(fdelay_device_t *dev, int port)
{
    fd_decl_private(dev);
    uint32_t data = ((port<<CSR_SEL_OFS) & CSR_SEL_MSK) | CSR_CYC_MSK | CSR_RST_MSK;
    ow_writel(data, R_CSR);
    while(ow_readl(R_CSR) & CSR_CYC_MSK);
    uint32_t reg = ow_readl(R_CSR);
    return ~reg & CSR_DAT_MSK;
}

static int slot(fdelay_device_t *dev, int port, int bit)
{
	fd_decl_private(dev);
	uint32_t data;
    data = ((port<<CSR_SEL_OFS) & CSR_SEL_MSK) | CSR_CYC_MSK | (bit & CSR_DAT_MSK);
    ow_writel(data, R_CSR);
    while(ow_readl(R_CSR) & CSR_CYC_MSK);
    uint32_t   reg = ow_readl(R_CSR);
    return reg & CSR_DAT_MSK;
}

static int read_bit(fdelay_device_t *dev, int port) { return slot(dev, port, 0x1); }
static int write_bit(fdelay_device_t *dev, int port, int bit) { return slot(dev, port, bit); }


int ow_read_byte(fdelay_device_t *dev, int port) {
    int  data = 0, i;
    for(i=0;i<8;i++)
         data |= read_bit(dev, port) << i;
    return data;
}

int ow_write_byte(fdelay_device_t *dev, int port, int byte)
{
 int  data = 0;
    int   byte_old = byte, i;
    for (i=0;i<8;i++){
         data |= write_bit(dev, port, (byte & 0x1)) << i;
         byte >>= 1;
    }

    return byte_old == data ? 0 : -1;
}

int ow_write_block(fdelay_device_t *dev, int port, uint8_t *block, int len)
{
    int i;
    for(i=0;i<len;i++)
    {
        *block++ = ow_write_byte(dev, port, *block);
    }
    return 0;
}

int ow_read_block(fdelay_device_t *dev, int port, uint8_t *block, int len)
{
   int i;
    for(i=0;i<len;i++)
    {
        *block++ = ow_read_byte(dev, port);
    }
    return 0;
}

#define    ROM_SEARCH  0xF0
#define    ROM_READ  0x33
#define    ROM_MATCH  0x55
#define    ROM_SKIP  0xCC
#define    ROM_ALARM_SEARCH  0xEC

#define    CONVERT_TEMP  0x44
#define    WRITE_SCRATCHPAD  0x4E
#define    READ_SCRATCHPAD  0xBE
#define    COPY_SCRATCHPAD  0x48
#define    RECALL_EEPROM  0xB8
#define    READ_POWER_SUPPLY  0xB4

static uint8_t ds18x_id [8];


int ds18x_read_serial(fdelay_device_t *dev, uint8_t *id)
{
    int i;

    if(!ow_reset(dev, 0))
        return -1;

    ow_write_byte(dev, 0, ROM_READ);
    for(i=0;i<8;i++)
    {
		*id = ow_read_byte(dev, 0);
        id++;
    }

    return 0;
}

static int ds18x_access(fdelay_device_t *dev, uint8_t *id)
{
    int i;
    if(!ow_reset(dev, 0))
		return -1;

    if(ow_write_byte(dev, 0, ROM_MATCH) < 0)
		return -1;
    for(i=0;i<8;i++)
		if(ow_write_byte(dev, 0, id[i]) < 0)
			return -1;
}

int ds18x_read_temp(fdelay_device_t *dev, int *temp_r)
{
    int i;
    uint8_t data[9];


	if(ds18x_access(dev, ds18x_id) < 0)
		return -1;
    ow_write_byte(dev, 0, READ_SCRATCHPAD);

    for(i=0;i<9;i++) data[i] = ow_read_byte(dev, 0);

    int  temp = ((int)data[1] << 8) | ((int)data[0]);
    if(temp & 0x1000)
       temp = -0x10000 + temp;

    ds18x_access(dev, ds18x_id);
    ow_write_byte(dev, 0, CONVERT_TEMP);

	if(temp_r) *temp_r = temp;
	return 0;
}

int ds18x_init(fdelay_device_t *dev)
{

	ow_init(dev);
	if(ds18x_read_serial(dev, ds18x_id) < 0)
		return -1;

	dbg("Found DS18xx sensor: %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x\n",
		ds18x_id[0], ds18x_id[1], ds18x_id[2], ds18x_id[3],
		ds18x_id[4], ds18x_id[5], ds18x_id[6], ds18x_id[7]);

	return ds18x_read_temp(dev, NULL);
}
