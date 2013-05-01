#@TYPE: Machine configuration
#@NAME: nios2
#@DESCRIPTION: generic machine configuration for nios2 with mmu 

DEFAULT_TUNE ?= "nios2"
TUNE_PKGARCH = "${TUNE_PKGARCH_tune-${DEFAULTTUNE}}"
ABIEXTENSION ?= ""

TUNEVALID[fpu-custom] = "Use custom-instruction FPU"

AVAILTUNE += "nios2"
TUNE_FEATURES_tune-nios2 = "fpu-custom"
TUNE_PKGARCH_tune-nios2 = "nios2"
PACKAGE_EXTRA_ARCHS_tune-nios2 = "nios2"

# Set default for common nios2-based machines
MACHINE_FEATURES ?= "kernel26"
# Select an appropriate default kernel

PREFERRED_PROVIDER_virtual/kernel ?= "linux-nios2"

#-------------------------------------------------------------------------------
# Board defaults
#-------------------------------------------------------------------------------
# These values are board specific but they seem to be common to a large number
# of boards so are reasonable defaults.
USE_VT = "0"
UBOOT_MACHINE ?= "nios2-custom"
