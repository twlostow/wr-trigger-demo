#ifndef __TRIG_DIST_H
#define __TRIG_DIST_H

#include <stdio.h>
#include <stdint.h>

struct ttd_timestamp {
	int64_t seconds;
	int64_t picoseconds;
	
	struct {
		uint64_t seconds;
		uint32_t cycles;
		uint32_t frac;
	} hw;
};

struct ttd_input {
	uint32_t base_addr;
	
	int enabled;
	int assigned_id;
	int pulse_count;
	
	struct ttd_timestamp ts_adjust;
};

struct ttd_card {
	void *context;
	uint32_t base_addr;

	int num_inputs;
	int num_outputs;
	
	struct ttd_input *inputs;
};

#endif
