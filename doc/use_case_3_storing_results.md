###Use Case Number: 3

**Use Case Name:** Store results in an SPDX 2.0 Database

**Use Case Description:** After creating SPDX 2.0 documents during the Yocto build, 
store the resulting documents in a database.

**Precondition:** Have a working database to store SPDX 2.0 documents.

**Trigger:** A setting in the configuration file that would enable or disable storing of the results.

**Basic Flow:** For each resulting SPDX 2.0 document check if the document already exists in the database.
If it doesn't already exists upload the document to the database.

**Alternate Flow:** If the user for some reason doesn't want to upload documents skip this step.
