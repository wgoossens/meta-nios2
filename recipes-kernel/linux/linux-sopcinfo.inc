DEPENDS += "sopc2dts-native"

do_generate_devicetree() {
  sopc2dts -i ${SOPCINFO_FILE} -b ${BOARDINFO_FILE} -t dts -o nios2-custom.dts
}

addtask generate_devicetree after do_unpack before do_configure
