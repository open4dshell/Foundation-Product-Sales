// ----------------------------------------------------

// Object Method: [Company Info].Input.Web Site


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Oct 1, 2004

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Fnd_Data_FormatWebURL(Self->)
End case 
