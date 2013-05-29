FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc
require recipes-kernel/linux/linux-nios2.inc

SRCREV="adde9fed4805668de88ea9e31eeb76f981fda34c"

SRC_URI_nios2 = " git://git.rocketboards.org/linux-socfpga.git;protocol=git;branch=socfpga-3.7"
SRC_URI_nios2 += "file://fix-kvm-para-include.patch"
SRC_URI_nios2 += "file://defconfig"


PR = "r0"

S = "${WORKDIR}/git"
