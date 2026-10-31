// ----------------------------------------------------

// Trigger: Contacts


// Created by 4D, Inc. on May 2, 2003

// ----------------------------------------------------


C_LONGINT($0; $error)

$error:=0

Case of 
	: (Trigger event=On Saving New Record Event)
		Fnd_SqNo_SetRecordID
End case 

$0:=$error