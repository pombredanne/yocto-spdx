###Use Case Number: 2

**Use Case Name:** Use caching to speed up the production of SPDX documents in
the Yocto build process.

**Use Case Description:**
Generating an SPDX document from a package is really slow since it requires
scanning the entire source code. Having cached SPDX data speeds things up by
minimizing the number of packages that need to go to the scanner.

**Preconditions:**
- DoSOCS installed and configured
- Poky build system downloaded and configured
- Yocto+SPDX installed, with bitbake variable `DOSOCS_PATH` set to the
  location of the DoSOCS executable and `USER_CLASSES` updated to include
  "spdx"
- At least one build has already been completed with the SPDX plugin enabled.

**Trigger:**
User starts a build, e.g. with "bitbake -k [image name]"

**Basic Flow:**
- User kicks off the build with a command like `bitbake -k <image name>`
- For each recipe processed during the build:
  - If the `do_spdx` build process step has not previously been completed
    for this recipe, then the flow is the same as that of Use Case 1.
  - Otherwise:
    - Yocto+SPDX creates a gzipped tarball from the source directory.
    - Yocto+SPDX calls DoSOCS with the appropriate command line arguments,
      including path to the mentioned tarball
    - DoSOCS will immediately return the cached SPDX data for the package,
      with no scanning process.
    - Yocto+SPDX writes the SPDX data out to the target file as specified
      in Use Case 1.

