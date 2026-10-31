Class extends Entity

Function fullName()->$result : Text
	$result:=This.FirstName+" "+This.LastName
	
Function reversedFullName->$result : Text
	$result:=This.LastName+", "+This.FirstName