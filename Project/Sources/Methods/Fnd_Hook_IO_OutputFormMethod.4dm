//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_IO_OutputFormMethod

// This hook is called from the Fnd_IO_OutputFormMethod method during all output form events.

// Access Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// Call 4D's 'Current form table' or Foundation's Fnd_Gen_CurrentTable function
// to determine the current table.
// Use 4D's 'Form event' function to determine the current form event.

var $formEventCode_i : Integer
var $currentTable_ptr : Pointer

$formEventCode_i:=Form event code
$currentTable_ptr:=Fnd_Gen_CurrentTable


Case of 
	: ($formEventCode_i=On Load)
		
		Case of 
			: ($currentTable_ptr=(->[Invoices])) | ($currentTable_ptr=(->[Products]))
				
				
				
				
		End case 
		
		
		
		
End case 

