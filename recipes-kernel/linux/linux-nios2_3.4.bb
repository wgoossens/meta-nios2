FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc
require recipes-kernel/linux/linux-nios2.inc

SRCREV="75d489eb799ddd26eec9e9aa5492266d2cfd794d"

PR = "r2"

S = "${WORKDIR}/git"
