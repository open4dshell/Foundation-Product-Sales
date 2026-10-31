//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_NavPalette

// This hook is called each time the Navigation Palette command is
//   selected from the Tools menu.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// Specify the buttons to display on the Navigation Palette.
// Or do nothing, and Foundation will display the visible tables.

Fnd_Nav_AddButtonTable(->[Contacts]; ""; Foreground color; 0x00C6D4FC)
Fnd_Nav_AddButtonTable(->[Invoices]; ""; Foreground color; 0x00C6D4FC)
Fnd_Nav_AddButtonTable(->[Products]; ""; Foreground color; 0x00C6D4FC)
Fnd_Nav_AddButtonTable(->[LineItems]; ""; Foreground color; 0x00C6D4FC)


Fnd_Nav_AddButtonMethod("Fnd_IO_DisplayRecord(->[Invoices];-3)"; Fnd_Loc_GetString("Loc_General"; "NewSaleButton"); Foreground color; 0x00E2FFDF)

Fnd_Nav_AddButtonMethod("Fnd_Pref_Editor"; "Prefs Explorer"; 0x00FF; 0x00FFFF00)

Fnd_Nav_Display
