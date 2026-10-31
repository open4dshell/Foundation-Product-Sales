// ----------------------------------------------------

// Form Method: [Invoices].Invoice


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		READ ONLY([CompanyInfo])
		ALL RECORDS([CompanyInfo])
		Invoices_CompanyInfo_t:=[CompanyInfo]CompanyName+Char(Carriage return)
		Invoices_CompanyInfo_t:=Invoices_CompanyInfo_t+[CompanyInfo]Address+Char(Carriage return)
		Invoices_CompanyInfo_t:=Invoices_CompanyInfo_t+[CompanyInfo]Phone
		
		Invoices_ContactInfo_t:=Contacts_FullAddress(True; True)
End case 
