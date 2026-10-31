// ----------------------------------------------------
// Object Method: Invoices_CalendarButton_i

// Created by Dave Batton on Mar 30, 2005
// ----------------------------------------------------

Case of 
	: (Form event code=On Clicked)
		Fnd_Date_Calendar(->[Invoices]InvoiceDate)
End case 
