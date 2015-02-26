DESCRIPTION = "sopcinfo reader and info extractor"
LICENSE = "LGPLv2"
PR = "r5"

SRCREV="3061e31c22c5926363fd895dfd3a4ed5c422b595"

SRC_URI = "git://github.com/wgoossens/sopc2dts.git"
SRC_URI += "file://sopc2dts"

BBCLASSEXTEND += " native "
LIC_FILES_CHKSUM = "file://COPYING;md5=0ab292053990244832d0799bd6d95975"

S = "${WORKDIR}/git/"

PARALLEL_MAKE=""

do_compile() {
	oe_runmake
}

do_install() {
        install -d ${D}${bindir}
        install -m 0755 ../sopc2dts ${D}${bindir}
        install -m 0755 sopc2dts.jar ${D}${bindir}
}

