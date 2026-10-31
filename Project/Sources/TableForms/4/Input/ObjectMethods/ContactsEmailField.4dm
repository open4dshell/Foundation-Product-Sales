// ----------------------------------------------------
// Object Method: Email Address

// Created by Dave Batton on Oct 1, 2004
// ----------------------------------------------------

Case of 
	: (Form event code=On Data Change)
		If (Fnd_Data_EmailAddressError(Self->)>0)
			Fnd_Wnd_Position(Fnd_Wnd_CenterOnWindow)
			Fnd_Dlg_Alert(Fnd_Loc_GetString("Loc_General"; "EmailAddressError"))
			REJECT(Self->)
			HIGHLIGHT TEXT(Self->; 1; MAXTEXTLENBEFOREV11)
		End if 
End case 
