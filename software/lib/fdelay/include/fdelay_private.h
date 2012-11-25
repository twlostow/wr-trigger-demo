/*
	FmcDelay1ns4Cha (a.k.a. The Fine Delay Card)
	User-space driver/library

	Private includes

	Tomasz Włostowski/BE-CO-HT, 2011

	(c) Copyright CERN 2011
	Licensed under LGPL 2.1
*/

#ifndef __FDELAY_PRIVATE_H
#define __FDELAY_PRIVATE_H

#include <stdint.h>

/* SPI Bus chip selects */

#define CS_DAC 0   /* AD9516 PLL */
#define CS_PLL 1  /* AD9516 PLL */
#define CS_GPIO 2 /* MCP23S17 GPIO */
#define CS_NONE 3 

/* MCP23S17 GPIO expander pin locations: bit 8 = select bank 2, bits 7..0 = mask of the pin in the selected bank */
#define SGPIO_TERM_EN  (1<<0)	 	/* Input termination enable (1 = on) */
#define SGPIO_OUTPUT_EN(x) (1<<(6-x))		/* Output driver enable (1 = on) */
#define SGPIO_TRIG_SEL  (1<<6)  	/* TDC trigger select (0 = trigger input, 1 = FPGA) */
#define SGPIO_CAL_EN  (1<<7)  	/* Calibration mode enable (0 = on) */

/* ACAM TDC operation modes */
#define ACAM_RMODE 0
#define ACAM_IMODE 1

/* MCP23S17 register addresses (only ones which are used by the lib) */
#define MCP_IODIR 0x0
#define MCP_IPOL 0x1
#define MCP_OLAT  0x14
#define MCP_IOCON 0x0a
#define MCP_GPIO  0x12

/* Number of fractional bits in the timestamps/time definitions. Must be consistent with the HDL bitstream.  */
#define FDELAY_FRAC_BITS 12

/* Fractional bits shifted away when converting the fine (< 8ns) part to fit the range of SY89295 delay line. */
#define FDELAY_SCALER_SHIFT 12

/* Number of delay line taps */
#define FDELAY_NUM_TAPS 1024

/* How many times each calibration measurement will be averaged */
#define FDELAY_CAL_AVG_STEPS 1024

/* Fine Delay Card Magic ID */
#define FDELAY_MAGIC_ID 0xf19ede1a

/* RSTR Register value which triggers a reset of the FD Core */
#define FDELAY_RSTR_TRIGGER 0xdeadbeef

/* Calibration eeprom I2C address */
#define EEPROM_ADDR 0x50

/* ACAM Calibration parameters */
struct fine_delay_calibration {
	uint32_t magic;				/* magic ID: 0xf19ede1a */
	uint32_t zero_offset[4]; 	/* Output zero offset, in nsec << FDELAY_FRAC_BITS */
	uint32_t adsfr_val; 		/* ADSFR register value */
	uint32_t acam_start_offset; /* ACAM Start offset value */
	uint32_t atmcr_val; 		/* ATMCR register value */
	uint32_t tdc_zero_offset;   /* Zero offset of the TDC, in picoseconds */
	int64_t frr_poly[3];        /* SY89295 delay/temperature polynomial coefficients */
} __attribute__((packed));

/* Internal state of the fine delay card */
struct fine_delay_hw
{
	uint32_t base_addr; 		/* Base address of the core */
	uint32_t base_onewire; 		/* Base address of the core */
	uint32_t base_i2c;			/* SPI Controller offset */
	uint32_t acam_addr;         /* Current state of ACAM's address lines */
	double acam_bin; 			/* bin size of the ACAM TDC - calculated for 31.25 MHz reference */
    uint32_t frr_offset[4];     /* Offset between the FRR measured at a known temperature at startup and poly-fitted FRR */
	uint32_t frr_cur[4];		/* Fine range register for each output, current value (after online temp. compensation) */
	int32_t cal_temp;           /* SY89295 calibration temperature in 1/16 degC units */
	int32_t board_temp;			/* Current temperature of the board, unit = 1/16 degC */
	int wr_enabled;
	int wr_state;
	int raw_mode;
	int do_long_tests;
	struct fine_delay_calibration calib;
	int64_t input_user_offset, output_user_offset;
};

/* some useful access/declaration macros */
#define fd_writel(data, addr) dev->writel(dev->priv_io, data, (hw->base_addr + (addr)))
#define fd_readl(addr) dev->readl(dev->priv_io, (hw->base_addr + (addr)))
#define fd_decl_private(dev) struct fine_delay_hw *hw = (struct fine_delay_hw *) dev->priv_fd;



#endif
