// ----------------------------------------------------

// Object Method: Invoices_ViewContactButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		Invoices_UpdateContactInfo  // This will make sure the [Contacts] record is loaded.
		
		Fnd_IO_DisplayRecord(->[Contacts]; Record number([Contacts]))
End case 
