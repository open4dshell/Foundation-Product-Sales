//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Invoices_GetContactInfo


// Returns a string with the currently loaded [Contacts] record's name and company.


// Parameters: None


// Returns: 

//   $0 : Text : The contact's full name and company


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Oct 1, 2004

//   Now only adds the comma if a company name exists.

// ----------------------------------------------------


C_TEXT($0; $info_t)

If (Records in selection([Contacts])=1)
	$info_t:=Contacts_FullName
	If ([Contacts]Company#"")
		$info_t:=$info_t+", "+[Contacts]Company
	End if 
Else 
	$info_t:=""
End if 

$0:=$info_t
