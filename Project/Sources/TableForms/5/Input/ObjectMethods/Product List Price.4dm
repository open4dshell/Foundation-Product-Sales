// ----------------------------------------------------

// Object Method: [Products].Input.Price


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Data Change)
		Self->:=Round(Self->; 2)
End case 
