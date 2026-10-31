// Object Method: FP.Form
// ----------------------------------------------------


C_TEXT($Text_t)

If (Form event code=On Load)
	OBJECT SET VISIBLE(*; "Form"; (Not(Is compiled mode) | (Shift down)))
	
Else 
	If (Form#Null)
		$Text_t:=JSON Stringify(Form; *)
	Else 
		$Text_t:=JSON Stringify(New object)
	End if 
	SET TEXT TO PASTEBOARD($Text_t)
	
End if 