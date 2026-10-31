// ----------------------------------------------------

// Trigger: Line Items


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($0; $error)

$error:=0

Case of 
	: (Trigger event=On Saving New Record Event) | (Trigger event=On Saving Existing Record Event)
		Fnd_SqNo_SetRecordID
		If ([LineItems]Invoice_ID=0)  // The line item must be linked to an invoice.
			
			$error:=32010  // See the docs for error number info.
			
		End if 
End case 

$0:=$error