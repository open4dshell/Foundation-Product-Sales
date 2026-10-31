//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: LineItems_UpdateExtended


// Updates the extended price after the product, quantity, or price of a

//   line item is modified.  This also updates the invoice subtotal and total

//   if the currently loaded [Invoices] record is the parent of the [Line Items]

//   record.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


[LineItems]Extended:=Round([LineItems]Quantity*[LineItems]SellPrice; 2)
SAVE RECORD([LineItems])

If ([Invoices]Invoice_ID=[LineItems]Invoice_ID)
	Invoices_UpdateTotal
End if 
