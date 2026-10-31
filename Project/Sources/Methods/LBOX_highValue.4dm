//%attributes = {"invisible":true,"shared":true,"lang":"en"}
// Superseded by Fnd_Hook_Out_RowStyle.

// LISTBOX SET PROPERTY(*; "Fnd_Out_ListBox";lk meta expression;"LBOX_highValue")

If (This.Total>500) | (This.ListPrice>500)
	
	
	$0:=New object(\
		"fontStyle"; "bold"; \
		"fontWeight"; "bold"; \
		"textDecoration"; "normal")
Else 
	//$0:=New object(\
		"fontStyle"; "normal"; \
		"fontWeight"; "normal"; \
		"textDecoration"; "normal")
End if 


