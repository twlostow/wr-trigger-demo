/*
  Register definitions for slave core: Trigger shared module

  * File           : ../../software/include/hw/trigger_shared_regs.h
  * Author         : auto-generated by wbgen2 from trigger_shared_wb.wb
  * Created        : Thu Mar 14 23:42:50 2013
  * Standard       : ANSI C

    THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE trigger_shared_wb.wb
    DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!

*/

#ifndef __WBGEN2_REGDEFS_TRIGGER_SHARED_WB_WB
#define __WBGEN2_REGDEFS_TRIGGER_SHARED_WB_WB

#include <inttypes.h>

#if defined( __GNUC__)
#define PACKED __attribute__ ((packed))
#else
#error "Unsupported compiler?"
#endif

#ifndef __WBGEN2_MACROS_DEFINED__
#define __WBGEN2_MACROS_DEFINED__
#define WBGEN2_GEN_MASK(offset, size) (((1<<(size))-1) << (offset))
#define WBGEN2_GEN_WRITE(value, offset, size) (((value) & ((1<<(size))-1)) << (offset))
#define WBGEN2_GEN_READ(reg, offset, size) (((reg) >> (offset)) & ((1<<(size))-1))
#define WBGEN2_SIGN_EXTEND(value, bits) (((value) & (1<<bits) ? ~((1<<(bits))-1): 0 ) | (value))
#endif


/* definitions for register: CR */

/* definitions for field: Configured in reg: CR */
#define TTS_CR_CONFIGURED                     WBGEN2_GEN_MASK(0, 1)

/* definitions for field: Clear Trigger Detection Buffer in reg: CR */
#define TTS_CR_CLEAR_TDB                      WBGEN2_GEN_MASK(1, 1)

/* definitions for register: Firmware ID */

/* definitions for field: FW Type in reg: Firmware ID */
#define TTS_IDR_FW_ID_MASK                    WBGEN2_GEN_MASK(0, 8)
#define TTS_IDR_FW_ID_SHIFT                   0
#define TTS_IDR_FW_ID_W(value)                WBGEN2_GEN_WRITE(value, 0, 8)
#define TTS_IDR_FW_ID_R(reg)                  WBGEN2_GEN_READ(reg, 0, 8)
/* definitions for RAM: Trigger Detection Buffer */
#define TTS_TDB_RAM_BASE 0x00000200 /* base address */                                
#define TTS_TDB_RAM_BYTES 0x00000200 /* size in bytes */                               
#define TTS_TDB_RAM_WORDS 0x00000080 /* size in 32-bit words, 32-bit aligned */        
/* [0x0]: REG CR */
#define TTS_REG_CR 0x00000000
/* [0x4]: REG Firmware ID */
#define TTS_REG_IDR 0x00000004
#endif
