//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Company_EditSettings

// Displays the [Company Info] record for editing.
// By default, this application is designed to have just one
//   company record.  There's no reason this couldn't be changed
//   with a little work to support multiple companies.
// Launches itself in a new process.

// Parameters: None

// Returns: Nothing

// Created by 4D, Inc. on May 2, 2003
// ----------------------------------------------------

READ ONLY([CompanyInfo])  // We'll be editing the record in a new process.
ALL RECORDS([CompanyInfo])

// Notice the behavior of the window opened here is set in Fnd_aa_IO_DisplayRecord.
If (Records in selection([CompanyInfo])=0)
	Fnd_Rec_NewRecord(->[CompanyInfo])
Else 
	Fnd_IO_DisplayRecord(->[CompanyInfo]; Record number([CompanyInfo]))
End if 
