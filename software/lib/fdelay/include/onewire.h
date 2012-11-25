#ifndef ONEWIRE_H_INCLUDED
#define ONEWIRE_H_INCLUDED

#include "fdelay_lib.h"

int ds18x_init(fdelay_device_t *dev);
int ds18x_read_temp(fdelay_device_t *dev, int *temp_r);


#endif // ONEWIRE_H_INCLUDED
