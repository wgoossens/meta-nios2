require recipes-kernel/linux/linux-nios2-tune.inc
require recipes-kernel/linux/linux-sopcinfo.inc

SRC_URI_nios2 = " git://sopc.et.ntust.edu.tw/git/linux-2.6.git;protocol=git;branch=nios2"
#SRC_URI_nios2 = " git://github.com/tklauser/linux-nios2.git;protocol=git;branch=nios2"
SRC_URI_nios2 += "file://defconfig"
