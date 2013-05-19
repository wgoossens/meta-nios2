LINUX_VERSION_EXTENSION = "-nios2"

# Force machine Tunings in kernel config
do_configure_prepend() {
    sed -i -e /CONFIG_NIOS2_HW_MUL_SUPPORT/d ${WORKDIR}/defconfig 
    sed -i -e /CONFIG_NIOS2_HW_MULX_SUPPORT/d ${WORKDIR}/defconfig 
    sed -i -e /CONFIG_NIOS2_HW_DIV_SUPPORT/d ${WORKDIR}/defconfig 
    sed -i -e /CONFIG_NIOS2_FPU_SUPPORT/d ${WORKDIR}/defconfig 
    echo "${@base_contains('TUNE_FEATURES', 'hw-mul',  'CONFIG_NIOS2_HW_MUL_SUPPORT=y', '#CONFIG_NIOS2_HW_MUL_SUPPORT is not set', d)}" >> ${WORKDIR}/defconfig
    echo "${@base_contains('TUNE_FEATURES', 'hw-mulx', 'CONFIG_NIOS2_HW_MULX_SUPPORT=y',   '#CONFIG_NIOS2_HW_MULX_SUPPORT is not set', d)}" >> ${WORKDIR}/defconfig
    echo "${@base_contains('TUNE_FEATURES', 'hw-div',  'CONFIG_NIOS2_HW_DIV_SUPPORT=y',    '#CONFIG_NIOS2_HW_DIV_SUPPORT is not set', d)}" >> ${WORKDIR}/defconfig
    echo "${@base_contains('TUNE_FEATURES', 'fpu-custom', 'CONFIG_NIOS2_FPU_SUPPORT=y',    '#CONFIG_NIOS2_FPU_SUPPORT is not set', d)}" >> ${WORKDIR}/defconfig
    echo "${@base_contains('TUNE_FEATURES', 'fpu-customdiv', 'CONFIG_NIOS2_FPU_SUPPORT=y', '#CONFIG_NIOS2_FPU_SUPPORT is not set', d)}" >> ${WORKDIR}/defconfig
}

