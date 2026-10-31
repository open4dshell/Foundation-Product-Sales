// ----------------------------------------------------

// Object Method: Invoices_SelectContactButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($contactID)

Case of 
	: (Form event code=On Clicked)
		$contactID:=Invoices_SelectContact
		If (OK=1)
			[Invoices]Contact_ID:=$contactID
			Invoices_UpdateContactInfo
		End if 
End case 
