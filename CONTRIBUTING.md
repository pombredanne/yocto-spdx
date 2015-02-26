##Yocto+SPDX Code Submission Policy

Contributions to the UNOs Yocto+SPDX Project are welcome.  

There are three ways to submit code to Yocto-SPDX Group.

1. The preferred method for code submission is to fork the Yocto-SPDX
repository using GitHub. A pull request should be issued to submit code.  Code
will be reviewed by UNO Yocto+SPDX group before being merged.  For help with
pull requests: (https://help.github.com/articles/using-pull-requests/) For
general help see:
(https://help.github.com/articles/good-resources-for-learning-git-and-github/)

2. The second method is to contact the repositories maintainers via email.
Email addresses for the current project maintainers are located in the project
ReadMe file: (https://github.com/ttgurney/yocto-spdx/blob/master/README.md).
Code will be reviewed by UNO Yocto+SPDX group before being merged. 

3. The last method is to petition UNO Yocto+SPDX for direct access to the
Yocto-SPDX GitHub repository. This method will be considered for regular
contributers who have shown the abilty to work with-in the community. To submit
this request, please contact the project maintainers by email.

###All patch submissions require documentation.

When you send a patch, be sure to include a "Signed-off-by:" line in the same
style as required by the Linux kernel. Adding this line signifies that you, the
submitter, have agreed to the Developer's Certificate of Origin 1.1 as follows:

     Developer's Certificate of Origin 1.1

     By making a contribution to this project, I certify that:

     (a) The contribution was created in whole or in part by me and I
         have the right to submit it under the open source license
         indicated in the file; or

     (b) The contribution is based upon previous work that, to the best
         of my knowledge, is covered under an appropriate open source
         license and I have the right under that license to submit that
         work with modifications, whether created in whole or in part
         by me, under the same open source license (unless I am
         permitted to submit under a different license), as indicated
         in the file; or

     (c) The contribution was provided directly to me by some other
         person who certified (a), (b) or (c) and I have not modified
         it.

     (d) I understand and agree that this project and the contribution
         are public and that a record of the contribution (including all
         personal information I submit with it, including my sign-off) is
         maintained indefinitely and may be redistributed consistent with
         this project or the open source license(s) involved.


For each commit, you must provide a single-line summary of the change and you
should almost always provide a more detailed description of what you did (i.e.
the body of the commit message). The only exceptions for not providing a
detailed description would be if your change is a simple, self-explanatory
change that needs no further description beyond the summary. Here are the
guidelines for composing a commit message:

Provide a single-line, short summary of the change. This summary is typically
viewable in the "shortlist" of changes. Thus, providing something short and
descriptive that gives the reader a summary of the change is useful when
viewing a list of many commits. This short description should be prefixed by
the recipe name (if changing a recipe), or else the short form path to the file
being changed.

For the body of the commit message, provide detailed information that describes
what you changed, why you made the change, and the approach you used. It may
also be helpful if you mention how you tested the change. Provide as much
detail as you can in the body of the commit message.

If the change addresses a specific bug or issue that is associated with a
bug-tracking ID, include a reference to that ID in your detailed description.
For example, the Yocto Project uses a specific convention for bug references -
any commit that addresses a specific bug should use the following form for the
detailed description:

     Fixes [Yocto-SPDX #<bug-id>]

     <detailed description of change>


These code submission policies are modeled after the policies of
yoctoproject.org.  More information regarding these policies can be found at:
http://www.yoctoproject.org/docs/1.6/dev-manual/dev-manual.html#how-to-submit-a-change


