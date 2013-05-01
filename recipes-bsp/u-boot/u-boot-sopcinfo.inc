UBOOT_MACHINE_nios2 ?= "nios2-generic"

DEPENDS += "sopc2dts-native"

SRC_URI += "file://add-nios2-custom-board.patch"

do_create_custom_fpga_h() {
  sopc2dts -i ${SOPCINFO_FILE} -b ${BOARDINFO_FILE} -t u-boot -o ${S}/board/altera/nios2-generic/nios2-custom_fpga.h
}

addtask create_custom_fpga_h after do_unpack before do_configure
