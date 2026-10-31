// ----------------------------------------------------

// Object Method: Product Number


// When modified, looks up the product number in the [Products] table.

// If no matches are found or multiple matches are found, a selection list

//   is presented so the user can choose a product.


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($productID)

Case of 
	: (Form event code=On Data Change)
		READ ONLY([Products])
		
		If (Self->="")
			REDUCE SELECTION([Products]; 0)
			
		Else 
			QUERY([Products]; [Products]ProductNumber=(Self->+"@"))
			
			Case of 
				: (Records in selection([Products])=0)
					ALL RECORDS([Products])
					$productID:=LineItems_SelectProduct
					If (OK=1)
						QUERY([Products]; [Products]Product_ID=$productID)
					Else 
						REDUCE SELECTION([Products]; 0)
					End if 
					
				: (Records in selection([Products])>1)
					$productID:=LineItems_SelectProduct
					If (OK=1)
						QUERY([Products]; [Products]Product_ID=$productID)
					Else 
						REDUCE SELECTION([Products]; 0)
					End if 
			End case 
		End if 
		
		
		Self->:=[Products]ProductNumber
		[LineItems]Product_ID:=[Products]Product_ID
		[LineItems]ListPrice:=[Products]ListPrice
		[LineItems]SellPrice:=[LineItems]ListPrice
		
		LineItems_UpdateExtended
End case 
