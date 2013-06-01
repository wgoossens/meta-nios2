FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc
require recipes-kernel/linux/linux-nios2.inc

SRCREV="8580d1d741d105b055658a9ee0a3e5db64919b15"

SRC_URI_nios2 = " git://git.rocketboards.org/linux-socfpga.git;protocol=git;branch=socfpga-3.9"
SRC_URI_nios2 += "file://add_ioread32be_and_friends.patch"
SRC_URI_nios2 += "file://defconfig"


PR = "r0"

S = "${WORKDIR}/git"
