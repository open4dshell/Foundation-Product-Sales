//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Invoices_LoadRelatedLineItems


// Loads and sorts all of the related records for the current [Contacts] record.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


QUERY([LineItems]; [LineItems]Invoice_ID=[Invoices]Invoice_ID)
ORDER BY([LineItems]; [LineItems]LineItem_ID; >)

// Move the current record pointer to none of the current records.

//   We do this because 4D will display the list with nothing highlighted, even

//   though there's a current record.  This means our buttons won't be properly

//   disabled or enabled.  This fixes this interface problem.

FIRST RECORD([LineItems])
PREVIOUS RECORD([LineItems])