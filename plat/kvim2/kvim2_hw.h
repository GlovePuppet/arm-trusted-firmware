/*
 * Copyright (c) 2016-2017, ARM Limited and Contributors. All rights reserved.
 *
 * SPDX-License-Identifier: BSD-3-Clause
 */

#ifndef __KVIM2_HW__
#define __KVIM2_HW__

#include <utils_def.h>

/*
 * Peripherals
 */

#define KVIM2_IO_BASE			ULL(0x3F000000)
#define KVIM2_IO_SIZE			ULL(0x01000000)

/*
 * Serial port (called 'Mini UART' in the BCM docucmentation).
 */
#define KVIM2_IO_MINI_UART_OFFSET	ULL(0x00215040)
#define KVIM2_MINI_UART_BASE		(KVIM2_IO_BASE + KVIM2_IO_MINI_UART_OFFSET)
#define KVIM2_MINI_UART_CLK_IN_HZ	ULL(500000000)

/*
 * Power management, reset controller, watchdog.
 */
#define KVIM2_IO_PM_OFFSET		ULL(0x00100000)
#define KVIM2_PM_BASE			(KVIM2_IO_BASE + KVIM2_IO_PM_OFFSET)
/* Registers on top of KVIM2_PM_BASE. */
#define KVIM2_PM_RSTC_OFFSET		ULL(0x0000001C)
#define KVIM2_PM_WDOG_OFFSET		ULL(0x00000024)
/* Watchdog constants */
#define KVIM2_PM_PASSWORD		ULL(0x5A000000)
#define KVIM2_PM_RSTC_WRCFG_MASK		ULL(0x00000030)
#define KVIM2_PM_RSTC_WRCFG_FULL_RESET	ULL(0x00000020)

/*
 * Local interrupt controller
 */
#define KVIM2_INTC_BASE_ADDRESS			ULL(0x40000000)
/* Registers on top of KVIM2_INTC_BASE_ADDRESS */
#define KVIM2_INTC_CONTROL_OFFSET		ULL(0x00000000)
#define KVIM2_INTC_PRESCALER_OFFSET		ULL(0x00000008)
#define KVIM2_INTC_MBOX_CONTROL_OFFSET		ULL(0x00000050)
#define KVIM2_INTC_MBOX_CONTROL_SLOT3_FIQ	ULL(0x00000080)
#define KVIM2_INTC_PENDING_FIQ_OFFSET		ULL(0x00000070)
#define KVIM2_INTC_PENDING_FIQ_MBOX3		ULL(0x00000080)

#endif /* __KVIM2_HW__ */
