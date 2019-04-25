Small DB to show use of TsqlT tests.
The Setup should be done from build.ps1
Based on SQL Server does require a local instance running at for build to work.
Migration scripts will need to be be prefixed with a number. This will be addressed later.
There is a subfolder with a .ps1 to install a sql server express instance.
Clean up will drop objects, and eventually uninstall sql server express. 
TO-DO: 
	Write clean up scripts.
	Rewrite database and schema scripts to be more robust.