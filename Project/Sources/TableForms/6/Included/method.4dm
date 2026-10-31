// ----------------------------------------------------

// Form Method: [Invoices].Included


// Created by 4D, Inc. on Sep 2, 2004

// ----------------------------------------------------


Case of 
	: (Form event code=On Display Detail)
		OBJECT SET FORMAT([Invoices]Total; <>Gen_MoneyFormat_t)
		//If (Displayed line number%2=0)
		//OBJECT SET RGB COLORS(*;"RowBackground";-1;0x00FFFFFF)
		//Else 
		//OBJECT SET RGB COLORS(*;"RowBackground";-1;0x00EDF3FE)
		//End if 
End case 
