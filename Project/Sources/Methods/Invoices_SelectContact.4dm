//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Invoices_SelectContact --> Longint

// Displays a list of [Contacts] from which the user can select a
//   single contact record.
// Sets the OK variable to 1 if a contact is selected.

// Parameters: None

// Returns: 
//   $0 : Longint : [Contact]Contact_ID value of the selected contact.

// Created by 4D, Inc. on May 2, 2003
// Modified by 4D, Inc. on Jun 27, 2003
//   Now the records are sorted before creating the arrays.
// ----------------------------------------------------

C_LONGINT($0; $i)

READ ONLY([Contacts])
ALL RECORDS([Contacts])
ORDER BY([Contacts]; [Contacts]LastName; >; [Contacts]FirstName; >)  // 4D030627 - Added
SELECTION TO ARRAY([Contacts]Contact_ID; $aContactIDs; [Contacts]FirstName; $FirstNames_at; [Contacts]LastName; Invoices_ContactNames_at; [Contacts]Company; Invoices_ContactCompanies_at)

For ($i; 1; Size of array($FirstNames_at))
	Invoices_ContactNames_at{$i}:=$FirstNames_at{$i}+" "+Invoices_ContactNames_at{$i}
End for 

Fnd_Wnd_Type(Movable form dialog box)
Fnd_Wnd_Position(Fnd_Wnd_CenterOnWindow)
Fnd_Wnd_Title("Select a Contact")
Fnd_Wnd_OpenFormWindow(->[Invoices]; "SelectContact")
DIALOG([Invoices]; "SelectContact")
CLOSE WINDOW

If (OK=1)
	$0:=$aContactIDs{Invoices_ContactNames_at}
Else 
	$0:=0
End if 

// Clear the process arrays to release the RAM they're using.
ARRAY TEXT(Invoices_ContactNames_at; 0)
ARRAY TEXT(Invoices_ContactCompanies_at; 0)