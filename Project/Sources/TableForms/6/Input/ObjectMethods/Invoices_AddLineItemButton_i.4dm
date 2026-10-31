// ----------------------------------------------------

// Object Method: Invoices_AddLineItemButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Clicked)
		CREATE RECORD([LineItems])
		Fnd_SqNo_SetRecordID
		[LineItems]Invoice_ID:=[Invoices]Invoice_ID
		[LineItems]Quantity:=1
		SAVE RECORD([LineItems])
		Invoices_LoadRelatedLineItems
End case 
