//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------

// Project Method: Contacts_LoadRelatedInvoices


// Loads and sorts all of the related records for the current [Contacts] record.

// The [Invoices] table is set to READ ONLY first.


// Parameters: None


// Returns: Nothing


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


READ ONLY([Invoices])
QUERY([Invoices]; [Invoices]Contact_ID=[Contacts]Contact_ID)
ORDER BY([Invoices]; [Invoices]InvoiceNumber; >)

// Move the current record pointer to none of the current records.
//   We do this because 4D will display the list with nothing highlighted, even
//   though there's a current record.  This means our buttons won't be properly
//   disabled or enabled.  This fixes this interface problem.

FIRST RECORD([Invoices])
PREVIOUS RECORD([Invoices])