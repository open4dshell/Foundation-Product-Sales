// ----------------------------------------------------

// Object Method: Contacts_DeleteInvoiceButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		CONFIRM("Are you sure you want to delete this invoice?"; "Delete"; "Cancel")
		If (OK=1)
			READ WRITE([Invoices])
			LOAD RECORD([Invoices])
			
			If (Locked([Invoices]))
				ALERT("The record is locked and can't be deleted now.")
			Else 
				DELETE RECORD([Invoices])
			End if 
			
			READ ONLY([Invoices])
			Contacts_LoadRelatedInvoices
		End if 
End case 
