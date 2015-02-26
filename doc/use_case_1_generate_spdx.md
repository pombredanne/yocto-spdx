Use Case Number: 1

Use Case Name: Generate SPDX documents with a Yocto Project build

Description: User wants to generate an SPDX document for each recipe processed
during a build. This is the main use case for Yocto+SPDX.

Preconditions:
- DoSOCS installed and configured
- Poky build system downloaded and configured
- Yocto+SPDX installed, with bitbake variable `DOSOCS_PATH` set to the
  location of the DoSOCS executable and `USER_CLASSES` updated to include
  "spdx"

Trigger:
User starts a build, e.g. with "bitbake -k [image name]"

Basic flow:
No user action is required after the trigger.

Failure cases:
- DoSOCS not correctly set up (e.g. no license scanner, wrong database
  user name / password)
- String "spdx" not added to `USER_CLASSES` variable in build/conf/local.conf
- DoSOCS executable not located at `DOSOCS_PATH`

Post condition:
When the build completes, one .spdx file per recipe is located at the user
specified output directory. Each file contains information about the licenses
found in the source directory of the corresponding recipe.

