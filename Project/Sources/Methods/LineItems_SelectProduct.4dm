//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: LineItems_SelectProduct --> Longint

// Displays a list of [Products] from which the user can select a
//   single product record.  Assumes the records from which to select
//   are already loaded.
// Sets the OK variable to 1 if a Product is selected.

// Parameters: None

// Returns: 
//   $0 : Longint : [Products]Product_ID value of the selected record.

// Created by 4D, Inc. on May 2, 2003
// ----------------------------------------------------

C_LONGINT($0)

ORDER BY([Products]; [Products]ProductNumber; >)
SELECTION TO ARRAY([Products]Product_ID; $aProductIDs; [Products]ProductNumber; LineItems_ProductNumbers_at; [Products]ProductName; LineItems_ProductNames_at; [Products]ListPrice; LineItems_ProductPrices_ar)

Fnd_Wnd_Type(Movable form dialog box)
Fnd_Wnd_Position(Fnd_Wnd_MacOSXSheet)
Fnd_Wnd_Title(Fnd_Loc_GetString("Loc_Products"; "SelectWindowTitle"))
Fnd_Wnd_OpenFormWindow(->[LineItems]; "SelectProduct")
DIALOG([LineItems]; "SelectProduct")
CLOSE WINDOW

If (OK=1)
	$0:=$aProductIDs{LineItems_ProductNames_at}
Else 
	$0:=0
End if 

// Clear the process arrays to release the RAM they're using.
ARRAY TEXT(LineItems_ProductNumbers_at; 0)
ARRAY TEXT(LineItems_ProductNames_at; 0)
ARRAY REAL(LineItems_ProductPrices_ar; 0)