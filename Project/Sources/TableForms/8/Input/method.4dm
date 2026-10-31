// ----------------------------------------------------

// Form Method: [Company Info].Input


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Jun 8, 2004

//   Added localization code.

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		Case of 
			: (Fnd_Loc_LanguageCode="FR")
				LIST TO ARRAY("Invoice Terms (FR)"; Company_TermsPopup_at)
			Else 
				LIST TO ARRAY("Invoice Terms (EN)"; Company_TermsPopup_at)
		End case 
		
		
		Fnd_Loc_FixLabelWidths(-><>Company_NameLabel_t; ->[CompanyInfo]CompanyName; -><>Company_AddressLabel_t; ->[CompanyInfo]Address; -><>Company_PhoneLabel_t; ->[CompanyInfo]Phone; -><>Company_EmailLabel_t; ->[CompanyInfo]EmailAddress; -><>Company_WebSiteLabel_t; ->[CompanyInfo]WebSite)
		
		// Move the "Voice" label back under the Phone field.
		
		OBJECT GET COORDINATES([CompanyInfo]Phone; $fieldLeft_i; $top_i; $right_i; $bottom_i)
		OBJECT GET COORDINATES(*; "Company_VoiceLabel"; $left_i; $top_i; $right_i; $bottom_i)
		OBJECT MOVE(*; "Company_VoiceLabel"; $fieldLeft_i; $top_i; $right_i; $bottom_i; *)
		
		Fnd_Loc_FixLabelWidths(-><>Company_TermsLabel_t; ->Company_TermsPopup_at)
		
		If (Is new record(Current form table->))
			Fnd_SqNo_SetRecordID
			[CompanyInfo]CompanyName:=Fnd_Loc_GetString("Loc_Company"; "YourCompanyNameHere")
			If (Size of array(Company_TermsPopup_at)>=1)
				[CompanyInfo]DefaultTerms:=Company_TermsPopup_at{1}
			End if 
		End if 
		
		Company_TermsPopup_at{0}:=[CompanyInfo]DefaultTerms
End case 

Fnd_IO_InputFormMethod