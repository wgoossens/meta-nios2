FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"

require recipes-kernel/linux/linux-nios2-tune.inc
require recipes-kernel/linux/linux-sopcinfo.inc

DEPENDS_append_nios2 = " libgcc"

SRC_URI_nios2 = " git://github.com/altera-opensource/linux-socfpga.git;protocol=https;branch=${ALT_SOCFPGA_BRANCH}"
SRC_URI_nios2 += "file://defconfig"

S = "${WORKDIR}/git"
