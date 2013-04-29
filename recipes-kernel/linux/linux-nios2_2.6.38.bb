FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
DESCRIPTION = "Nios2 Kernel"
require recipes-kernel/linux/linux-sopcinfo.inc

SRCREV="f13e07cb5bfa0e783d370a1133cfd6b513b89717"

LINUX_VERSION_EXTENSION = "-nios2"

PR = "r1"

S = "${WORKDIR}/git"
