// ----------------------------------------------------
// Form Method: [Invoices].Report

// Created by 4D, Inc. on May 2, 2003
// Modified by Dave Batton on Aug 29, 2004
//   Money formats are now handled procedurally.
// ----------------------------------------------------


Case of 
	: (Form event code=On Printing Detail)
		OBJECT SET FORMAT([Invoices]Subtotal; <>Gen_MoneyFormat_t)  // DB040829 - Added
		OBJECT SET FORMAT([Invoices]Total; <>Gen_MoneyFormat_t)  // DB040829 - Added
End case 
