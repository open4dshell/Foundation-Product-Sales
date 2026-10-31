// ----------------------------------------------------

// Object Method: Invoices_ClearContactButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		[Invoices]Contact_ID:=0
		Invoices_UpdateContactInfo
End case 
