// Object Method: FP.process
// ----------------------------------------------------

C_TEXT($Text_t)
C_OBJECT($fnd)

If (Form event code=On Load)
	OBJECT SET VISIBLE(*; "process"; (Not(Is compiled mode) | (Shift down)))
	
Else 
	$fnd:=Fnd_Shell_GetFndObject
	If ($fnd#Null)
		$Text_t:=JSON Stringify($fnd; *)
	Else 
		$Text_t:=JSON Stringify(New object)
	End if 
	SET TEXT TO PASTEBOARD($Text_t)
	
End if 

