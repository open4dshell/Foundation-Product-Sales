// ----------------------------------------------------

// Object Method: [Contacts].Input.Contacts_CountryPopup_at


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


If (Form event code=On Data Change)
	Self->{0}:=Fnd_Data_FormatText(Self->{0})
	If (Contacts_IsUSA(Self->{0}))
		Self->{0}:="United States"
	End if 
End if 

If ((Form event code=On Data Change) | (Form event code=On Clicked))
	[Contacts]Country:=Self->{0}
	Contacts_UpdateAddressFields
End if 
