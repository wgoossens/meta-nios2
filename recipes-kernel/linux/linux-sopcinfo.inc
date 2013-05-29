SECTION = "kernel"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM="file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"


SRC_URI_nios2 = " git://sopc.et.ntust.edu.tw/git/linux-2.6.git;protocol=git;branch=nios2"
#SRC_URI_nios2 = " git://github.com/tklauser/linux-nios2.git;protocol=git;branch=nios2"
SRC_URI_nios2 += "file://defconfig"

COMPATIBLE_MACHINE = "(neek|ghrd3c120|nios2custom)"

LINUX_VERSION = "${PV}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "1"

inherit kernel

DEPENDS += "sopc2dts-native"

do_generate_devicetree() {
  sopc2dts -i ${SOPCINFO_FILE} -b ${BOARDINFO_FILE} -t dts -o nios2-custom.dts
}

addtask generate_devicetree after do_unpack before do_configure
