Installation Instructions
-------------------------

These instructions cover building a minimal OS image using Yocto Project's
Poky build system with the SPDX plugin enabled. They assume you already know
how to use Poky to create an OS image using the out-of-the-box settings.

First you need to make sure all dependencies are installed.
Yocto+SPDX depends on:
* DoSOCS (https://github.com/socs-dev-env/DoSOCS)
* Python 2.7 (https://www.python.org)

Installation instructions for DoSOCS are beyond the scope of this document,
but important parts are making sure that it points to a license scanner
and database and that it has a username and password for the database.

Once dependencies are set up, clone the Yocto+SPDX repository if you haven't
already:

    $ git clone https://github.com/ttgurney/yocto-spdx

Follow the usual steps to clone the Poky repository:

    $ git clone http://git.yoctoproject.org/git/poky
    $ cd poky
    $ git checkout -b dizzy origin/dizzy

Copy the `spdx.bbclass` and `licenses.conf` files into the poky source tree, 
overwriting the existing files before you switch to the build environment:

    $ cp ../yocto-spdx/src/spdx.bbclass meta/classes
    $ cp ../yocto-spdx/src/licenses.conf meta/conf
    $ source oe-init-build-env

Your current directory will automagically switch to `./build`.
Open up the `../meta/conf/licenses.conf` file to set relevant variables:

* `SPDX_MANIFEST_DIR`: output directory for the finished SPDX documents
* `DOSOCS_PATH`: location of DoSOCS executable (probably called `DoSPDX.py`)
* `DOSOCS_FLAGS`: Flags passed to DoSOCS. The default is sane and assumes
  that you want to use FOSSology as a license scanner. Refer to the DoSOCS
  documentation for a description of the available flags.

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
