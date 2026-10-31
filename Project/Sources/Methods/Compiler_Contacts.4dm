//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Compiler_Contacts

// Compiler variables related to the Contacts handling routines.
// Just for use by the compiler.  Not called directly.

// Parameters: None

// Returns: Nothing

// Created by 4D, Inc. on May 2, 2003
// Modified by 4D, Inc. on Jun 27, 2003
//   Removed two Company variable declarations that were already in the Compiler_Company method.
// ----------------------------------------------------

// Variables
C_LONGINT(CONTACTS_DELETEINVOICEBUTTON_I)
C_LONGINT(CONTACTS_EMAILBUTTON_I)
C_LONGINT(CONTACTS_NEWINVOICEBUTTON_I)
C_LONGINT(CONTACTS_VIEWINVOICEBUTTON_I)
C_LONGINT(CONTACTS_WEBBUTTON_I)
C_TEXT(CONTACTS_NAMEADDRESS_T)
C_TEXT(CONTACTS_PHONEEMAIL_T)
C_TEXT(CONTACTS_STATELABEL_T)
C_TEXT(CONTACTS_POSTALCODELABEL_T)

// Interprocess Variables
C_LONGINT(<>Contacts_AddRecordNumber_i)
C_LONGINT(<>Contacts_AtStartupCheckbox_i)

C_TEXT(<>Contacts_NameColumnLabel_t)
C_TEXT(<>Contacts_NameLabel_t)
C_TEXT(<>Contacts_FirstNameLabel_t)
C_TEXT(<>Contacts_LastNameLabel_t)
C_TEXT(<>Contacts_PhoneLabel_t)
C_TEXT(<>Contacts_FaxLabel_t)
C_TEXT(<>Contacts_CompanyLabel_t)
C_TEXT(<>Contacts_AddressLabel_t)
C_TEXT(<>Contacts_CountryLabel_t)
C_TEXT(<>Contacts_VoiceLabel_t)
C_TEXT(<>Contacts_EmailLabel_t)
C_TEXT(<>Contacts_WebSiteLabel_t)

// Arrays
ARRAY TEXT(CONTACTS_COUNTRYPOPUP_AT; 0)
ARRAY POINTER(Contacts_FindFields_aptr; 0)

// Parameters
C_TEXT(Contacts_FullName; $0)

C_TEXT(Contacts_FullAddress; $0)
C_BOOLEAN(Contacts_FullAddress; $1; $2)

C_BOOLEAN(Contacts_IsUSA; $0)
C_TEXT(Contacts_IsUSA; $1)
