// ----------------------------------------------------
// Object Method: Fnd_Tlbr_InvisibleButton1_i

// Created by Dave Batton on Nov 7, 2005
// ----------------------------------------------------
C_TEXT($ButtonName_t)

Case of 
	: (Form event code=On Clicked)
		$ButtonName_t:=OBJECT Get name(Object current)
		$ButtonName_t:=Replace string($ButtonName_t; "Fnd_Tlbr_InvisibleButton"; "Fnd_Tlbr_PictureButton")
		Fnd_Host_Tlbr_ButtonClck(Get pointer($ButtonName_t))
End case 