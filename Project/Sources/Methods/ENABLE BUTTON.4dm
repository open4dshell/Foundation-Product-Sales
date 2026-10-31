//%attributes = {"invisible":true,"shared":true,"lang":"en"}
// ----------------------------------------------------
// Project Method: ENABLE BUTTON (Button Name or Pointer)

// Replacement of old 4D ENABLE BUTTON command

// Parameters: 
//   $1 : Variant : This will accept a string or a pointer to a form variable

// Created by Wayne Stewart (2021-04-22T14:00:00Z)
//     wayne@4dsupport.guru
// ----------------------------------------------------

/*  USAGE NOTES

ENABLE BUTTON(->MyButton_i)
ENABLE BUTTON(->*;"OK Button")

To implement convert to v13 plus
Create this method and then do a global find and replace on the following:

Search for (do this search first):
ENABLE BUTTON(->*;
Replace with:
ENABLE BUTTON(

Then search for:
ENABLE BUTTON(->
Replace with:
ENABLE BUTTON(->

If using BBEdit or some other text editor to do the find and replace outside of 4D
you can use the following search patterns:

_O_ENABLE BUTTON:C192(*;
_O_ENABLE BUTTON:C192(

The text substitution is the same.

*/


If (False)
	C_VARIANT(ENABLE BUTTON; $1)
End if 

C_VARIANT($1)  // The button
C_LONGINT($Type_i)
$Type_i:=Value type($1)

Case of 
	: ($Type_i=Is text)
		OBJECT SET ENABLED(*; $1; True)
		
	: ($Type_i=Is pointer)
		OBJECT SET ENABLED($1->; True)
		
	Else 
		Fnd_Gen_BugAlert(Current method name; "Unexpected parameter type: "+String($Type_i))
		
End case 

