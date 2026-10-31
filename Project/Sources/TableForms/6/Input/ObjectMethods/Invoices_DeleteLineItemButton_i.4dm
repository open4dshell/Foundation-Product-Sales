// ----------------------------------------------------

// Object Method: Invoices_DeleteLineItemButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		DELETE RECORD([LineItems])
		Invoices_UpdateTotal
End case 
