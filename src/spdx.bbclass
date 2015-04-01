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
    import sys
    import subprocess
    import tarfile

    flags = '--scanOption fossology'
    workdir = d.getVar('WORKDIR', True) or ''
    sourcedir = d.getVar('S', True) or ''
    manifest_dir = d.getVar('SPDX_MANIFEST_DIR', True) or ''
    pn = d.getVar('PN', True) or ''
    outfile = os.path.join(manifest_dir, pn + ".spdx")
    tar_file = os.path.join(workdir, pn + ".tar.gz")
    dosocs = d.getVar('SPDX_DOSOCS_PATH', True) or ''

    creator = d.getVar('SPDX_CREATOR') or None
    document_comment = d.getVar('SPDX_DOCUMENT_COMMENT') or None
    creator_comment = d.getVar('SPDX_CREATOR_COMMENT') or None
    print_format = d.getVar('SPDX_PRINT_FORMAT') or 'json'

    flags += " --print " + print_format
    cla = flags.split()

    if document_comment is not None:
        cla.append('--documentComment')
        cla.append(document_comment)
    if creator is not None:
        cla.append('--creator')
        cla.append(creator)
    if creator_comment is not None:
        cla.append('--creatorComment')
        cla.append(creator_comment)

    with tarfile.open(tar_file, "w:gz" ) as t:
        try:
            t.add(sourcedir, arcname=os.path.basename(sourcedir))
        except OSError as e:
            bb.error('do_spdx: Failed to write to file ' + tar_file +
            ': ' + e.strerror
            )
            return 1

    dosocs_cmdline = [dosocs, '--scan', '-p', tar_file] + cla
    try:
        spdxdata = subprocess.check_output(dosocs_cmdline)
    except subprocess.CalledProcessError as e:
        bb.error('do_spdx: DoSOCS returned exit status ' + str(e.returncode))
        if e.output:
            bb.error('do_spdx: DoSOCS output: ')
            bb.error(e.output)
        return 1
    except OSError as e:
        bb.error('do_spdx: Failed to call process ' + dosocs +
        ': ' + e.strerror
        )
        return 1

    ## CREATE MANIFEST
    if not os.path.isdir(manifest_dir):
        try:
            bb.utils.mkdirhier(manifest_dir)
        except OSError as e:
            bb.error('do_spdx: failed to create output dir ' + manifest_dir +
            ': ' + e.strerror
            )
            return 1
    with open(outfile, 'w') as f:
        try:
            f.write(spdxdata + '\n')
        except OSError as e:
            bb.error('do_spdx: failed to write to ' + outfile +
            ': ' + e.strerror
            )
            return 1


    ## clean up the temp stuff
    try:
        os.remove(tar_file)
    except OSError as e:
        bb.warn('do_spdx: failed to remove temp tar file ' + tar_file +
                ': ' + e.strerror
                )
}
addtask spdx after do_patch before do_configure
