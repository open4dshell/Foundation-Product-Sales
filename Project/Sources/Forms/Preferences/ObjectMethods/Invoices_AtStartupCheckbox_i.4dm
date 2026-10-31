// ----------------------------------------------------

// Object Method: <>Invoices_AtStartupCheckbox_i

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		Fnd_Pref_SetBoolean("Display Invoices at Startup"; (Self->=1))
End case 
