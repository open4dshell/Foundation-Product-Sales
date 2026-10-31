//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_OpenTable

// A hook for setting up Foundation's Open Table dialog before it's displayed.
// Call Fnd_Shell_OpenTableAdd to specify the table names to display.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

//Fnd_Shell_OpenTableAdd(->[Contacts])  // We can add them one at a time...
//Fnd_Shell_OpenTableAdd(->[Invoices]; ->[Products])  //  ...or all at once.

Fnd_Shell_OpenTableDialog
