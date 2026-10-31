// ----------------------------------------------------

// Form Method: [Contacts].Report


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Printing Detail)
		Contacts_NameAddress_t:=Contacts_FullName+Char(Carriage return)
		If ([Contacts]Company#"")
			Contacts_NameAddress_t:=Contacts_NameAddress_t+[Contacts]Company+Char(Carriage return)
		End if 
		Contacts_NameAddress_t:=Contacts_NameAddress_t+Contacts_FullAddress(False; True)
		
		Contacts_PhoneEmail_t:=""
		If ([Contacts]Phone#"")
			Contacts_PhoneEmail_t:=Contacts_PhoneEmail_t+"Phone: "+[Contacts]Phone+Char(Carriage return)
		End if 
		If ([Contacts]Fax#"")
			Contacts_PhoneEmail_t:=Contacts_PhoneEmail_t+"Fax: "+[Contacts]Fax+Char(Carriage return)
		End if 
		If ([Contacts]EmailAddress#"")
			Contacts_PhoneEmail_t:=Contacts_PhoneEmail_t+"Email: "+[Contacts]EmailAddress+Char(Carriage return)
		End if 
		If ([Contacts]Web Site#"")
			Contacts_PhoneEmail_t:=Contacts_PhoneEmail_t+"Web: "+[Contacts]Web Site+Char(Carriage return)
		End if 
End case 
