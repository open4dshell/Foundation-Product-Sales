// ----------------------------------------------------
// Form Method: [Invoices].Input

// Created by 4D, Inc. on May 2, 2003
// Modified by Dave Batton on May 22, 2004
//   Now checks that <>Contacts_AddRecordNumber_i is >0 rather than #0 to fix a bug.
// Modified by Dave Batton on Aug 29, 2004
//   Money formats are now handled procedurally.
// ----------------------------------------------------

C_LONGINT(<>Invoices_FromContactID_i; <>Contacts_AddRecordNumber_i; $move_i)
C_LONGINT($left_i; $top_i; $right_i; $bottom_i; $width_i; $height_i)
C_TEXT($windowTitle_t)

Case of 
	: (Form event code=On Load)
		// Properly size the "Number:" label
		OBJECT GET COORDINATES(<>Invoices_NumberLabel_t; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT GET BEST SIZE(<>Invoices_NumberLabel_t; $width_i; $height_i)
		OBJECT MOVE(<>Invoices_NumberLabel_t; $left_i; $top_i; $left_i+$width_i; $bottom_i; *)
		OBJECT MOVE([Invoices]InvoiceNumber; $width_i-($right_i-$left_i); 0)  // Adjust the position of the Invoice Number field.
		
		// Do the same to the "Terms:" label
		OBJECT GET COORDINATES(<>Invoices_TermsLabel_t; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT GET BEST SIZE(<>Invoices_TermsLabel_t; $width_i; $height_i)
		OBJECT MOVE(<>Invoices_TermsLabel_t; $left_i; $top_i; $left_i+$width_i; $bottom_i; *)
		OBJECT MOVE(Invoices_TermsPopup_at; $width_i-($right_i-$left_i); 0)  // Adjust the position of the Terms combo box.
		
		// We can use a Foundation routine for the "Customer:" label and field,
		//   since we want to maintain the overall width of the two objects.
		Fnd_Loc_FixLabelWidths(-><>Invoices_ContactLabel_t; ->Invoices_ContactName_t)
		
		// Localize the form.
		$move_i:=Fnd_Gen_ButtonText(->Invoices_ViewContactButton_i; Fnd_Loc_GetString("Loc_Invoices"; "ViewButton"); Align right)
		OBJECT MOVE(Invoices_ClearContactButton_i; $move_i; 0)
		OBJECT MOVE(Invoices_SelectContactButton_i; $move_i; 0)
		OBJECT MOVE(Invoices_NewContactButton_i; $move_i; 0)
		
		$move_i:=Fnd_Gen_ButtonText(->Invoices_ClearContactButton_i; Fnd_Loc_GetString("Loc_Invoices"; "ClearButton"); Align right)
		OBJECT MOVE(Invoices_SelectContactButton_i; $move_i; 0)
		OBJECT MOVE(Invoices_NewContactButton_i; $move_i; 0)
		
		$move_i:=Fnd_Gen_ButtonText(->Invoices_SelectContactButton_i; Fnd_Loc_GetString("Loc_Invoices"; "SelectButton"); Align right)
		OBJECT MOVE(Invoices_NewContactButton_i; $move_i; 0)
		
		Fnd_Gen_ButtonText(->Invoices_NewContactButton_i; Fnd_Loc_GetString("Loc_Invoices"; "NewButton"); Align right)
		
		$move_i:=Fnd_Gen_ButtonText(->Invoices_AddLineItemButton_i; Fnd_Loc_GetString("Loc_Invoices"; "AddItemButton"); Align left)
		OBJECT MOVE(Invoices_LookupLineItemButton_i; $move_i; 0)
		OBJECT MOVE(Invoices_DeleteLineItemButton_i; $move_i; 0)
		
		$move_i:=Fnd_Gen_ButtonText(->Invoices_LookupLineItemButton_i; Fnd_Loc_GetString("Loc_Invoices"; "LookupItemButton"); Align left)
		OBJECT MOVE(Invoices_DeleteLineItemButton_i; $move_i; 0)
		
		Fnd_Gen_ButtonText(->Invoices_DeleteLineItemButton_i; Fnd_Loc_GetString("Loc_Invoices"; "DeleteItemButton"); Align left)
		
		Fnd_Gen_ButtonText(->Invoices_PrintButton_i; Fnd_Loc_GetString("Loc_Invoices"; "PrintButton"); Align left)
		
		$move_i:=Fnd_Gen_ButtonText(->Invoices_OKButton_i; Fnd_Loc_GetString("Loc_Invoices"; "OKButton"); Align right)
		OBJECT MOVE(Invoices_CancelButton_i; $move_i; 0)
		
		Fnd_Gen_ButtonText(->Invoices_CancelButton_i; Fnd_Loc_GetString("Loc_Invoices"; "CancelButton"); Align right)
		
		OBJECT SET FORMAT([Invoices]Subtotal; <>Gen_MoneyFormat_t)  // DB040829 - Added
		OBJECT SET FORMAT([Invoices]Tax; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Shipping; <>Gen_MoneyFormat_t)
		OBJECT SET FORMAT([Invoices]Total; <>Gen_MoneyFormat_t)
		
		START TRANSACTION  // So we can undo changes to [Line Items] records.
		
		If (Is new record(Current form table->))
			// Unlike the other tables, we must assign an ID immediately for use by the line item records.
			Fnd_SqNo_SetRecordID
			
			[Invoices]InvoiceNumber:=Fnd_SqNo_Get("Invoice Number")  // Don't localize this.
			
			[Invoices]InvoiceDate:=Current date
			READ ONLY([CompanyInfo])
			ALL RECORDS([CompanyInfo])
			[Invoices]Terms:=[CompanyInfo]DefaultTerms
			
			// If <>Invoices_FromContactID_i has a value, we should use it as the ID number
			//   of the associated contact.
			If (<>Invoices_FromContactID_i#0)
				[Invoices]Contact_ID:=<>Invoices_FromContactID_i
				<>Invoices_FromContactID_i:=0
			End if 
			
			<>Contacts_AddRecordNumber_i:=No current record
		End if 
		
		//SET WINDOW TITLE("Invoice "+String([Invoices]Invoice Number;"|Invoices_InvoiceNumberFormat"))
		
		Case of 
			: (Fnd_Loc_LanguageCode="FR")
				LIST TO ARRAY("Invoice Terms (FR)"; Invoices_TermsPopup_at)
			Else 
				LIST TO ARRAY("Invoice Terms (EN)"; Invoices_TermsPopup_at)
		End case 
		Invoices_TermsPopup_at{0}:=[Invoices]Terms
		
		// Update the variable that displays the related [Contacts] record.
		Invoices_UpdateContactInfo
		Invoices_LoadRelatedLineItems
		
		Fnd_Menu_Window_Add
		
		
	: (Form event code=On Outside Call)
		// If the user clicked the New button to add a new contact, we'll get
		//   get an Outside Call when (if) the record gets saved.
		If (<>Contacts_AddRecordNumber_i>0)  // DB040522 - Changed from #0 to >0 to fix a bug.
			READ ONLY([Contacts])
			GOTO RECORD([Contacts]; <>Contacts_AddRecordNumber_i)
			[Invoices]Contact_ID:=[Contacts]Contact_ID
			<>Contacts_AddRecordNumber_i:=0
		End if 
		// Update the variable that displays the related [Contacts] record.
		// It may have just been updated.
		Invoices_UpdateContactInfo
		
	: (Form event code=On Validate)
		VALIDATE TRANSACTION
		
	: (Form event code=On Unload)
		If (Record number(Current form table->)=New record)
			Fnd_SqNo_Put("Invoice Number"; [Invoices]InvoiceNumber)
		End if 
		CANCEL TRANSACTION
End case 

If (Record number([LineItems])=No current record)
	DISABLE BUTTON(->Invoices_DeleteLineItemButton_i)
Else 
	ENABLE BUTTON(->Invoices_DeleteLineItemButton_i)
End if 

Fnd_IO_InputFormMethod