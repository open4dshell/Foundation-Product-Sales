//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_Setup

// Here's where the developer sets up information about this particular database.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// Created by Wayne Stewart
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
// ----------------------------------------------------

// Define the information displayed in the About box and Startup dialog.
Fnd_Gen_SetDatabaseInfo("DatabaseName"; Fnd_Loc_GetString("Loc_General"; "DatabaseName"))
Fnd_Gen_SetDatabaseInfo("DatabaseVersion"; Fnd_Loc_GetString("Loc_General"; "DatabaseVersion"))
Fnd_Gen_SetDatabaseInfo("DatabaseCopyright"; Fnd_Loc_GetString("Loc_General"; "DatabaseCopyright"))
Fnd_Gen_SetDatabaseInfo("DatabaseURL"; Fnd_Loc_GetString("Loc_General"; "DatabaseURL"))

// Release notes, shown on the About tab, newest first.
Fnd_Art_VersionHistory(\
	"<span style=\"font-weight:bold\">Version 6.0</span><br/>"+\
	"1 November 2026<br/>"+\
	"Initial release for version 6 of Foundation (Open Source)<br/>"+\
	"Wayne Stewart<br/>"+\
	"<br/>"+\
	"<span style=\"font-weight:bold\">Version 5.0</span><br/>"+\
	"1 May 2009<br/>"+\
	"Initial release for version 5 of Foundation<br/>"+\
	"Walt Nelson<br/>"+\
	"<br/>"+\
	"<span style=\"font-weight:bold\">Version 4.0</span><br/>"+\
	"9 October 2003<br/>"+\
	"Initial release for version 4 of Foundation<br/>"+\
	"Dave Batton")
