#
# Copyright (c) 2013-2017, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

PLAT_INCLUDES		:=	-Iinclude/common/tbbr			\
				-Iinclude/plat/arm/common/		\
				-Iinclude/plat/arm/common/aarch64/	\
				-Iplat/kvim2/include

PLAT_BL_COMMON_SOURCES	:=	drivers/console/aarch64/console.S	\
				drivers/ti/uart/aarch64/16550_console.S	\
				plat/kvim2/kvim2_common.c

BL1_SOURCES		+=	drivers/io/io_fip.c			\
				drivers/io/io_memmap.c			\
				drivers/io/io_storage.c			\
				lib/cpus/aarch64/cortex_a53.S		\
				plat/common/aarch64/platform_mp_stack.S	\
				plat/kvim2/aarch64/plat_helpers.S	\
				plat/kvim2/kvim2_bl1_setup.c		\
				plat/kvim2/kvim2_io_storage.c

BL2_SOURCES		+=	common/desc_image_load.c		\
				drivers/io/io_fip.c			\
				drivers/io/io_memmap.c			\
				drivers/io/io_storage.c			\
				plat/common/aarch64/platform_mp_stack.S	\
				plat/kvim2/aarch64/plat_helpers.S	\
				plat/kvim2/aarch64/kvim2_bl2_mem_params_desc.c \
				plat/kvim2/kvim2_bl2_setup.c		\
				plat/kvim2/kvim2_image_load.c		\
				plat/kvim2/kvim2_io_storage.c

BL31_SOURCES		+=	lib/cpus/aarch64/cortex_a53.S		\
				plat/common/aarch64/plat_psci_common.c	\
				plat/kvim2/aarch64/plat_helpers.S	\
				plat/kvim2/kvim2_bl31_setup.c		\
				plat/kvim2/kvim2_pm.c			\
				plat/kvim2/kvim2_topology.c

# Translation tables library
include lib/xlat_tables_v2/xlat_tables.mk

PLAT_BL_COMMON_SOURCES	+=	${XLAT_TABLES_LIB_SRCS}

# Tune compiler for Cortex-A53
ifeq ($(notdir $(CC)),armclang)
    TF_CFLAGS_aarch64	+=	-mcpu=cortex-a53
else ifneq ($(findstring clang,$(notdir $(CC))),)
    TF_CFLAGS_aarch64	+=	-mcpu=cortex-a53
else
    TF_CFLAGS_aarch64	+=	-mtune=cortex-a53
endif

# Build config flags
# ------------------

# Enable all errata workarounds for Cortex-A53
ERRATA_A53_826319		:= 1
ERRATA_A53_835769		:= 1
ERRATA_A53_836870		:= 1
ERRATA_A53_843419		:= 1
ERRATA_A53_855873		:= 1

# Disable the PSCI platform compatibility layer by default
ENABLE_PLAT_COMPAT		:= 0

# Enable reset to BL31 by default
RESET_TO_BL31			:= 1

# Have different sections for code and rodata
SEPARATE_CODE_AND_RODATA	:= 1

# Use Coherent memory
USE_COHERENT_MEM		:= 1

# Enable new version of image loading
LOAD_IMAGE_V2			:= 1

# Platform build flags
# --------------------

# BL33 images are in AArch64 by default
KVIM2_BL33_IN_AARCH32		:= 0

# BL32 location
KVIM2_BL32_RAM_LOCATION	:= tdram
ifeq (${KVIM2_BL32_RAM_LOCATION}, tsram)
  KVIM2_BL32_RAM_LOCATION_ID = SEC_SRAM_ID
else ifeq (${KVIM2_BL32_RAM_LOCATION}, tdram)
  KVIM2_BL32_RAM_LOCATION_ID = SEC_DRAM_ID
else
  $(error "Unsupported KVIM2_BL32_RAM_LOCATION value")
endif

# Process platform flags
# ----------------------

$(eval $(call add_define,KVIM2_BL32_RAM_LOCATION_ID))
$(eval $(call add_define,KVIM2_BL33_IN_AARCH32))

# Verify build config
# -------------------

ifneq (${LOAD_IMAGE_V2}, 1)
  $(error Error: kvim2 needs LOAD_IMAGE_V2=1)
endif

ifeq (${ARCH},aarch32)
  $(error Error: AArch32 not supported on kvim2)
endif
