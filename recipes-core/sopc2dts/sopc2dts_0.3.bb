DESCRIPTION = "sopcinfo reader and info extractor"
LICENSE = "LGPLv2"
PR = "r0"

SRCREV="92886345b4506ef0f1645568e118a291ddc14711"
SRC_URI = "git://sopc.et.ntust.edu.tw/git/tools.git"
SRC_URI += "file://sopc2dts"

BBCLASSEXTEND += " native "
LIC_FILES_CHKSUM = "file://COPYING;md5=0ab292053990244832d0799bd6d95975"

S = "${WORKDIR}/git/sopc2dts"

PARALLEL_MAKE=""

do_compile() {
	oe_runmake
}

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ../../sopc2dts ${D}${bindir}
        install -m 0755 sopc2dts.jar ${D}${bindir}
}

