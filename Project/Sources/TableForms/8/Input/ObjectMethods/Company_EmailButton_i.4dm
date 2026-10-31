// ----------------------------------------------------

// Object Method: [Company Info].Input.Company_EmailButton_i


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_TEXT($url)

Case of 
	: (Form event code=On Clicked)
		If ([CompanyInfo]EmailAddress#"")
			$url:="mailto:"+[CompanyInfo]EmailAddress
			OPEN URL($url; *)
		End if 
End case 
