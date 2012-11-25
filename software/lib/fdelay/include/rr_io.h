#ifndef __RR_IO_H
#define __RR_IO_H

#include <stdint.h>
#include <rawrabbit.h>

int rr_bind(int a_fd);
int rr_init(int bus, int devfn);
int rr_writel(uint32_t data, uint32_t addr);
uint32_t rr_readl(uint32_t addr);
int rr_load_bitstream(const void *data, int size8);
int rr_load_bitstream_from_file(const char *file_name);

#endif

