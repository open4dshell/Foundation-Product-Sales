//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Contacts_UpdateAddressFields


// Displays the proper set of address fields based on the selected country.


// Parameters: None


// Returns: Nothing


// Created by Dave Batton on Jul 13, 2004

// ----------------------------------------------------


Case of 
	: ((Contacts_IsUSA([Contacts]Country)) | ([Contacts]Country=""))
		OBJECT SET VISIBLE(*; "Contacts_USCity@"; True)
		OBJECT SET VISIBLE(*; "Contacts_USState@"; True)
		OBJECT SET VISIBLE(*; "Contacts_USZip@"; True)
		OBJECT SET VISIBLE(*; "Contacts_OtherCity@"; False)
		OBJECT SET VISIBLE(*; "Contacts_OtherPostal@"; False)
		Contacts_StateLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "StateLabel")
		Contacts_PostalCodeLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "ZipCodeLabel")
		
	: ([Contacts]Country="Canada")
		OBJECT SET VISIBLE(*; "Contacts_USCity@"; True)
		OBJECT SET VISIBLE(*; "Contacts_USState@"; True)
		OBJECT SET VISIBLE(*; "Contacts_USZip@"; True)
		OBJECT SET VISIBLE(*; "Contacts_OtherCity@"; False)
		OBJECT SET VISIBLE(*; "Contacts_OtherPostal@"; False)
		Contacts_StateLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "ProvinceLabel")
		Contacts_PostalCodeLabel_t:=Fnd_VS_FieldName(->[Contacts]PostalCode)
		
	Else 
		[Contacts]State:=""
		OBJECT SET VISIBLE(*; "Contacts_USCity@"; False)
		OBJECT SET VISIBLE(*; "Contacts_USState@"; False)
		OBJECT SET VISIBLE(*; "Contacts_USZip@"; False)
		OBJECT SET VISIBLE(*; "Contacts_OtherCity@"; True)
		OBJECT SET VISIBLE(*; "Contacts_OtherPostal@"; True)
End case 
