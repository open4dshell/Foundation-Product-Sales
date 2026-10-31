// ----------------------------------------------------

// Object Method: Tax


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Round(Self->; 2)  // In case a fraction of a cent gets entered by mistake.
		
		Invoices_UpdateTotal
End case 
