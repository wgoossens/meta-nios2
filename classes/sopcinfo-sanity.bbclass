
def validateSopcinfo(bb,d):
    from xml.dom import minidom
    mmuFound = '0';
    hwDivFound = '0';
    hwMulFound = '0';
    hwMulXFound = '0';    
    features = (d.getVar("TUNE_FEATURES", True) or "").split()
    xmldoc = minidom.parse(d.getVar("SOPCINFO_FILE",True));
    itemlist = xmldoc.getElementsByTagName('module') 
    for s in itemlist :
        if (s.attributes['kind'].value == 'altera_nios2') | (s.attributes['kind'].value == 'altera_nios2_qsys'):
            print s.attributes['name'].value + ", " + s.attributes['kind'].value
            assignments = s.getElementsByTagName('assignment');
            for a in assignments :
                assName = a.getElementsByTagName('name')[0].firstChild.nodeValue;
                if assName == 'embeddedsw.CMacro.CPU_IMPLEMENTATION' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue != '"fast"' :
                        bb.error('NiosII configuration ' + a.getElementsByTagName('value')[0].firstChild.nodeValue + ' is not supported');
                elif assName == 'embeddedsw.CMacro.HARDWARE_DIVIDE_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwDivFound = '1';
                elif assName == 'embeddedsw.CMacro.HARDWARE_MULTIPLY_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwMulFound = '1';
                elif assName == 'embeddedsw.CMacro.HARDWARE_MULX_PRESENT' :
                    if a.getElementsByTagName('value')[0].firstChild.nodeValue == '1' :
                        hwMulXFound = '1';
                elif assName == 'embeddedsw.CMacro.MMU_PRESENT' :
                    mmuFound = '1';

    if mmuFound == '0':
        bb.error("No MMU found. Yocto currently only supports MMU builds");

    if hwMulFound == '0':
        if 'hw-mul' in features:
            bb.error("Hardware Multiply enabled in TUNE_FEATURES but hw does not seem to support this");
    else:
        if not 'hw-mul' in features:
            bb.note("Hardware Multiply present but not enabled using TUNE_FEATURES.");

    if hwMulXFound == '0':
        if 'hw-mulx' in features:
            bb.error("Hardware Multiply Extended enabled in TUNE_FEATURES but hw does not seem to support this");
    else:
        if not 'hw-mulx' in features:
            bb.note("Hardware Multiply Extended present but not enabled using TUNE_FEATURES.");
        
    if hwDivFound == '0':
        if 'hw-div' in features:
            bb.error("Hardware Divide enabled in TUNE_FEATURES but hw does not seem to support this");
    else:
        if not 'hw-div' in features:
            bb.note("Hardware Divide present but not enabled using TUNE_FEATURES.");

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

