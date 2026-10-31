//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Compiler_LineItems


// Compiler variables related to the Line Item handling routines.

// Just for use by the compiler.  Not called directly.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


// Variables

C_LONGINT(LINEITEMS_OKBUTTON_I)
C_LONGINT(LINEITEMS_CANCELBUTTON_I)
C_REAL(LINEITEMS_EXTENDED_R)
C_TEXT(LINEITEMS_PRODUCTNUMBER_T)

// Interprocess Variables


// Arrays

ARRAY TEXT(LINEITEMS_PRODUCTNAMES_AT; 0)
ARRAY TEXT(LINEITEMS_PRODUCTNUMBERS_AT; 0)
ARRAY REAL(LINEITEMS_PRODUCTPRICES_AR; 0)

// Parameters

C_LONGINT(LineItems_SelectProduct; $0)