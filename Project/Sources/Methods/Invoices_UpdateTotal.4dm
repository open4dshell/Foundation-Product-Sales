//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Invoices_UpdateTotal


// Updates the invoice total based on all of the line items, the sales tax,

//   and the shipping charges.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Invoices_LoadRelatedLineItems

[Invoices]Subtotal:=Sum([LineItems]Extended)

UNLOAD RECORD([LineItems])

[Invoices]Total:=[Invoices]Subtotal+[Invoices]Tax+[Invoices]Shipping
