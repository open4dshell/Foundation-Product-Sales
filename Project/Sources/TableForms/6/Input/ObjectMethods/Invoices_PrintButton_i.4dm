// ----------------------------------------------------
// Object Method: Invoices_PrintButton_i

// Created by 4D, Inc. on May 2, 2003
// ----------------------------------------------------

Case of 
	: (Form event code=On Clicked)
		FORM SET OUTPUT([Invoices]; "Invoice")
		PRINT RECORD([Invoices])
		FORM SET OUTPUT([Invoices]; "Output")
End case 
