//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_Print

// Called to display the shell's Print dialog.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// 4D's Quick Report Editor
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "ReportEditor"); "Fnd_Prnt_QuickReportEditor")

// 4D's Label Editor
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "LabelEditor"); "Fnd_Prnt_LabelEditor")

// Display the selection dialog.
Fnd_List_CommandDialog

