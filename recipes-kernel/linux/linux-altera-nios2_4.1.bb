FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
require recipes-kernel/linux/linux-altera-nios2.inc

SRCREV="801a40f1332935a477df6a4788cf0b3089429ee8"
ALT_SOCFPGA_BRANCH="socfpga-3.10-ltsi"

PR = "r1"
