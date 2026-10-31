//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_List_SetEditableLists

// Use this method to specify the names of the editable lists.  The lists
//   named here will be available in the List Editor window.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// Use the Fnd_List_AddToListEditor command here to add lists to the List Editor.

Case of 
	: (Fnd_Loc_LanguageCode="FR")
		Fnd_List_AddToListEditor("Countries (FR)")
		Fnd_List_AddToListEditor("Invoice Terms (FR)")
	Else 
		Fnd_List_AddToListEditor("Countries (EN)")
		Fnd_List_AddToListEditor("Invoice Terms (EN)")
End case 
