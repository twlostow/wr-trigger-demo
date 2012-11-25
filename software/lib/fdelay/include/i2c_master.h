#ifndef __I2C_MASTER_H
#define __I2C_MASTER_H

#include <stdint.h>

#include "fdelay_lib.h"

void mi2c_init(fdelay_device_t *dev);
int eeprom_read(fdelay_device_t *dev, uint8_t i2c_addr, uint32_t offset, uint8_t *buf, size_t size);
int eeprom_write(fdelay_device_t *dev, uint8_t i2c_addr, uint32_t offset, uint8_t *buf, size_t size);

#endif
