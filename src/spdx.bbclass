# SPDX plugin for Yocto Project ('Yocto-SPDX')
#
# This class integrates real-time license scanning and generation of SPDX
# into the build process.
# It is a combination of efforts from the OE-Core, SPDX and DoSOCS projects.
#
# For more information on DoSOCS:
#   https://github.com/socs-dev-env/DoSOCS
#
# For more information on SPDX:
#   http://www.spdx.org
#
# Copyright (c) 2015 Yocto-SPDX contributors.
#
# SPDX-License-Identifier: MIT
#

# SPDX file will be output to the path which is defined as[SPDX_MANIFEST_DIR] 
# in ./meta/conf/licenses.conf.

SPDXOUTPUTDIR = "${WORKDIR}/spdx_output_dir"
SPDXSSTATEDIR = "${WORKDIR}/spdx_sstate_dir"

python do_spdx () {
    import os
    import sys
    import subprocess

    default_flags = '--scanOption fossology'
    workdir = (d.getVar('WORKDIR', True) or "")
    sourcedir = (d.getVar('S', True) or "")
    manifest_dir = (d.getVar('SPDX_MANIFEST_DIR', True) or "")
    pn = (d.getVar('PN', True) or "")
    outfile = os.path.join(manifest_dir, pn + ".spdx")
    tar_file = os.path.join(workdir, pn + ".tar.gz")
    dosocs = (d.getVar('DOSOCS_PATH', True) or "")
    flags = (d.getVar('DOSOCS_FLAGS', True) or default_flags)
    
    document_comment = d.getVar('USE_DOCUMENT_COMMENT') or ""
    creator = d.getVar('USE_CREATOR') or ""
    creator_comment = d.getVar('USE_CREATOR_COMMENT') or ""
    cname = d.getVar('CREATOR') or ""
    dcomment = d.getVar('DOCUMENT_COMMENT') or ""
    ccomment = d.getVar('CREATOR_COMMENT') or ""
    print_format = d.getVar('PRINT_FORMAT') or ""

    flags += ' --print ' + print_format
    if( document_comment == "true" ):
        flags += ' --documentComment "' + dcomment + '"'
    if( creator == "true") :
        flags += ' --creator "' + cname + '"'
    if( creator_comment == "true" ):
        flags += ' --creatorComment "' + ccomment + '"'
    
    
    create_tarball(tar_file, sourcedir)

    dosocs_cmdline = [dosocs, '--scan', '-p', tar_file] + flags.split()
    spdxdata = subprocess.check_output(dosocs_cmdline)

    ## CREATE MANIFEST
    if not os.path.isdir(manifest_dir):
        bb.utils.mkdirhier(manifest_dir)
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
