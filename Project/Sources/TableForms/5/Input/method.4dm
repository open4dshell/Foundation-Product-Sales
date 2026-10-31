// ----------------------------------------------------

// Form Method: [Products].Input


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Sep 2, 2004

//   Added the calls to Fnd_Loc_FixLabelWidths.

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		Fnd_SqNo_SetRecordID
		
		Fnd_Loc_FixLabelWidths(-><>Products_NumberLabel_t; ->[Products]ProductNumber; -><>Products_NameLabel_t; ->[Products]ProductName; -><>Products_DescriptionLabel_t; ->[Products]Description)
		Fnd_Loc_FixLabelWidths(-><>Products_PriceLabel_t; ->[Products]ListPrice)
		
		OBJECT SET FORMAT([Products]ListPrice; <>Gen_MoneyFormat_t)
End case 

Fnd_IO_InputFormMethod