// ----------------------------------------------------

// Form Method: Report


// Created by Dave Batton on Aug 29, 2004

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		OBJECT SET FORMAT([Products]ListPrice; <>Gen_MoneyFormat_t)
End case 
