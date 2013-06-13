FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
require recipes-kernel/linux/linux-altera-nios2.inc

SRCREV="06e4136b75d6e38dd8d33b8fe8e9727f63f4e102"
ALT_SOCFPGA_BRANCH="socfpga-3.7"

PR = "r1"

