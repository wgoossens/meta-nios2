FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
require recipes-kernel/linux/linux-altera-nios2.inc
DEFAULT_PREFERENCE = "-1"

SRCREV="35f3b25059058b29818a0a7200be6ef97ce55330"
ALT_SOCFPGA_BRANCH="socfpga-3.8"
SRC_URI_nios2 += "file://add_ioread32be_and_friends.patch"

PR = "r1"
