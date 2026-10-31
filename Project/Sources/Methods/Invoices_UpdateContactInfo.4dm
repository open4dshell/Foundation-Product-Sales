//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Invoices_UpdateContactInfo


// Called from various places in the [Invoices].Input form to update the

//   information displayed about the associated [Contacts] record.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


READ ONLY([Contacts])
QUERY([Contacts]; [Contacts]Contact_ID=[Invoices]Contact_ID)

Invoices_ContactName_t:=Invoices_GetContactInfo

If ([Invoices]Contact_ID>0)
	DISABLE BUTTON(->Invoices_NewContactButton_i)
	DISABLE BUTTON(->Invoices_SelectContactButton_i)
	ENABLE BUTTON(->Invoices_ClearContactButton_i)
	ENABLE BUTTON(->Invoices_ViewContactButton_i)
Else 
	ENABLE BUTTON(->Invoices_NewContactButton_i)
	ENABLE BUTTON(->Invoices_SelectContactButton_i)
	DISABLE BUTTON(->Invoices_ClearContactButton_i)
	DISABLE BUTTON(->Invoices_ViewContactButton_i)
End if 
