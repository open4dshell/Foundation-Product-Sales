// ----------------------------------------------------
// Object Method: ◊Pref_NavPaletteCheckbox_i
// ----------------------------------------------------

Case of 
	: (Form event code=On Clicked)
		Fnd_Pref_SetBoolean("Fnd_Nav: Open at Startup"; (Self->=1))
End case 
