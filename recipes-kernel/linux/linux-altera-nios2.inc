FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"

require recipes-kernel/linux/linux-nios2-tune.inc
require recipes-kernel/linux/linux-sopcinfo.inc

SRC_URI_nios2 = " git://git.rocketboards.org/linux-socfpga.git;protocol=git;branch=${ALT_SOCFPGA_BRANCH}"
SRC_URI_nios2 += "file://defconfig"

S = "${WORKDIR}/git"
