// ----------------------------------------------------

// Form Method: [Line Items].Included


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Aug 29, 2004

//   Money formats are now handled procedurally.

// ----------------------------------------------------


Case of 
	: (Form event code=On Display Detail)
		LineItems_ProductNumber_t:=[Products]ProductNumber
		LineItems_Extended_r:=[LineItems]Quantity*[LineItems]SellPrice
		
		OBJECT SET FORMAT([LineItems]ListPrice; <>Gen_MoneyFormat_t)  // DB040829 - Added
		
		OBJECT SET FORMAT([LineItems]SellPrice; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([LineItems]Extended; <>Gen_MoneyFormat_t)
End case 
