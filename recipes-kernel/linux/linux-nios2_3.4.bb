FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc

SRCREV="75d489eb799ddd26eec9e9aa5492266d2cfd794d"

LINUX_VERSION_EXTENSION = "-nios2"

PR = "r1"

S = "${WORKDIR}/git"
