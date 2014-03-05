************************
SVN USEFUL HOOKS

Author: Dio Phung

Purpose: To extend the functionality of SVN (on Windows)
************************

CONTENTS
----------
1. pre-commit
	a hook for pre-commit, which can :
		- Reject empty log message
		- Enforce minimum length of log message
		
2. pre-revprop-change:
	a hook that can:
		- Enable edit commit log message after checkin
		- Only allow edit your own message (restriction can be removed)
		
USAGE
----------
Copy these .bat file into your SVN /hooks folder.
or
If you're using Visual SVN: right click your repository --> Properties --> Hooks.
Edit the hook script by copy the content of each batch file.

CREDITS:
----------
http://ayria.livejournal.com/33438.html for pre-revprop-change