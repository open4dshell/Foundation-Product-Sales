// ----------------------------------------------------
// Form Method: [Line Items];"InvoiceIncluded"

// Created by Dave Batton on Aug 29, 2004
// ----------------------------------------------------

Case of 
	: (Form event code=On Printing Detail)
		OBJECT SET FORMAT([LineItems]ListPrice; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([LineItems]SellPrice; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([LineItems]Extended; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Subtotal; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Tax; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Shipping; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Total; <>Gen_MoneyFormat_t)
		
End case 
