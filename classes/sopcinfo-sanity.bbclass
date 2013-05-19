
def raise_sopcinfo_sanity_error(msg, d):
    if d.getVar("SANITY_USE_EVENTS", True) == "1":
        try:
            bb.event.fire(bb.event.SanityCheckFailed(msg, False), d)
        except TypeError:
            bb.event.fire(bb.event.SanityCheckFailed(msg), d)
        return

    bb.fatal(""" OE-core's sopcinfo sanity checker detected a potential misconfiguration.
    Either fix the cause of this error or at your own risk disable the checker.
    Following is the list of potential problems / advisories:

    %s""" % msg)

def validateSopcinfo(bb,d):
    from xml.dom import minidom
    cpuFound = False
    mmuFound = '0'
    hwDivFound = '0'
    hwMulFound = '0'
    hwMulXFound = '0'
    fpuFound = '0'
    messages = ""
    features = (d.getVar("TUNE_FEATURES", True) or "").split()
    xmldoc = minidom.parse(d.getVar("SOPCINFO_FILE",True))
    itemlist = xmldoc.getElementsByTagName('module')
    for s in itemlist :
        if (s.attributes['kind'].value == 'altera_nios2') | (s.attributes['kind'].value == 'altera_nios2_qsys'):
            cpuFound = True
            assignments = s.getElementsByTagName('assignment')
            for a in assignments :
                assName = a.getElementsByTagName('name')[0].firstChild.nodeValue
                if assName == 'embeddedsw.CMacro.CPU_IMPLEMENTATION' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue != '"fast"' :
                        messages = messages + 'NiosII configuration ' + a.getElementsByTagName('value')[0].firstChild.nodeValue + ' is not supported\n'
                elif assName == 'embeddedsw.CMacro.HARDWARE_DIVIDE_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwDivFound = '1'
                elif assName == 'embeddedsw.CMacro.HARDWARE_MULTIPLY_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwMulFound = '1'
                elif assName == 'embeddedsw.CMacro.HARDWARE_MULX_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwMulXFound = '1'
                elif assName == 'embeddedsw.CMacro.MMU_PRESENT' :
                    mmuFound = '1'
        elif s.attributes['kind'].value == 'altera_nios_custom_instr_floating_point':
            assignments = s.getElementsByTagName('assignment')
            for a in assignments :
                assName = a.getElementsByTagName('name')[0].firstChild.nodeValue;
                if assName == 'embeddedsw.configuration.useDivider' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '0' :
                        fpuFound = '60-1'
                    else:
                        fpuFound = '60-2'

    if cpuFound == False:
        messages = messages + "No Nios2 CPU found. That's bad.\n"

    if mmuFound == '0':
        messages = messages + "No MMU found. Yocto currently only supports MMU builds\n"

    if hwMulFound == '0':
        if 'hw-mul' in features:
            messages = messages + "Hardware Multiply enabled in TUNE_FEATURES but hw does not seem to support this\n"
    else:
        if not 'hw-mul' in features:
            bb.note("Hardware Multiply present but not enabled in TUNE_FEATURES.")

    if hwMulXFound == '0':
        if 'hw-mulx' in features:
            messages = messages + "Hardware Multiply Extended enabled in TUNE_FEATURES but hw does not seem to support this\n"
    else:
        if not 'hw-mulx' in features:
            bb.note("Hardware Multiply Extended present but not enabled in TUNE_FEATURES.")

    if hwDivFound == '0':
        if 'hw-div' in features:
            messages = messages + "Hardware Divide enabled in TUNE_FEATURES but hw does not seem to support this\n"
    else:
        if not 'hw-div' in features:
            bb.note("Hardware Divide present but not enabled in TUNE_FEATURES.")

    if fpuFound == '0':
        if ('fpu-custom' in features) | ('fpu-customdiv' in features):
            messages = messages + "Hard FPU enabled in TUNE_FEATURES but no FPU Custom instructions found"
    elif fpuFound == '60-1':
        if 'fpu-customdiv' in features:
            messages = messages + "Custom instruction FPU does not suport floating point division. Please use 'fpu-custom' instead of 'fpu-customdiv' in TUNE_FEATURES"
        elif not 'fpu-custom' in features:
            bb.note("Custom instruction FPU found but not enabled in TUNE_FEATURES")
    elif fpuFound == '60-2':
        if 'fpu-custom' in features:
            bb.note("Custom instruction FPU suports floating point division. Consider using 'fpu-customdiv' instead of 'fpu-custom' in TUNE_FEATURES")
        elif not 'fpu-customdiv' in features:
            bb.note("Custom instruction FPU with floating point division found but not enabled in TUNE_FEATURES")
    if not messages == "":
        raise_sopcinfo_sanity_error(messages, d)

addhandler check_sopcinfo_sanity_eventhandler
python check_sopcinfo_sanity_eventhandler() {
    if bb.event.getName(e) == "ConfigParsed" and e.data.getVar("BB_WORKERCONTEXT", True) != "1" and e.data.getVar("DISABLE_SANITY_CHECKS", True) != "1":
        sanity_data = copy_data(e)
        validateSopcinfo(bb, sanity_data);
    elif bb.event.getName(e) == "SanityCheck":
        sanity_data = copy_data(e)
        sanity_data.setVar("SANITY_USE_EVENTS", "1")
        check_sanity(sanity_data)
        bb.event.fire(bb.event.SanityCheckPassed(), e.data)

    return
}

