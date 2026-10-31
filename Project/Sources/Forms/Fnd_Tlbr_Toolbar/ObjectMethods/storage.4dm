// Object Method: FP.storage
// ----------------------------------------------------

C_TEXT($Text_t)

If (Form event code=On Load)
	OBJECT SET VISIBLE(*; "storage"; (Not(Is compiled mode) | (Shift down)))
	
Else 
	If (Storage#Null)
		$Text_t:=JSON Stringify(Storage; *)
	Else 
		$Text_t:=JSON Stringify(New object)
	End if 
	SET TEXT TO PASTEBOARD($Text_t)
	
End if 