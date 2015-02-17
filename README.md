Yocto+SPDX
==========


Overview
--------

SPDX is a standard format for communicating information about the licenses
and copyrights associated with a software package. More information at
https://www.spdx.org.

The Yocto+SPDX project is built to integrated SPDX generation into the Yocto bu
ild process. The Yocto Project is an open source collaboration project that
provides templates, tools and methods to help create custom Linux-based systems
for embedded products regardless of the hardware architecture
(http://www.yoctoproject.org). The goal of integrating the Yocto build process
with the SPDX standard is to integrate automated SPDX generation in upstream
open source projects. The project was created and is hosted at the University
of Nebraska at Omaha.  Yocto+SPDX Description Source:
https://spdx.org/tools/community/yoctospdx

 
Licensing
---------
The Yocto+SPDX code is released under the terms of the MIT license; see the
file LICENSE-MIT in the repository root.

All supporting documentation (i.e. non-code documents) is released under the
terms of the CC BY 3.0 US license, see the file CC-BY-3.0 in the repository
root.


Software Dependencies
---------------------
* Python 2 (https://www.python.org)
* FOSSology (https://www.fossology.org)


Installation Instructions
-------------------------

These instructions cover building a minimal OS image using Yocto Project's
Poky build system with the SPDX plugin enabled. They assume you already know
how to use Poky to create an OS image using the out-of-the-box settings.

Clone the Yocto+SPDX repository if you haven't already:

    $ git clone https://github.com/ttgurney/yocto-spdx

Follow the usual steps to clone the Poky repository:

    $ git clone http://git.yoctoproject.org/git/poky
    $ cd poky
    $ git checkout -b dizzy origin/dizzy

Copy the `spdx.bbclass` code into the `poky/meta/classes` directory,
overwriting the existing file before you switch to the build environment:

    $ cp ../yocto-spdx/src/spdx.bbclass meta/classes
    $ source oe-init-build-env

If you want, open up the `meta/conf/licenses.conf` file to set relevant
variables:

* `SPDX_TEMP_DIR`: location of the temporary directory for the SPDX plugin
* `SPDX_MANIFEST_DIR`: output directory for the finished SPDX documents
* `FOSS_SERVER`: FOSSology server to connect to (used for scanning packages
  to gather license information)

Finally, you need to add "spdx" to the variable `USER_CLASSES` in the
`build/conf/local.conf` file, to enable the `do_spdx` process step.

When you invoke `bitbake` to create the image:

    $ bitbake -k core-image-minimal

the step of creating an SPDX document will be performed for each package,
right after the `do_patch` step.

Maintainers
-----------
Yocto+SPDX is currently maintained by students at the University of Nebraska
at Omaha.

* Thomas T. Gurney <tgurney@unomaha.edu>
* Daniel Wright <dswright@unomaha.edu>
* Timothy Strevey <tstrevey@unomaha.edu>
* Kevin Lumbard <klumbard@unomaha.edu>

All contributions to Yocto+SPDX are subject to review by UNO Yocto-SPDX
project group before being merged.

\* Yocto+SPDX has no affiliation with the SPDX workgroup, the Yocto Project or
the Linux Foundation.
