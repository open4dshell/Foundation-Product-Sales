// ----------------------------------------------------

// Object Method: [Contacts].Input.Web Site


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Fnd_Data_FormatWebURL(Self->)
End case 
