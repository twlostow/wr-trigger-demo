#include <stdio.h>

#include "fdelay_lib.h"
#include "fdelay_private.h"
#include "fd_main_regs.h"


#define M_SDA_OUT(x) {							\
    if(x)								\
      fd_writel(fd_readl(FD_REG_I2CR) | FD_I2CR_SDA_OUT, FD_REG_I2CR); \
    else								\
      fd_writel(fd_readl(FD_REG_I2CR) & (~FD_I2CR_SDA_OUT), FD_REG_I2CR); \
      udelay(10);\
  }

#define M_SCL_OUT(x) {							\
    if(x)								\
      fd_writel(fd_readl(FD_REG_I2CR) | FD_I2CR_SCL_OUT, FD_REG_I2CR); \
    else								\
      fd_writel(fd_readl(FD_REG_I2CR) & (~FD_I2CR_SCL_OUT), FD_REG_I2CR); \
      udelay(10); \
  }

#define M_SDA_IN ((fd_readl(FD_REG_I2CR) & FD_I2CR_SDA_IN) ? 1 : 0)

static void mi2c_start(fdelay_device_t *dev)
{
	fd_decl_private(dev);
  M_SDA_OUT(0);
  M_SCL_OUT(0);
}

static void mi2c_repeat_start(fdelay_device_t *dev)
{
	fd_decl_private(dev);
  M_SDA_OUT(1);
  M_SCL_OUT(1);
  M_SDA_OUT(0);
  M_SCL_OUT(0);
}

static void mi2c_stop(fdelay_device_t *dev)
{
	fd_decl_private(dev);
  M_SDA_OUT(0);
  M_SCL_OUT(1);
  M_SDA_OUT(1);
}

 int mi2c_put_byte(fdelay_device_t *dev, unsigned char data)
{
	fd_decl_private(dev);
  char i;
  unsigned char ack;

  for (i=0;i<8;i++, data<<=1)
    {
      M_SDA_OUT(data&0x80);
      M_SCL_OUT(1);
      M_SCL_OUT(0);
    }

  M_SDA_OUT(1);
  M_SCL_OUT(1);

  ack = M_SDA_IN;	/* ack: sda is pulled low ->success.	 */

  M_SCL_OUT(0);
  M_SDA_OUT(0);

  return ack!=0 ? -1 : 0;
}

void mi2c_get_byte(fdelay_device_t *dev, unsigned char *data, int ack)
{
	fd_decl_private(dev)

  int i;
  unsigned char indata = 0;

  /* assert: scl is low */
  M_SCL_OUT(0);
  M_SDA_OUT(1);
  for (i=0;i<8;i++)
    {
      M_SCL_OUT(1);
      indata <<= 1;
      if ( M_SDA_IN ) indata |= 0x01;
      M_SCL_OUT(0);
    }

  M_SDA_OUT((ack ? 0 : 1));
  M_SCL_OUT(1);
  M_SCL_OUT(0);
  M_SDA_OUT(0);

  *data= indata;
}

void mi2c_init(fdelay_device_t *dev)
{
	fd_decl_private(dev);

	M_SCL_OUT(1);
	M_SDA_OUT(1);
}

void mi2c_scan(fdelay_device_t *dev)
{
 	int i;
 	for(i=0;i<256;i+=2)
 	{
 	 	mi2c_start(dev);
		if(!mi2c_put_byte(dev,i))
			printf("Found device at 0x%x\n", i>>1);
		mi2c_stop(dev);

 	}
}

int eeprom_read(fdelay_device_t *dev, uint8_t i2c_addr, uint32_t offset, uint8_t *buf, size_t size)
{
	int i;
	unsigned char c;
	for(i=0;i<size;i++)
	{
 	mi2c_start(dev);
	if(mi2c_put_byte(dev, i2c_addr << 1) < 0)
 	{
 	 	mi2c_stop(dev);
 	 	return -1;
  	}

	mi2c_put_byte(dev, (offset >> 8) & 0xff);
	mi2c_put_byte(dev, offset & 0xff);
	offset++;
	mi2c_stop(dev);
	mi2c_start(dev);
 	mi2c_put_byte(dev, (i2c_addr << 1) | 1);
	mi2c_get_byte(dev, &c, 0);
//	printf("readback: %x\n", c);
	*buf++ = c;
 	mi2c_stop(dev);
 	}
 	return size;
}

int eeprom_write(fdelay_device_t *dev, uint8_t i2c_addr, uint32_t offset, uint8_t *buf, size_t size)
{
	int i, busy;
	for(i=0;i<size;i++)
	{
	 	mi2c_start(dev);

	 	if(mi2c_put_byte(dev, i2c_addr << 1) < 0)
	 	{
		 	mi2c_stop(dev);
	 	 	return -1;
	  	}

		mi2c_put_byte(dev, (offset >> 8) & 0xff);
		mi2c_put_byte(dev, offset & 0xff);
		mi2c_put_byte(dev, *buf++);
		offset++;
		mi2c_stop(dev);


		do /* wait until the chip becomes ready */
		{
            mi2c_start(dev);
			busy = mi2c_put_byte(dev, i2c_addr << 1);
			mi2c_stop(dev);
		} while(busy);

	}
 	return size;
}
