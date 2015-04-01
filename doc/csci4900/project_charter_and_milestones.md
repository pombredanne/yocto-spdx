#PROJECT CHARTER

Project Title: UNO Yocto+SPDX

Project Sponsor: University of Nebraska at Omaha

Date Prepared: January 28, 2015

Project Manager: NA

Project Customer: Yocto Project and SPDX communities

###Project Purpose and Justification:

Embedded OS images created using the Yocto Project build process can
potentially contain an enormous number of open source packages, each
accompanied by a license that communicates the terms by which the software can
be used. Groups who create and distribute these OS images, as well as the users
of these images, face challenges in determining what their obligations are when
they distribute and/or use the software contained within.

###Project Description:

Yocto+SPDX aims to simplify the gathering of license information for the many
packages in a typical OS built using Yocto Project by seamlessly integrating
SPDX document generation into the build process. More information can be found
in README.md in the repository root.

###High-level Project and Product Requirements:
1. Linux
2. Python 2.7
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
* Supporting documents - project charter/description, milestone definitions,
  system service request, stakeholder registry, communication management plan,
  data flow diagram, database structures

Milestone 2 - Proof of Concept - Due Date: 03/04/2015
* Update all project documents
* Create Use-Case
* Rewrite Yocto plug-in to integrate DoSOCS
* Complete Yocto Build with SPDX plug-in enabled
* General code cleanup - standards compliance/best practices
* Create installation instructions and screenshots

Milestone 3 - Working Prototype - Due Date: 04/06/2015
* Working prototype incorporating changes proposed in M2
* Bug tracking system populated with known bugs
* Update all project documents

Milestone 4 - Advanced Prototype/Final Destination - Due Date: 04/29/2015
* Finalize working prototype
* Unit test suite
* Critique statements / bug reporting on other systems
* Update all project documents
