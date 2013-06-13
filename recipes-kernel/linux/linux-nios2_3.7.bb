FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-nios2.inc

SRCREV="1a95f22c76be155997c6ae6e8438f84089d5fcce"

PR = "r1"

S = "${WORKDIR}/git"
