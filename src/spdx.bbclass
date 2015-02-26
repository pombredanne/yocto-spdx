# This class integrates real-time license scanning, generation of SPDX standard
# output and verifiying license info during the building process.
# It is a combination of efforts from the OE-Core, SPDX and DoSOCS projects.
#
# For more information on DoSOCS:
#   https://github.com/socs-dev-env/DoSOCS
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

    workdir = (d.getVar('WORKDIR', True) or "")
    sourcedir = (d.getVar('S', True) or "")
    manifest_dir = (d.getVar('SPDX_MANIFEST_DIR', True) or "")
    pn = (d.getVar('PN', True) or "")
    outfile = os.path.join(manifest_dir, pn + ".spdx")
    tar_file = os.path.join(workdir, pn + ".tar.gz")
    dosocs = (d.getVar('DOSOCS_PATH', True) or "")

    create_tarball(info)

    dosocs_cmdline = [dosocs, '--scan', '-p', tar_file,
                        '--scanOption', 'fossology', '--print', 'json']
    spdxdata = subprocess.check_output(dosocs_cmdline)

    ## CREATE MANIFEST
    if not os.path.isdir(manifest_dir):
        bb.mkdirhier(manifest_dir)
    with open(outfile, 'w') as f:
        f.write(spdxdata + '\n')

    ## clean up the temp stuff
    try:
        os.remove(tar_file)
    except OSError:
        pass
}
addtask spdx after do_patch before do_configure

def create_tarball(tar_file, sourcedir):
    import tarfile
    with tarfile.open(tar_file, "w:gz" ) as t:
        t.add(sourcedir, arcname=os.path.basename(sourcedir))

