# This class integrates real-time license scanning, generation of SPDX standard
# output and verifiying license info during the building process.
# It is a combination of efforts from the OE-Core, SPDX and Fossology projects.
#
# For more information on FOSSology:
#   http://www.fossology.org
#
# For more information on FOSSologySPDX commandline:
#   https://github.com/spdx-tools/fossology-spdx/wiki/Fossology-SPDX-Web-API
#
# For more information on SPDX:
#   http://www.spdx.org
#

# SPDX file will be output to the path which is defined as[SPDX_MANIFEST_DIR] 
# in ./meta/conf/licenses.conf.

SPDXOUTPUTDIR = "${WORKDIR}/spdx_output_dir"
SPDXSSTATEDIR = "${WORKDIR}/spdx_sstate_dir"
DOSOCS_PATH = "/home/tgurney/DoSOCS/DoSOCS/DoSPDX.py"

python do_spdx () {
    import os
    import sys
    import subprocess

    info = {} 
    info['workdir'] = (d.getVar('WORKDIR', True) or "")
    info['sourcedir'] = (d.getVar('S', True) or "")
    info['pn'] = (d.getVar( 'PN', True ) or "")
    info['pv'] = (d.getVar( 'PV', True ) or "")
    info['src_uri'] = (d.getVar( 'SRC_URI', True ) or "")
    manifest_dir = (d.getVar('SPDX_MANIFEST_DIR', True) or "")
    info['outfile'] = os.path.join(manifest_dir, info['pn'] + ".spdx" )
    info['spdx_temp_dir'] = (d.getVar('SPDX_TEMP_DIR', True) or "")
    info['tar_file'] = os.path.join( info['workdir'], info['pn'] + ".tar.gz" )
    info['dosocs'] = (d.getVar('DOSOCS_PATH', True) or "")

    create_tarball(info)

    dosocs_cmdline = [info['dosocs'], '--scan', '-p', info['tar_file'],
                        '--scanOption', 'fossology', '--print', 'json']
    spdxdata = subprocess.check_output(dosocs_cmdline)

    ## CREATE MANIFEST
    if not os.path.isdir(manifest_dir):
        bb.mkdirhier(manifest_dir)
    create_manifest(info,spdxdata)

    ## clean up the temp stuff
    try:
        os.remove(info['tar_file'])
    except OSError:
        pass
}
addtask spdx after do_patch before do_configure

def create_manifest(info, spdxdata):
    with open(info['outfile'], 'w') as f:
        f.write(spdxdata + '\n')

def create_tarball(info):
    import tarfile
    with tarfile.open( info['tar_file'], "w:gz" ) as t:
        t.add(info['sourcedir'], arcname=os.path.basename(info['sourcedir']))

