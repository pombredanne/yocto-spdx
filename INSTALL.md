Installation Instructions
-------------------------

These instructions cover building a minimal OS image using Yocto Project's
Poky build system with the SPDX plugin enabled. They assume you already know
how to use Poky to create an OS image using the out-of-the-box settings.

First you need to make sure all dependencies are installed.
Yocto+SPDX depends on:
* DoSOCS (https://github.com/socs-dev-env/DoSOCS)

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

Run the `install.sh` script to copy the Yocto+SPDX source files into the
poky source tree before you switch to the build environment.
Note the period at the end of the first command below. This indicates that
you want to install Yocto+SPDX to the current directory. The assumption at
this point is that your current directory is `poky` and that the Yocto+SPDX
repo is at `../yocto-spdx`.

    $ ../yocto-spdx/install.sh .
    $ source oe-init-build-env

Your current directory will automatically switch to `./build`.
Open up the `../meta/conf/licenses.conf` file to set relevant variables:

* `SPDX_MANIFEST_DIR`: output directory for the finished SPDX documents.
  This will be created for you if it does not already exist. Note that
  you may not have permission to write to the default path; to be safe
  you can change this to something like `/home/tgurney/spdx_output`.
* `SPDX_DOSOCS_PATH`: path to DoSOCS executable (probably called
  `DoSPDX.py`)

Finally, you need to add "spdx" to the variable `USER_CLASSES` in the
`conf/local.conf` file, to enable the `do_spdx` process step. Example:

    USER_CLASSES ?= "buildstats image-mklibs image-prelink spdx"

When you invoke `bitbake` to create the image:

    $ bitbake -k core-image-minimal

the step of creating an SPDX document will be performed for each package,
right after the `do_patch` step.
