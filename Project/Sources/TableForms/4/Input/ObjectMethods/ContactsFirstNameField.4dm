// ----------------------------------------------------

// Object Method: [Contacts].Input.First Name


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Fnd_Data_FormatText(Self->)
		Contacts_UpdateWindowTitle
End case 
