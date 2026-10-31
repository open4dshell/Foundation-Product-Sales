//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Contacts_IsUSA (country) --> Boolean


// Returns True if the country is the United States.


// Method Type: Protected


// Parameters: 

//   $1 : Text : The country name


// Returns: 

//   $0 : Boolean : True if US


// Created by Dave Batton on Aug 8, 2004

// ----------------------------------------------------


C_BOOLEAN($0; $isUS_b)
C_TEXT($1; $country_t)

$country_t:=$1

$country_t:=Replace string($country_t; " "; "")
$country_t:=Replace string($country_t; "."; "")

Case of 
	: (($country_t="US") | ($country_t="USA"))
		$isUS_b:=True
		
	: (($country_t="UnitedStates") | ($country_t="UnitedStatesOfAmerica"))
		$isUS_b:=True
		
	: ($country_t="America")
		$isUS_b:=True
		
	Else 
		$isUS_b:=False
End case 

$0:=$isUS_b