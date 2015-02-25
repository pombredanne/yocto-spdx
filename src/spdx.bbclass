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

def remove_dir_tree( dir_name ):
    import shutil
    try:
        shutil.rmtree( dir_name )
    except:
        pass

def remove_file( file_name ):
    try:
        os.remove( file_name )
    except OSError as e:
        pass

def list_files( dir ):
    for root, subFolders, files in os.walk( dir ):
        for f in files:
            rel_root = os.path.relpath( root, dir )
            yield rel_root, f
    return

def hash_file( file_name ):
    try:
        f = open( file_name, 'rb' )
        data_string = f.read()
    except:
       return None
    finally:
        f.close()
    sha1 = hash_string( data_string )
    return sha1

def hash_string( data ):
    import hashlib
    sha1 = hashlib.sha1()
    sha1.update( data )
    return sha1.hexdigest()

def run_fossology( foss_command ):
    import string, re
    import subprocess
    
    p = subprocess.Popen(foss_command.split(),
        stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    foss_output, foss_error = p.communicate()
    
    records = []
    records = re.findall('FileName:.*?</text>', foss_output, re.S)

    file_info = {}
    for rec in records:
        rec = string.replace( rec, '\r', '' )
        chksum = re.findall( 'FileChecksum: SHA1: (.*)\n', rec)[0]
        file_info[chksum] = {}
        file_info[chksum]['FileCopyrightText'] = re.findall( 'FileCopyrightText: '
            + '(.*?</text>)', rec, re.S )[0]
        fields = ['FileType','LicenseConcluded',
            'LicenseInfoInFile','FileName']
        for field in fields:
            file_info[chksum][field] = re.findall(field + ': (.*)', rec)[0]

    return file_info

def create_spdx_doc( file_info, scanned_files ):
    import json
    ## push foss changes back into cache
    for chksum, lic_info in scanned_files.iteritems():
        if chksum in file_info:
            file_info[chksum]['FileName'] = file_info[chksum]['FileName']
            file_info[chksum]['FileType'] = lic_info['FileType']
            file_info[chksum]['FileChecksum: SHA1'] = chksum
            file_info[chksum]['LicenseInfoInFile'] = lic_info['LicenseInfoInFile']
            file_info[chksum]['LicenseConcluded'] = lic_info['LicenseConcluded']
            file_info[chksum]['FileCopyrightText'] = lic_info['FileCopyrightText']
        else:
            bb.warn(lic_info['FileName'] + " : " + chksum
                + " : is not in the local file info: "
                + json.dumps(lic_info,indent=1))
    return file_info

def get_ver_code( dirname ):
    chksums = []
    for f_dir, f in list_files( dirname ):
        try:
            stats = os.stat(os.path.join(dirname,f_dir,f))
        except OSError as e:
            bb.warn( "Stat failed" + str(e) + "\n")
            continue
        chksums.append(hash_file(os.path.join(dirname,f_dir,f)))
    ver_code_string = ''.join( chksums ).lower()
    ver_code = hash_string( ver_code_string )
    return ver_code

def get_header_info( info, spdx_verification_code, spdx_files ):
    """
        Put together the header SPDX information.
        Eventually this needs to become a lot less
        of a hardcoded thing.
    """
    from datetime import datetime
    import os
    head = []
    DEFAULT = "NOASSERTION"

    #spdx_verification_code = get_ver_code( info['sourcedir'] )
    package_checksum = ''
    if os.path.exists(info['tar_file']):
        package_checksum = hash_file( info['tar_file'] )
    else:
        package_checksum = DEFAULT

    ## document level information
    head.append("SPDXVersion: " + info['spdx_version'])
    head.append("DataLicense: " + info['data_license'])
    head.append("DocumentComment: <text>SPDX for "
        + info['pn'] + " version " + info['pv'] + "</text>")
    head.append("")

    ## Creator information
    now = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
    head.append("## Creation Information")
    head.append("Creator: fossology-spdx")
    head.append("Created: " + now)
    head.append("CreatorComment: <text>UNO</text>")
    head.append("")

    ## package level information
    head.append("## Package Information")
    head.append("PackageName: " + info['pn'])
    head.append("PackageVersion: " + info['pv'])
    head.append("PackageDownloadLocation: " + DEFAULT)
    head.append("PackageSummary: <text></text>")
    head.append("PackageFileName: " + os.path.basename(info['tar_file']))
    head.append("PackageSupplier: Person:" + DEFAULT)
    head.append("PackageOriginator: Person:" + DEFAULT)
    head.append("PackageChecksum: SHA1: " + package_checksum)
    head.append("PackageVerificationCode: " + spdx_verification_code)
    head.append("PackageDescription: <text>" + info['pn']
        + " version " + info['pv'] + "</text>")
    head.append("")
    head.append("PackageCopyrightText: <text>" + DEFAULT + "</text>")
    head.append("")
    head.append("PackageLicenseDeclared: " + DEFAULT)
    head.append("PackageLicenseConcluded: " + DEFAULT)
    head.append("PackageLicenseInfoFromFiles: " + DEFAULT)
    head.append("")
    
    ## header for file level
    head.append("## File Information")
    head.append("")

    return '\n'.join(head)
