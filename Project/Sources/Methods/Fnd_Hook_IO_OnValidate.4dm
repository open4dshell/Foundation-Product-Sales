//%attributes = {"invisible":true,"shared":true,"lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_IO_OnValidate ($table_ptr; $formName_t)

// Put here what an input form did in its On Validate event.

// Foundation opens an input form with DIALOG when the form allows it, and On Validate never
//   fires under DIALOG, so Foundation calls this hook instead, just before it saves the record.
//   In the form, keep
//      : (Form event code=On Validate)
//         Fnd_Hook_IO_OnValidate(Current form table; Current form name)
//   so the code runs whichever way the form is opened. A form that handles On Validate without
//   calling this hook keeps opening with MODIFY RECORD.
// This hook cannot refuse a save: use Fnd_Hook_IO_InputFormButton for that.

// Access: Shared

// Parameters:
//   $table_ptr : Pointer : The form's table
//   $formName_t : Text : The form's name

// Returns: Nothing

// Created by Foundation on 2026-11-27.
//   Foundation calls this hook. Put your code between the markers; the rest may be updated.
//   Keep it shared: Foundation calls it from the component.
// ----------------------------------------------------

#DECLARE($table_ptr : Pointer; $formName_t : Text)

var $params_i : Integer

$params_i:=Count parameters

If ($params_i<1)
	$table_ptr:=Fnd_Gen_CurrentTable
End if 


If ($params_i<2)
	$formName_t:=Current form name
End if 


//MARK: Example code
// See https://foundation.open4dshell.com/docs/io

//Case of 
//	: ($table_ptr=(->[MyTable]))
//		Case of 
//			: ($formName_t="Input")
//				[MyTable]Modified:=Current date
//		End case 
//End case 

//MARK:- Your code

Case of 
	: ($table_ptr=(->[Contacts]))
		Case of 
			: ($formName_t="Input")
				<>Contacts_AddRecordNumber_i:=Record number([Contacts])  // The [Invoices].Input form will check this.
				
		End case 
	: ($table_ptr=(->[Invoices]))
		Case of 
			: ($formName_t="Input")
				VALIDATE TRANSACTION
		End case 
End case 



//MARK:- End of your code
