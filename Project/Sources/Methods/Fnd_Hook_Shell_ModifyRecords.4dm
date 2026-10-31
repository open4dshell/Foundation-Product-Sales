//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_ModifyRecords

// Called to display the Modify Records dialog.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

If ((Current user="Designer") | (Current user="Administrator") | (User in group(Current user; "Administration")))
	Fnd_Rec_Modify
	
Else 
	Fnd_Dlg_SetText(Fnd_Loc_GetString("Fnd_Shell"; "AccessDenied"); Fnd_Loc_GetString("Fnd_Shell"; "AccessDeniedAdmin"))
	Fnd_Dlg_SetIcon(Fnd_Dlg_StopIcon)
	Fnd_Dlg_Display
End if 
