Use Case Number: 2

Use Case Name: Use caching to speed up the scan process.

Use Case Description: In order to lower the time it takes to generate the SPDX documents during a Yocto build, we plan to implement a caching system so we don’t have to run FOSSology scans that already exist. 

Precondition: Have a working database to store SPDX 2.0 documents in.

Trigger: A setting in the configuration file that would enable caching.

Basic Flow:
1.	For each file in the Yocto recipe create a checksum and query it against the Database
2.	If a scan already exists pull the SPDX document from the Database
3.	You can now skip sending the file to FOSSology

Alternate Flow:
	If a SPDX 2.0 document doesn’t exist in the Database
1.	Run a FOSSology scan and generate an SPDX 2.0 document.
2.	Send the SPDX document to the Database.
