// ----------------------------------------------------

// Form Method: [Contacts].Output


// Created by 4D, Inc. on May 2, 2003

// Modified by 4D, Inc. on Jun 27, 2003

//   Now the records are sorted when the window is first displayed.

// Modified by Dave Batton on Jun 7, 2004

//   Added calls to Fnd_Loc_GetString for localilzation.

// Modified by Dave Batton on Sep 20, 2004

//   Fixed a bug in the localization code. Was looking for the wrong module name.

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		ORDER BY([Contacts]; [Contacts]LastName; >; [Contacts]FirstName; >)  // 4D030627 - Added
		
		
	: (Form event code=On Display Detail)
		If (([Contacts]FirstName="") & ([Contacts]LastName="") & ([Contacts]Company=""))
			[Contacts]LastName:=Fnd_Loc_GetString("Loc_Contacts"; "NoNameOrCompany")  // DB040920 - Fixed.
			
		Else 
			[Contacts]LastName:=Contacts_FullName
		End if 
End case 

Fnd_IO_OutputFormMethod
