// ----------------------------------------------------

// Object Method: Invoices_LookupLineItemButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($productID)

Case of 
	: (Form event code=On Clicked)
		ALL RECORDS([Products])
		$productID:=LineItems_SelectProduct
		
		If (OK=1)
			QUERY([Products]; [Products]Product_ID=$productID)
			
			If (Records in selection([Products])=1)
				CREATE RECORD([LineItems])
				Fnd_SqNo_SetRecordID
				[LineItems]Invoice_ID:=[Invoices]Invoice_ID
				[LineItems]Quantity:=1
				[LineItems]Product_ID:=[Products]Product_ID
				[LineItems]ProductNumber:=[Products]ProductNumber
				[LineItems]ListPrice:=[Products]ListPrice
				[LineItems]SellPrice:=[Products]ListPrice
				LineItems_UpdateExtended  // This will save the record and reload them all.
				
			Else 
				TRACE  // This shouldn't happen!
				
			End if 
		End if 
End case 
