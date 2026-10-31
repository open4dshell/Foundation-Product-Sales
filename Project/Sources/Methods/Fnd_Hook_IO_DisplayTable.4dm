//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_IO_DisplayTable

// This hook is called just before an output window is displayed.
// Here you can set the initial selection of records to display, configure the
//   toolbar, set the window title, or set the window position.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------

// Use Fnd_Gen_CurrentTable to determine the current table.

// To change the default output form:
//  Fnd_IO_OutputFormName ("MyOutput")

// Examples of commands to modify the toolbar:
//   Fnd_IO_ToolbarIconGroup ("Card")  ` Options: Bold/Card/Native
//   Fnd_Tlbr_Style ("Small1")  ` Options: Large/Small1/Small2
//   Fnd_Tlbr_Divider_Add 
//   Fnd_Tlbr_Button_Add ("BttnName";"Preferences";"Fnd_Bttn_Settings";"Fnd_Pref_Display")

//Fnd_Tlbr_Button_Add("prefButton"; "Preferences"; "Fnd_Bttn_Settings"; "Fnd_Pref_Display(\"Preferences\")")

//   EXAMPLE CODE:

Fnd_Out_Active(True)

Fnd_Out_Default("allowPublish"; True)

Case of 
	: (Fnd_Gen_CurrentTable=(->[Invoices]))
		Fnd_Tlbr_Style("Small2")
		Fnd_Out_Active(True)
		Fnd_Out_AddField("InvoiceNumber"; 0; "Inv. No")
		Fnd_Out_AddField("InvoiceDate"; 0; "Date")
		Fnd_Out_AddField("contact.reversedFullName()"; 0; "Contact")
		Fnd_Out_AddField("Total"; 0; ""; 0; <>Gen_MoneyFormat_t)
		
		
	: (Fnd_Gen_CurrentTable=(->[Contacts]))
		Fnd_Out_AddField(New object(\
			fo_field; "Formula: this.fullName()"; \
			fo_type; Is text; \
			fo_title; "Contact"))
		Fnd_Out_AddField(New object(\
			fo_field; "Formula: this.reversedFullName()"; \
			fo_type; Is text; \
			fo_style; Italic; \
			fo_title; "Contact Reversed"))
		Fnd_Out_Active(True)
		
		
		
	: (Fnd_Gen_CurrentTable=(->[Products]))
		
		Fnd_Out_Active(True)
		Fnd_Out_AllowCustomColumns(True)
		Fnd_IO_ToolbarIconGroup("Card")
		Fnd_IO_MultiWindow(False)  // Display the input form in the same window as the output form.
		Fnd_IO_AddMultipleRecords(True)  // Add new records until Cancel is clicked.
		
		Fnd_Out_AddField("ProductNumber"; 0; "Prod. No")
		Fnd_Out_AddField("ProductName"; 0; "Product Name")
		Fnd_Out_AddField("Description"; 0; "Description")
		//Fnd_Out_AddField("ListPrice"; 0; ""; Align default; <>Gen_MoneyFormat_t)
		
		Fnd_Out_AddField(New object(\
			fo_field; "ListPrice"; \
			fo_type; Is real; \
			fo_style; Italic+Underline; \
			fo_title; "List Price"))
		
		
		//: (Fnd_Gen_CurrentTable=(->[LineItems]))
		//Fnd_Out_AddField("invoice.contact.reversedFullName()"; 0; "Contact")
		//Fnd_Out_AddField("product.ProductNumber"; 0; "Prod. No")
		
		
End case 

