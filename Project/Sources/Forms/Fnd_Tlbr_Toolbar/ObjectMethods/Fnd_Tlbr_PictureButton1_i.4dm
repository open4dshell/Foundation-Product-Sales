// ----------------------------------------------------
// Object Method: Fnd_Tlbr_FormMethod.Fnd_Tlbr_PictureButton1_i
// ----------------------------------------------------

C_LONGINT($buttonNumber_i)

Case of 
	: (Form event code=On Load)
		
		ARRAY POINTER($pictures_aptr; 20)
		For ($buttonNumber_i; 1; 20)
			$pictures_aptr{$buttonNumber_i}:=Get pointer("Fnd_Tlbr_ButtonImage"+String($buttonNumber_i)+"_pic")
		End for 
		
		ARRAY POINTER($buttons_aptr; 20)
		For ($buttonNumber_i; 1; 20)
			$buttons_aptr{$buttonNumber_i}:=OBJECT Get pointer(Object named; "Fnd_Tlbr_PictureButton"+String($buttonNumber_i)+"_i")
			//Get pointer("Fnd_Tlbr_PictureButton"+String($buttonNumber_i)+"_i")
		End for 
		
		Fnd_Tlbr_SetHostVars(->$pictures_aptr; ->$buttons_aptr; ->Fnd_Tlbr_Info_t)
		
		C_LONGINT($Button_i)
		C_TEXT($Columns_t; $Rows_t; $PictureName_t; $Flags_t; $displayFormat_t; $Name_t)
		
		
		For ($Button_i; 1; 20)
			$Name_t:="Fnd_Tlbr_PictureButton"+String($Button_i)+"_i"
			
			$Columns_t:="1"
			$Rows_t:="4"
			$PictureName_t:="Fnd_Tlbr_ButtonImage"+String($Button_i)+"_pic"
			
			$Flags_t:=String(16+32+128)
			$displayFormat_t:=$Columns_t+";"+$Rows_t+";"+$PictureName_t+";"+$Flags_t
			
			OBJECT SET FORMAT(*; $Name_t; $displayFormat_t)
			
		End for 
		
		
		
	: (Form event code=On Clicked)
		
		Fnd_Host_Tlbr_ButtonClck(Get pointer(OBJECT Get name(Object current)))
End case 