Yocto+SPDX
==========


Overview
--------

SPDX is a standard format for communicating information about the licenses
and copyrights associated with a software package. 
(https://www.spdx.org)

The Yocto Project is an open source collaboration project that
provides templates, tools and methods to help create custom Linux-based systems
for embedded products regardless of the hardware architecture.
(http://www.yoctoproject.org). 

The original Yocto+SPDX project was built to integrate SPDX generation into the Yocto build
process. The goal of integrating the Yocto build process with the SPDX standard 
is to integrate automated SPDX generation in upstream open source projects. 
The project was created and is hosted at the University of Nebraska at Omaha.  
Yocto+SPDX Description Source:
(https://spdx.org/tools/community/yoctospdx)

This project will remove some of the funtionality from the original Yocto+SPDX project code and replace it with DoSOCS.
DoSOCS was built to process software packages into SPDX documents. This utility scans, stores, and prints spdx documents. DoSOCS Stores SPDX docs in a MySQL database. 
(https://github.com/socs-dev-env/DoSOCS)

Licensing
---------
The Yocto+SPDX code is released under the terms of the MIT license; see the
file LICENSE-MIT in the repository root.

All supporting documentation (i.e. non-code documents) is released under the
terms of the CC BY 3.0 US license, see the file CC-BY-3.0 in the repository
root.

Installation Instructions
-------------------------

Refer to INSTALL.md in the repository root.


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
