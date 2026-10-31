// ----------------------------------------------------

// Object Method: Invoices_NewContactButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		Fnd_IO_DisplayRecord(->[Contacts]; New record)
End case 
