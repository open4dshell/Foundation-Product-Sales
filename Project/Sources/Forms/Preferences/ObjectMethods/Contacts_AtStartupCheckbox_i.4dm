// ----------------------------------------------------

// Object Method: <>Contacts_AtStartupCheckbox_i

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		Fnd_Pref_SetBoolean("Display Contacts at Startup"; (Self->=1))
End case 
