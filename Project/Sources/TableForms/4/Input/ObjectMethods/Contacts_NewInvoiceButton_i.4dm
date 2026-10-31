// ----------------------------------------------------
// Object Method: Contacts_NewInvoiceButton_i

// Created by 4D, Inc. on May 2, 2003
// Modified by Dave Batton on Jun 8, 2004
//   Localized.
// ----------------------------------------------------

Case of 
	: (Form event code=On Clicked)
		Case of 
			: (Is new record(Current form table->))
				Fnd_Wnd_Position(Fnd_Wnd_CenterOnWindow)
				Fnd_Dlg_SetIcon(Fnd_Dlg_NoteIcon)
				Fnd_Dlg_Confirm(Fnd_Loc_GetString("Loc_Contacts"; "RecordWillBeSaved"); Fnd_Loc_GetString("Loc_Contacts"; "SaveButton"); Fnd_Loc_GetString("Loc_Contacts"; "CancelButton"))
				If (OK=1)
					SAVE RECORD(Current form table->)
				End if 
				
			: (Modified record(Current form table->))
				Fnd_Wnd_Position(Fnd_Dlg_CenterOnWindow)
				Fnd_Dlg_SetIcon(Fnd_Dlg_NoteIcon)
				Fnd_Dlg_Confirm(Fnd_Loc_GetString("Loc_Contacts"; "SaveChanges"); Fnd_Loc_GetString("Loc_Contacts"; "SaveButton"); Fnd_Loc_GetString("Loc_Contacts"; "NotYetButton"))
				If (OK=1)
					SAVE RECORD(Current form table->)
				End if 
				OK:=1  // So even if they click Not Yet it will still continue.
				
			Else 
				OK:=1
		End case 
		
		
		If (OK=1)
			// The <>Invoices_FromContactID_i variable tells the new invoice what contact to use.
			<>Invoices_FromContactID_i:=[Contacts]Contact_ID
			Fnd_IO_DisplayRecord(->[Invoices]; New record)
		End if 
End case 
