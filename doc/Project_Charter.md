#PROJECT CHARTER

Project Title: UNO Yocto+SPDX

Project Sponsor: University of Nebraska at Omaha

Date Prepared: January 28, 2015

Project Manager: NA

Project Customer: Yocto

###Project Purpose or Justification:
Yocto+SPDX is an ongoing opensource software development project.  The purpose of UNOs Yocto+SPDX group is to migrate/fork and manage the current project to a GitHub Repository and make improvements to the existing code.

###Project Description:
The Software Package Data Exchange® (SPDX®) specification is a standard format for communicating the components, licenses and copyrights associated with a software package.

SPDX Description Source: (https://spdx.org/about-spdx/what-is-spdx)

The Yocto+SPDX project is built to integrated SPDX generation into the Yocto build process. The Yocto Project is an open source collaboration project that provides templates, tools and methods to help create custom Linux-based systems for embedded products regardless of the hardware architecture (http://www.yoctoproject.org). The goal of integrating the Yocto build process with the SPDX standard is to integrate automated SPDX generation in upstream open source projects. The project was created and is hosted at the University of Nebraska at Omaha. 

Existing features include file level caching to manage package scanning overhead, and the output of TAG format SPDX documents. Yocto+SPDX enables the generation of automated, low definition SPDX files, including package and file level information. 

Yocto+SPDX Description Source: (https://spdx.org/tools/community/yoctospdx)

###High-level Project and Product Requirements:
1. Linux Development Environment
2. Python 
3. Fossology

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
* Complete Yocto Build
* System mock-up
* General code cleanup - standards compliance/best practices 

#####Potential efforts:
*   Upgrade to SPDX 2.0 standard
*   Performance improvements - Migrate caching functionality to a database-based solution?

Milestone 3 - Working Prototype - Due Date: 04/06/2015
* Working prototype incorporating changes proposed in M2
* Installation instructions
* Bug tracking system populated with known bugs
* Slide deck providing overview of system architecture
* Update all project documents

Milestone 4 - Advanced Prototype/Final Destination - Due Date: 04/29/2015
* Finalize working prototype
* Unit test suite
* Critique statements / bug reporting on other systems
* Update all project documents
