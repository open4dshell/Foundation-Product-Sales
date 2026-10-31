// ----------------------------------------------------

// Form Method: [Contacts].Input


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($move_i; $move1_i; $move2_i; $move3_i)

Case of 
	: (Form event code=On Load)
		Fnd_SqNo_SetRecordID
		
		// Align the fields.
		
		Fnd_Loc_FixLabelWidths(-><>Contacts_NameLabel_t; ->[Contacts]FirstName; -><>Contacts_CompanyLabel_t; ->[Contacts]Company; -><>Contacts_AddressLabel_t; ->[Contacts]Address; -><>Contacts_CountryLabel_t; ->Contacts_CountryPopup_at; -><>Contacts_PhoneLabel_t; ->[Contacts]Phone; -><>Contacts_EmailLabel_t; ->[Contacts]EmailAddress; -><>Contacts_WebSiteLabel_t; ->[Contacts]Web Site)
		
		// Move the "First Name" label back under the First Name field.
		
		OBJECT GET COORDINATES([Contacts]Phone; $fieldLeft_i; $top_i; $right_i; $bottom_i)
		OBJECT GET COORDINATES(*; "Contacts_FirstNameLabel"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_FirstNameLabel"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		
		// We need to manually move these Postal Code and City fields, and the labels.
		
		OBJECT GET COORDINATES([Contacts]Address; $fieldLeft_i; $top_i; $right_i; $bottom_i)
		
		OBJECT GET COORDINATES(*; "Contacts_USCityField"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_USCityField"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		OBJECT GET COORDINATES(*; "Contacts_USCityLabel"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_USCityLabel"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		
		OBJECT GET COORDINATES(*; "Contacts_OtherPostalField"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_OtherPostalField"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		OBJECT GET COORDINATES(*; "Contacts_OtherPostalLabel"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_OtherPostalLabel"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		
		// Move the "Voice" label back under the Phone field.
		
		OBJECT GET COORDINATES([Contacts]Phone; $fieldLeft_i; $top_i; $right_i; $bottom_i)
		OBJECT GET COORDINATES(*; "Contacts_VoiceLabel"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Contacts_VoiceLabel"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		
		// Localize and resize the buttons.
		
		$move1_i:=Fnd_Gen_ButtonText(->Contacts_NewInvoiceButton_i; Fnd_Loc_GetString("Loc_Contacts"; "NewButton"); Align right)
		$move2_i:=Fnd_Gen_ButtonText(->Contacts_ViewInvoiceButton_i; Fnd_Loc_GetString("Loc_Contacts"; "ViewButton"); Align right)
		$move3_i:=Fnd_Gen_ButtonText(->Contacts_DeleteInvoiceButton_i; Fnd_Loc_GetString("Loc_Contacts"; "DeleteButton"); Align right)
		
		// Now figure out how much we need to move the included list, and resize it.
		
		Case of 
			: (($move1_i<$move2_i) & ($move1_i<$move3_i))
				$move_i:=$move1_i
			: ($move2_i<$move3_i)
				$move_i:=$move2_i
			Else 
				$move_i:=$move3_i
		End case 
		OBJECT MOVE(*; "Contact_InvoicesSubform"; 0; 0; $move_i; 0)
		
		Fnd_Loc_FixButtonWidths(->Contacts_NewInvoiceButton_i; ->Contacts_ViewInvoiceButton_i; ->Contacts_DeleteInvoiceButton_i)
		
		Case of 
			: (Fnd_Loc_LanguageCode="FR")
				LIST TO ARRAY("Countries (FR)"; Contacts_CountryPopup_at)
			Else 
				LIST TO ARRAY("Countries (EN)"; Contacts_CountryPopup_at)
		End case 
		Contacts_CountryPopup_at{0}:=[Contacts]Country
		
		Contacts_UpdateAddressFields
		Contacts_UpdateWindowTitle
		
		
	: (Form event code=On Activate)
		Contacts_LoadRelatedInvoices  // Sets the [Invoices] table to read-only. 
		
		
		
	: (Form event code=On Validate)
		<>Contacts_AddRecordNumber_i:=Record number([Contacts])  // The [Invoices].Input form will check this.
		
End case 


// Disable the Email button if there is no email address.

If ([Contacts]EmailAddress="")
	DISABLE BUTTON(->Contacts_EmailButton_i)
Else 
	ENABLE BUTTON(->Contacts_EmailButton_i)
End if 

// Disable the Web button if there is no email address.

If ([Contacts]Web Site="")
	DISABLE BUTTON(->Contacts_WebButton_i)
Else 
	ENABLE BUTTON(->Contacts_WebButton_i)
End if 

If (Record number([Invoices])=No current record)
	DISABLE BUTTON(->Contacts_ViewInvoiceButton_i)
	DISABLE BUTTON(->Contacts_DeleteInvoiceButton_i)
Else 
	ENABLE BUTTON(->Contacts_ViewInvoiceButton_i)
	ENABLE BUTTON(->Contacts_DeleteInvoiceButton_i)
End if 

Fnd_IO_InputFormMethod