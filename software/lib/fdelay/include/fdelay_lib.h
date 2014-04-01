#ifndef __FD_LIB_H
#define __FD_LIB_H

#include <stdint.h>

/* Number of fractional bits in the timestamps/time definitions. Must be consistent with the HDL bitstream.  */
#define FDELAY_FRAC_BITS 12


/* fdelay_get_timing_status() return values: */

#define FDELAY_FREE_RUNNING	  0x10		/* local oscillator is free running */
#define FDELAY_WR_OFFLINE	  0x8		/* attached WR core is offline */
#define FDELAY_WR_READY 	  0x1		/* attached WR core is synchronized, we can sync the fine delay core anytime */
#define FDELAY_WR_SYNCING 	  0x2		/* local oscillator is being synchronized with WR clock */
#define FDELAY_WR_SYNCED   	  0x4		/* we are synced. */
#define FDELAY_WR_NOT_PRESENT	  0x20		/* No WR Core present */

/* fdelay_configure_sync() flags */

#define FDELAY_SYNC_LOCAL 	 0x1  	 	/* use local oscillator */
#define FDELAY_SYNC_WR	 	 0x2		/* use White Rabbit */

/* fdelay_init() flags */
#define FDELAY_RAW_READOUT 	0x1
#define FDELAY_PERFORM_LONG_TESTS 0x2

/* Hardware "handle" structure */
typedef struct fdelay_device
{
  /* Base address of the FD core (relative to the beginning of local writel/readl address spaces) */
  uint32_t base_addr; 

  /* Bus-specific readl/writel functions - so the same library can be used both with
     RawRabbit, VME and Etherbone backends */
  void (*writel)(void *priv, uint32_t data, uint32_t addr);
  uint32_t (*readl)(void *priv, uint32_t addr);
  
  void *priv_fd; /* pointer to Fine Delay library private data */
  void *priv_io; /* pointer to the I/O routines private data */
} fdelay_device_t;

typedef struct {
  int64_t utc, utc_sh;
  int32_t coarse, coarse_sh;
  int32_t start_offset;
  int32_t subcycle_offset;
  int32_t frac;
  uint32_t tsbcr;
} fdelay_raw_time_t;

typedef struct 
{
  int64_t utc; /* TAI seconds */ /* FIXME: replace all UTCs with TAIs or seconds for clarity */
  int32_t coarse; /* 125 MHz counter cycles */
  int32_t frac; /* Fractional part (<8ns) */
  uint16_t seq_id; /* Sequence ID to detect missed timestamps */

  fdelay_raw_time_t raw;
} fdelay_time_t;

/* 
--------------------
PUBLIC API 
--------------------
*/


/* Allocates and returns a pointer to a new fdelay_device_t structure. */
fdelay_device_t *fdelay_create();

//TODO: write full description
/* Opens a device using location string. Fill in more info. */
int fdelay_probe(fdelay_device_t *dev, const char *location);

//TODO: add description
int  fdelay_configure_sync(fdelay_device_t*, int);
//int fdelay_configure_output(fdelay_device_t*, int, int, int, int, int, int);
int fdelay_configure_output(fdelay_device_t *dev, int channel, int enable, int64_t delay_ps, int64_t width_ps, int64_t delta_ps, int rep_count);


/* Creates a local instance of Fine Delay Core at address base_addr on the SPEC at bus/devfn. Returns 0 on success, negative on error. */
int spec_fdelay_create_bd(fdelay_device_t *dev, int bus, int dev_fn, uint32_t base);

/* A shortcut for test program, parsing the card base/location from command line args */
int spec_fdelay_create(fdelay_device_t *dev, int argc, char *argv[]);

/* Helper functions - converting FD timestamp format from/to plain picoseconds */
fdelay_time_t fdelay_from_picos(const uint64_t ps);
int64_t fdelay_to_picos(const fdelay_time_t t);

/* Enables/disables raw timestamp readout mode (debugging only) */
int fdelay_raw_readout(fdelay_device_t *dev, int raw_moide);

/* Initializes and calibrates the device. 0 = success, negative = error */
int fdelay_init(fdelay_device_t *dev, int init_flags);

/* Disables and releases the resources for a given FD Card */
int fdelay_release(fdelay_device_t *dev);

/* Returns an explaination of the last error occured on device dev (TBI) */
char *fdelay_strerror(fdelay_device_t *dev);

/* Sets the timing reference for the card (ref source). Currently there are two choices:
- FDELAY_SYNC_LOCAL 	- use local oscillator 
- FDELAY_SYNC_WR	- use White Rabbit */
int fdelay_set_timing_reference(fdelay_device_t *dev, int ref_source);

/* Polls the current status of the timing source. Returns a combination of 
   .... SYNCED flags. wait_mask can enable/disable waiting for a change of 
   a particular flag or set of flags. For example, calling

   fdelay_get_timing_status(dev, FDELAY_WR_SYNCED) will wait until a change of
   FDELAY_WR_SYNCED bit. */
int fdelay_get_timing_status(fdelay_device_t *dev, int wait_mask);

/* Configures the trigger input (TDC/Delay modes). enable enables the input,
   termination switches on/off the built-in 50 Ohm termination resistor */
   
int fdelay_configure_trigger(fdelay_device_t *dev, int enable, int termination);

/* Configures timestamp buffer capture: enable = TS buffer enabled, channel mask: 
   channels to time tag (bit 0 = TDC, bits 1..4 = outputs 1..4) */

int fdelay_configure_capture (fdelay_device_t *dev, int enable, int channel_mask);

/* Reads how_many timestamps from the buffer. Blocking */
/* TODO: non-blocking version? */
int fdelay_read (fdelay_device_t *dev, fdelay_time_t *timestamps, int how_many);


/* (delay mode only) Configures output(s) selected in channel_mask to work in delay mode. Delta_ps = spacing between
the rising edges of subsequent pulses. */
int fdelay_configure_delay (fdelay_device_t *dev, int channel_mask, int enable, int64_t delay_ps, int64_t width_ps, int64_t delta_ps, int repeat_count);

/* (pulse mode only)  Configures output(s) selected in channel_mask to produce pulse(s) starting at (start) with appropriate width/spacing/repeat_count */
int fdelay_configure_pulse_gen(fdelay_device_t *dev, int channel_mask, int enable, fdelay_time_t start, int64_t width_ps, int64_t delta_ps, int repeat_count);


/* (pulse mode only) Returns non-0 when all of the channels in channel mask have produced their programmed pulses */
int fdelay_outputs_triggered(fdelay_device_t *dev, int channel_mask, int blocking);

void fdelay_set_user_offset(fdelay_device_t *dev,int input, int64_t offset);

int fdelay_get_time(fdelay_device_t *dev, fdelay_time_t *t);
int fdelay_set_time(fdelay_device_t *dev, const fdelay_time_t t);

int fdelay_dmtd_calibration(fdelay_device_t *dev, double *offsets);

#endif
