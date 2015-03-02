#PROJECT CHARTER

Project Title: UNO Yocto+SPDX

Project Sponsor: University of Nebraska at Omaha

Date Prepared: January 28, 2015

Project Manager: NA

Project Customer: Yocto Project and SPDX communities

###Project Purpose or Justification:
To create a Yocto plug-in that creates SPDX documents.

###Project Description:

SPDX is a standard format for communicating information about the licenses and copyrights associated with a software package. (https://www.spdx.org)

The Yocto Project is an open source collaboration project that provides templates, tools and methods to help create custom Linux-based systems for embedded products regardless of the hardware architecture. (http://www.yoctoproject.org).

The original Yocto+SPDX project was built to integrate SPDX generation into the Yocto build process. The goal of integrating the Yocto build process with the SPDX standard is to integrate automated SPDX generation in upstream open source projects. The project was created and is hosted at the University of Nebraska at Omaha. Yocto+SPDX Description Source: (https://spdx.org/tools/community/yoctospdx)

This iteration of Yocto+SPDX removes some of the functionality from the original Yocto+SPDX project code and replaces it with DoSOCS. DoSOCS is a command line tool that processes software packages into SPDX documents. DoSOCS scans and prints SPDX documents and uses a MySQL database for caching and storage. (https://github.com/socs-dev-env/DoSOCS)

###High-level Project and Product Requirements:
1. Linux Development Environment
2. Python
3. DoSOCS

###Summary Budget:
There is no foreseeable cost for this project.

###Initial Risks:
N/A

###Milestone Definitions

Milestone 1 - Analysis and Design - Due Date: 02/02/2015
* Creation of initial project resources and documents
* Git repository
* Declare licenses
* Supporting documents - project charter/description, milestone definitions, system service request, stakeholder registry, communication management plan, data flow diagram, database structures

Milestone 2 - Proof of Concept - Due Date: 03/04/2015
* Update all project documents
* Create Use-Case
* Rewrite Yocto plug-in to integrate DoSOCS
* Complete Yocto Build with SPDX plug-in enabled
* General code cleanup - standards compliance/best practices
* Create Installation instructions and screenshots

Milestone 3 - Working Prototype - Due Date: 04/06/2015
* Working prototype incorporating changes proposed in M2
* Bug tracking system populated with known bugs
* Slide deck providing overview of system architecture
* Update all project documents

Milestone 4 - Advanced Prototype/Final Destination - Due Date: 04/29/2015
* Finalize working prototype
* Unit test suite
* Critique statements / bug reporting on other systems
* Update all project documents
