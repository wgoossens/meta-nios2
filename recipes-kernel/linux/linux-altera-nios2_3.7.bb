FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc
require recipes-kernel/linux/linux-nios2.inc

SRCREV="06e4136b75d6e38dd8d33b8fe8e9727f63f4e102"

SRC_URI_nios2 = " git://git.rocketboards.org/linux-socfpga.git;protocol=git;branch=socfpga-3.7"
SRC_URI_nios2 += "file://defconfig"


PR = "r1"

S = "${WORKDIR}/git"
