// ----------------------------------------------------

// Form Method: [Invoices].DummyDetail


// Displays the double-clicked invoice in a new window, then just cancels

//   so the user is returned back in the original contact input form.


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		Fnd_IO_DisplayRecord(->[Invoices]; Record number([Invoices]))
		CANCEL
End case 
