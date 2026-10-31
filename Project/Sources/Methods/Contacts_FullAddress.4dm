//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Contacts_FullAddress (with name; with country)


// Builds a complete mailing address on-the-fly based on the currently

//   loaded [Contacts] record.

// Returns a blank string if there's no address.


// Parameters: None


// Returns:

//   $0 : Text : The full mailing address.


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_BOOLEAN($1; $2; $withName; $withCountry)
C_TEXT($0; $fullAddress)

$withName:=$1
$withCountry:=$2

$fullAddress:=""

If ($withName)
	If ([Contacts]Company="")
		$fullAddress:=$fullAddress+Contacts_FullName+Char(Carriage return)
	Else 
		$fullAddress:=[Contacts]Company+Char(Carriage return)
		$fullAddress:=$fullAddress+Fnd_Loc_GetString("Loc_Invoices"; "Attn")+" "+Contacts_FullName+Char(Carriage return)
	End if 
End if 

// We don't add anything unless there's something to add.

// The goal is to return a blank string if there's no address information.

If ([Contacts]Address#"")
	$fullAddress:=$fullAddress+[Contacts]Address+Char(Carriage return)
End if 

If ((Contacts_IsUSA([Contacts]Country)) | ([Contacts]Country="Canada"))
	$fullAddress:=$fullAddress+[Contacts]City
End if 

If ([Contacts]State#"")
	If ([Contacts]City#"")
		$fullAddress:=$fullAddress+", "
	End if 
	$fullAddress:=$fullAddress+[Contacts]State
End if 

If ([Contacts]PostalCode#"")
	If ((Contacts_IsUSA([Contacts]Country)) | ([Contacts]Country="Canada"))
		If (([Contacts]City#"") | ([Contacts]State#""))
			$fullAddress:=$fullAddress+" "
		End if 
	End if 
	$fullAddress:=$fullAddress+[Contacts]PostalCode
End if 

If (Not((Contacts_IsUSA([Contacts]Country)) | ([Contacts]Country="Canada")))
	$fullAddress:=$fullAddress+" "+[Contacts]City
End if 

If (([Contacts]City#"") | ([Contacts]State#"") | ([Contacts]PostalCode#""))
	$fullAddress:=$fullAddress+Char(Carriage return)
End if 

If ($withCountry)
	$fullAddress:=$fullAddress+[Contacts]Country+Char(Carriage return)
End if 

$0:=$fullAddress
