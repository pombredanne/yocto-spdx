###Use Case Number: 1

**Use Case Name:** Generate SPDX documents with a Yocto Project build

**Description:** User wants to generate an SPDX document for each recipe
processed during a build. This is the main use case for Yocto+SPDX.

**Preconditions:**
- DoSOCS installed and configured
- Poky build system downloaded and configured
- Yocto+SPDX installed, with bitbake variable `DOSOCS_PATH` set to the
  location of the DoSOCS executable and `USER_CLASSES` updated to include
  "spdx"

**Trigger:**
User starts a build, e.g. with "bitbake -k [image name]"

**Basic flow:**
No user action is required after the trigger.
For each recipe processed during the build:
- Yocto+SPDX creates a gzipped tarball from the recipe source directory
- Yocto+SPDX calls DoSOCS with the appropriate arguments (including path
  to the mentioned tarball)
- DoSOCS returns SPDX document output.
- Yocto+SPDX writes the output to a file named after the package that was just
processed, but with an ".spdx" suffix, to the user-specified target directory.

**Failure cases:**
- DoSOCS not correctly set up (e.g. no license scanner, wrong database
  user name / password)
- String "spdx" not added to `USER_CLASSES` variable in build/conf/local.conf
- DoSOCS executable not located at `DOSOCS_PATH`
- No permission to write to output directory

**Main Success Scenario:**
When the build completes, one .spdx file per recipe is located at the user
specified output directory. Each file contains information about the licenses
found in the source directory of the corresponding recipe.

