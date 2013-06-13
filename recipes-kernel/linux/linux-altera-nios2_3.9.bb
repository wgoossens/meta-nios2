FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}/${PV}:"
require recipes-kernel/linux/linux-altera-nios2.inc
DEFAULT_PREFERENCE = "-1"

SRCREV="8580d1d741d105b055658a9ee0a3e5db64919b15"
ALT_SOCFPGA_BRANCH="socfpga-3.7"
SRC_URI_nios2 += "file://add_ioread32be_and_friends.patch"

PR = "r1"
