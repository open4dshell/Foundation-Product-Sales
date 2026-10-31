// ----------------------------------------------------
// Form Method: Fnd_Pref_Preferences
// ----------------------------------------------------

Case of 
	: (Form event code=On Load)
		OBJECT SET TITLE(<>Pref_NavPaletteCheckbox_i; Fnd_Loc_GetString("Fnd_Pref"; "OpenNavAtStartup"))
		<>Pref_NavPaletteCheckbox_i:=Num(Fnd_Pref_GetBoolean("Fnd_Nav: Open at Startup"))
		
		OBJECT SET TITLE(<>Contacts_AtStartupCheckbox_i; Fnd_Loc_GetString("Loc_General"; "ContactsAtStartup"))
		<>Contacts_AtStartupCheckbox_i:=Num(Fnd_Pref_GetBoolean("Display Contacts at Startup"))
		
		OBJECT SET TITLE(<>Invoices_AtStartupCheckbox_i; Fnd_Loc_GetString("Loc_General"; "InvoicesAtStartup"))
		<>Invoices_AtStartupCheckbox_i:=Num(Fnd_Pref_GetBoolean("Display Invoices at Startup"))
End case 

Fnd_Gen_FormMethod
