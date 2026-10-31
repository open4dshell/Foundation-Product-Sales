//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_Startup

// Place any startup code here that you want to run while the startup
//   dialog is displayed.
// You can also call your startup stuff before or after Fnd_Shell_OnStartup
//   is called from the On Startup database method.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// Modified by Dave Batton on Aug 29, 2004
//   Added some code to handle money formats.
// ----------------------------------------------------

var $testString_t; $decimal_t : Text
var $i; $delayUntilTicks_i : Integer

$testString_t:=String(1.1)

Case of 
	: ($testString_t="1.1")
		// Use "." as the decimal separator and "," as a thousands separator.
		<>Gen_MoneyFormat_t:="##,###,###,###,##0.00"
		
	: ($testString_t="1,1")
		// Use "," as the decimal separator and "." as a thousands separator.
		<>Gen_MoneyFormat_t:="##.###.###.###.##0,00"
		
	Else 
		// Get the decimal separator and build the format on-the-fly.
		$decimal_t:=$testString_t[[2]]  // Ignore the thousands separator.
		<>Gen_MoneyFormat_t:="#############0"+$decimal_t+"00"
End case 

// You wouldn't do exactly this in a real database since $1 does not equal 1€.
//   This is just for the demo.
Case of 
	: (Fnd_Loc_LanguageCode="FR")
		<>Gen_MoneyFormat_t:=<>Gen_MoneyFormat_t+" €"
	: ($testString_t="1,1")
		<>Gen_MoneyFormat_t:="€"+<>Gen_MoneyFormat_t
	Else 
		<>Gen_MoneyFormat_t:="$"+<>Gen_MoneyFormat_t
End case 



Fnd_Shell_ExcludeFromQuit("AdminWorker")
For ($i; 0; 4)
	Fnd_Shell_ExcludeFromQuit("Spare Process "+String($i))
End for 

Fnd_Shell_ExcludeFromQuit("$DevQuickOpenListener")
Fnd_Shell_ExcludeFromQuit("$Fnd_Log_Writer")  // Constant: Fnd_Log_Writer
Fnd_Shell_ExcludeFromQuit("$Log Writer")
Fnd_Shell_ExcludeFromQuit("$Process Viewer")
Fnd_Shell_ExcludeFromQuit("$xx")
Fnd_Shell_ExcludeFromQuit("$zip worker")
Fnd_Shell_ExcludeFromQuit("4D Compiler")
Fnd_Shell_ExcludeFromQuit("4DIReport_SP_Scheduler")
Fnd_Shell_ExcludeFromQuit("4DIReport_W_CreateReportFile")
Fnd_Shell_ExcludeFromQuit("AdminWorker")
Fnd_Shell_ExcludeFromQuit("Application Process")
Fnd_Shell_ExcludeFromQuit("BackupProcess")
Fnd_Shell_ExcludeFromQuit("Debug Log Tidy")
Fnd_Shell_ExcludeFromQuit("DevQuickOpen_Worker")
Fnd_Shell_ExcludeFromQuit("DevQuickOpenWorker")
Fnd_Shell_ExcludeFromQuit("Fnd_Shell_Quitter")
Fnd_Shell_ExcludeFromQuit("Fnd_SqNo_Distributor process")
Fnd_Shell_ExcludeFromQuit("Internal Time Process")
Fnd_Shell_ExcludeFromQuit("Log Flusher")
Fnd_Shell_ExcludeFromQuit("Log Maintenance")
Fnd_Shell_ExcludeFromQuit("Log Writer")
//  2026-08-06T00:00 : REL-267: Sched_Dispatch is the worker that Sched.register
//  remaps "Sched_Loop" targets onto. cs.Sched excludes it dynamically too, but
//  list it here alongside Sched_Loop so the static list stays complete.
Fnd_Shell_ExcludeFromQuit("Sched_Dispatch")
Fnd_Shell_ExcludeFromQuit("Sched_Loop")
Fnd_Shell_ExcludeFromQuit("$Fnd_FCS_SchedStart")
Fnd_Shell_ExcludeFromQuit("Spare Process 0")
Fnd_Shell_ExcludeFromQuit("Spare Process 1")
Fnd_Shell_ExcludeFromQuit("Spare Process 2")
Fnd_Shell_ExcludeFromQuit("Spare Process 3")
Fnd_Shell_ExcludeFromQuit("Spare Process 4")
Fnd_Shell_ExcludeFromQuit("Spare Process 5")
Fnd_Shell_ExcludeFromQuit("Spare Process 6")
Fnd_Shell_ExcludeFromQuit("Spare Process 7")
Fnd_Shell_ExcludeFromQuit("Spare Process 8")
Fnd_Shell_ExcludeFromQuit("Spare Process 9")
Fnd_Shell_ExcludeFromQuit("Spare Process")
Fnd_Shell_ExcludeFromQuit("syn_ApplyUpdates")
Fnd_Shell_ExcludeFromQuit("Syn_PullFromServer")
Fnd_Shell_ExcludeFromQuit("Syn_PushToServer")
Fnd_Shell_ExcludeFromQuit("theStamper")


// Create a localized colon string to use after field name labels & such.
<>Gen_Colon_t:=Fnd_Loc_GetString("Loc_General"; "Colon")

// Load some other localization strings.
<>Company_NameLabel_t:=Fnd_Loc_GetString("Loc_Company"; "NameLabel")
<>Company_AddressLabel_t:=Fnd_Loc_GetString("Loc_Company"; "AddressLabel")
<>Company_PhoneLabel_t:=Fnd_Loc_GetString("Loc_Company"; "PhoneLabel")
<>Company_VoiceLabel_t:=Fnd_Loc_GetString("Loc_Company"; "VoiceLabel")
<>Company_FaxLabel_t:=Fnd_Loc_GetString("Loc_Company"; "FaxLabel")
<>Company_EmailLabel_t:=Fnd_Loc_GetString("Loc_Company"; "EmailLabel")
<>Company_WebSiteLabel_t:=Fnd_Loc_GetString("Loc_Company"; "WebSiteLabel")
<>Company_InvoiceLabel_t:=Fnd_Loc_GetString("Loc_Company"; "InvoicesLabel")
<>Company_TermsLabel_t:=Fnd_Loc_GetString("Loc_Company"; "DefaultTermsLabel")

<>Contacts_NameColumnLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "NameColumnLabel")
<>Contacts_NameLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "NameLabel")
<>Contacts_FirstNameLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "FirstNameLabel")
<>Contacts_LastNameLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "LastNameLabel")
<>Contacts_CompanyLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "CompanyLabel")
<>Contacts_AddressLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "AddressLabel")
<>Contacts_CountryLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "CountryLabel")
<>Contacts_PhoneLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "PhoneLabel")
<>Contacts_VoiceLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "VoiceLabel")
<>Contacts_FaxLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "FaxLabel")
<>Contacts_EmailLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "EmailLabel")
<>Contacts_WebSiteLabel_t:=Fnd_Loc_GetString("Loc_Contacts"; "WebSiteLabel")

<>Invoices_NumberColumnLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "NumberColumnLabel")
<>Invoices_DescriptionLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "DescriptionLabel")
<>Invoices_DateColumnLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "DateColumnLabel")
<>Invoices_CustomerColumnLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "CustomerColumnLabel")

<>Invoices_NumberLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "NumberLabel")
<>Invoices_DateLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "DateLabel")
<>Invoices_ContactLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "ContactLabel")
<>Invoices_TermsLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "TermsLabel")
<>Invoices_QuantityLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "QuantityLabel")
<>Invoices_ProductNumberLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "ProductNumberLabel")
<>Invoices_ListPriceLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "ListPriceLabel")
<>Invoices_ExtendedPriceLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "ExtendedPriceLabel")
<>Invoices_SellPriceLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "SellPriceLabel")
<>Invoices_PrintTitle_t:=Fnd_Loc_GetString("Loc_Invoices"; "PrintTitle")
<>Invoices_PrintBillTo_t:=Fnd_Loc_GetString("Loc_Invoices"; "PrintBillTo")
<>Invoices_PrintDate_t:=Fnd_Loc_GetString("Loc_Invoices"; "PrintDate")
<>Invoices_PrintInvoiceNo_t:=Fnd_Loc_GetString("Loc_Invoices"; "PrintInvoiceNo")
<>Invoices_PrintTerms_t:=Fnd_Loc_GetString("Loc_Invoices"; "PrintTerms")
<>Invoices_SubtotalLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "SubtotalLabel")
<>Invoices_TaxLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "TaxLabel")
<>Invoices_ShippingLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "ShippingLabel")
<>Invoices_TotalLabel_t:=Fnd_Loc_GetString("Loc_Invoices"; "TotalLabel")

<>Products_NumberColumnLabel_t:=Fnd_Loc_GetString("Loc_Products"; "NumberColumnLabel")
<>Products_NumberLabel_t:=Fnd_Loc_GetString("Loc_Products"; "NumberLabel")
<>Products_NameLabel_t:=Fnd_Loc_GetString("Loc_Products"; "NameLabel")
<>Products_DescriptionLabel_t:=Fnd_Loc_GetString("Loc_Products"; "DescriptionLabel")
<>Products_PriceLabel_t:=Fnd_Loc_GetString("Loc_Products"; "PriceLabel")
<>Products_SelectNumberLabel_t:=Fnd_Loc_GetString("Loc_Products"; "SelectNumberLabel")




If (Records in table([Invoices])=0)
	Fnd_SqNo_Set("Invoice Number"; 1001)  // Start invoices at this number. Don't localize this.
End if 

If (Fnd_Pref_GetBoolean("Display Contacts at Startup"; True))
	Fnd_IO_DisplayTable(->[Contacts])  // Display the Contacts table window.
End if 

If (Fnd_Pref_GetBoolean("Display Invoices at Startup"; True))
	Fnd_IO_DisplayTable(->[Invoices])  // Just for this demo.
End if 

//If there's no [Company Info] record, display the edit window so the user
//   can create a record.
If (Records in table([CompanyInfo])=0)
	// Delay for one second first, so this window will open up in front of the Contacts window.
	$delayUntilTicks_i:=Tickcount+60  // 60 ticks = 1 second
	Repeat 
		IDLE  // Can't use DELAY PROCESS since we're probably be in the User/Custom Menus process.
	Until (Tickcount>$delayUntilTicks_i)
	Company_EditSettings
End if 



Fnd_FCS_SchedStart  // Started last

