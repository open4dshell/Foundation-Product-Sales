//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Compiler_Invoices

// Compiler variables related to the Invoice handling routines.
// Just for use by the compiler.  Not called directly.

// Parameters: None

// Returns: Nothing

// Created by 4D, Inc. on May 2, 2003
// Modified by 4D, Inc. on Jun 27, 2003
//   Fixed a longint variable that was accidentally declared as a real.
// ----------------------------------------------------

// Variables

C_LONGINT(INVOICES_ADDLINEITEMBUTTON_I)
C_LONGINT(INVOICES_LOOKUPLINEITEMBUTTON_I)
C_LONGINT(INVOICES_CLEARCONTACTBUTTON_I)
C_LONGINT(INVOICES_DELETELINEITEMBUTTON_I)
C_LONGINT(INVOICES_NEWCONTACTBUTTON_I)
C_LONGINT(INVOICES_SELECTCONTACTBUTTON_I)
C_LONGINT(INVOICES_VIEWCONTACTBUTTON_I)
C_LONGINT(INVOICES_PRINTBUTTON_I)
C_LONGINT(INVOICES_OKBUTTON_I)
C_LONGINT(INVOICES_CANCELBUTTON_I)
C_LONGINT(INVOICES_CALENDARBUTTON_I)
C_TEXT(INVOICES_COMPANYINFO_T)
C_TEXT(INVOICES_CONTACTINFO_T)
C_TEXT(INVOICES_CONTACTNAME_T)

// Interprocess Variables
C_LONGINT(<>INVOICES_FROMCONTACTID_I)  // 4D030627 - Changed from Real to Longint.
C_LONGINT(<>Invoices_AtStartupCheckbox_i)

C_TEXT(<>Invoices_NumberColumnLabel_t)
C_TEXT(<>Invoices_DateColumnLabel_t)
C_TEXT(<>Invoices_CustomerColumnLabel_t)
C_TEXT(<>Invoices_NumberLabel_t)
C_TEXT(<>Invoices_DateLabel_t)
C_TEXT(<>Invoices_ContactLabel_t)
C_TEXT(<>Invoices_TermsLabel_t)
C_TEXT(<>Invoices_QuantityLabel_t)
C_TEXT(<>Invoices_ProductNumberLabel_t)
C_TEXT(<>Invoices_ListPriceLabel_t)
C_TEXT(<>Invoices_SellPriceLabel_t)
C_TEXT(<>Invoices_PrintTitle_t)
C_TEXT(<>Invoices_PrintBillTo_t)
C_TEXT(<>Invoices_PrintDate_t)
C_TEXT(<>Invoices_PrintInvoiceNo_t)
C_TEXT(<>Invoices_DescriptionLabel_t)
C_TEXT(<>Invoices_ExtendedPriceLabel_t)
C_TEXT(<>Invoices_SubtotalLabel_t)
C_TEXT(<>Invoices_TaxLabel_t)
C_TEXT(<>Invoices_ShippingLabel_t)
C_TEXT(<>Invoices_TotalLabel_t)
C_TEXT(<>Invoices_PrintTerms_t)

// Arrays
ARRAY TEXT(INVOICES_CONTACTCOMPANIES_AT; 0)
ARRAY TEXT(INVOICES_CONTACTNAMES_AT; 0)
ARRAY TEXT(INVOICES_TERMSPOPUP_AT; 0)

// Parameters
C_LONGINT(Invoices_SelectContact; $0)

C_TEXT(Invoices_GetContactInfo; $0)
