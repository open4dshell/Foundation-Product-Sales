//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_Shell_Sort

// A hook for setting up Foundation's Sort dialog before it's displayed.
// Call Fnd_Gen_CurrentTable to determine the table in use.

// Method Type: Public

// Parameters: None

// Returns: Nothing
// ----------------------------------------------------
C_OBJECT($es)
C_BOOLEAN($usingFndOut_b)




If (Macintosh option down)  // Also works for the Windows' Alt key.
	Fnd_Menu_SortOrderEditor  // Display 4D's Order By Editor.
	
Else 
	// Case of                                                        --Example Code--
	//     : (Fnd_Gen_CurrentTable=(->[People]))
	//         Fnd_Sort_AddTable (Fnd_Gen_CurrentTable )
	//         Fnd_Sort_AddSeparator 
	//         Fnd_Sort_AddField (->[Companies]Company Name)
	// End case 
	
	$usingFndOut_b:=Fnd_Gen_ComponentInfo("Fnd_Out"; "state")="active"
	If ($usingFndOut_b)
		Fnd_Out_SynchroniseSelection
		Fnd_Sort_Display  // Display Foundation's Sort dialog.
		Form.listData:=Create entity selection(Fnd_Gen_CurrentTable->).copy()
		Fnd_Out_Update
	Else 
		Fnd_Sort_Display  // Display Foundation's Sort dialog.
	End if 
	
End if 



