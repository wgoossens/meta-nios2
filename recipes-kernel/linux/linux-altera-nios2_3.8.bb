FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc
require recipes-kernel/linux/linux-nios2.inc

SRCREV="35f3b25059058b29818a0a7200be6ef97ce55330"

SRC_URI_nios2 = " git://git.rocketboards.org/linux-socfpga.git;protocol=git;branch=socfpga-3.8"
SRC_URI_nios2 += "file://add_ioread32be_and_friends.patch"
SRC_URI_nios2 += "file://defconfig"


PR = "r0"

S = "${WORKDIR}/git"
