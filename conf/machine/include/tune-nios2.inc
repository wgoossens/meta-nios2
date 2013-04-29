#@TYPE: Machine configuration
#@NAME: nios2
DEFAULTTUNE ?= "nios2"
require conf/machine/include/nios2/arch-nios2.inc

TARGET_FPU ?= "soft"
