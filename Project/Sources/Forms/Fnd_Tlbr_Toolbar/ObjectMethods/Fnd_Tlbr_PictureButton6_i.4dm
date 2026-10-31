// ----------------------------------------------------
// Object Method: Fnd_Tlbr_FormMethod.Fnd_Tlbr_PictureButton1_i
// ----------------------------------------------------

C_LONGINT($buttonNumber_i)

Case of 
	: (Form event code=On Load)
		
		
		
		
		
		
	: (Form event code=On Clicked)
		Fnd_Host_Tlbr_ButtonClck(Get pointer(OBJECT Get name(Object current)))
End case 

