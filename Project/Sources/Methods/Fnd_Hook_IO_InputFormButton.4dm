//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_IO_InputFormButton (button) --> Boolean

// This hook is called when a button on the inherited Fnd_IO_InputForm
//   is clicked.

// Method Type: Public

// Parameters: 
//   $1 : Text : The button that was clicked:
//      "save"
//      "cancel"
//      "first"
//      "previous"
//      "next"
//      "last"

// Returns:
//   $0 : Boolean : Allow Foundation to handle the request?
// ----------------------------------------------------

// Call Fnd_Gen_CurrentTable to determine the current table.
// Return False to prevent the default action.

C_BOOLEAN($0)
C_TEXT($1; $Button_t)

$Button_t:=$1

$0:=True

//  // EXAMPLE CODE:
//If ($Button_t="cancel") & (Fnd_Gen_CurrentTable =(->[Contacts]))
//  // Do something special
//$0:=False
//Else 
//$0:=True
//End if 

