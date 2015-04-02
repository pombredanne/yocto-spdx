###Use Case Number: 3

**Use Case Name:** Use a different SPDX document output format.

**Description:** By default the SPDX output is in JSON format, one might want
to use RDF or "tag" format instead.

**Preconditions:**
- DoSOCS installed and configured
- Poky build system downloaded and configured
- Yocto+SPDX installed, with bitbake variable `DOSOCS_PATH` set to the
  location of the DoSOCS executable and `USER_CLASSES` updated to include
  "spdx"

**Trigger:**
User is about to kick off a build when they realize they don't want their
SPDX documents to be in JSON format.

**Basic flow:**
In the `licenses.conf` file, replace `SPDX_PRINT_FORMAT=json` with either `SPDX_PRINT_FORMAT=tag`
or `SPDX_PRINT_FORMAT=rdf` depending on the desired format.  Then kick off the build
(e.g. in the build directory run `bitbake -k <image name>`).

**Failure cases:**
Same as those for Use Case 1, plus the case where the user introduces an
error when modifying the `PRINT_FORMAT` variable.

**Main Success Scenario:**
Same as Use Case 1, except all produced SPDX documents are in the new specified
format.
