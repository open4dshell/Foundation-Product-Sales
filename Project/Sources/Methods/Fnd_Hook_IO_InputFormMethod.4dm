//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_IO_InputFormMethod

// This hook is called from the Fnd_IO_InputFormMethod method during all input form events.

// Access Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// Call 4D's 'Current form table' or Foundation's Fnd_Gen_CurrentTable function
// to determine the current table.
// Use 4D's 'Form event' function to determine the current form event.

var $table_ptr : Pointer
var $formEvent_o : Object

$formEvent_o:=FORM Event



Case of 
	: ($formEvent_o.code=On Load)
		Case of 
			: ($table_ptr=(->[Products]))
				Fnd_SqNo_SetRecordID
				
				Fnd_Loc_FixLabelWidths(-><>Products_NumberLabel_t; ->[Products]ProductNumber; -><>Products_NameLabel_t; ->[Products]ProductName; -><>Products_DescriptionLabel_t; ->[Products]Description)
				Fnd_Loc_FixLabelWidths(-><>Products_PriceLabel_t; ->[Products]ListPrice)
				
				OBJECT SET FORMAT([Products]ListPrice; <>Gen_MoneyFormat_t)
				
				
				
				
				
				
				
		End case 
		
		
		
		
		
		
		
End case 

