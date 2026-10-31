//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Contacts_FullName


// Returns the full name from the currently loaded [Contacts] record.


// Parameters: None


// Returns:

//   $0 : Text : The full name of the person.


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_TEXT($0; $fullName)

$fullName:=[Contacts]FirstName+" "+[Contacts]LastName

$0:=$fullName
