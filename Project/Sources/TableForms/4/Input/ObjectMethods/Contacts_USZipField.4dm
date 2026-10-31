// ----------------------------------------------------

// Object Method: Postal Code


// Created by Dave Batton on Oct 1, 2004

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Fnd_Data_FormatPostalCode(Self->)
End case 
