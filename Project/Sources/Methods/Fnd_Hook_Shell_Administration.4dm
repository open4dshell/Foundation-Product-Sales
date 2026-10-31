//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_Administration

// Called to display the shell's Administration dialog.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

Fnd_List_AddItem(Fnd_Loc_GetString("Loc_General"; "EditCompanyInfo"); "Company_EditSettings")



// Foundation's List Editor
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "ListEditor"); "Fnd_List_Editor")

// Access to 4D's Password Editor
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "PasswordEditor"); Command name(281))

Fnd_List_AddItem("Preferences Explorer"; "Fnd_Pref_Editor")

// Foundation's Sequence Number Editor
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "SequenceNumberEditor"); "Fnd_SqNo_Editor")

// Import & Export Editors
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "ImportEditor"); Command name(665)+"(\"\")")
Fnd_List_AddItem(Fnd_Loc_GetString("Fnd_Shell"; "ExportEditor"); Command name(666)+"(\"\")")


// Display the selection dialog.
Fnd_List_CommandDialog