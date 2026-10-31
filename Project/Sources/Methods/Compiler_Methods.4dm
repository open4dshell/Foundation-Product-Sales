//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Compiler_Methods

// Compiler declarations for the Application Methods.

// Access Type: Private

// Parameters: None

// Returns:
// Nothing

// Created by Walt Nelson on 1/22/11
// WBS, 2026-09-13 - Type the FPS logging host probe (FND-26)
// WBS, 2026-09-13 - Preserve developer cleanup of absent iLB and host typing
// WBS, 2026-09-13 - Type read-only server log observation
// ----------------------------------------------------


C_OBJECT(Fnd_Test_Logging; $1)
C_OBJECT(Fnd_Test_LogServer; $0)
C_TEXT(Fnd_Test_LogServer; $1)
C_TEXT(Contacts_FullAddress; $0)
C_BOOLEAN(Contacts_FullAddress; $1)
C_BOOLEAN(Contacts_FullAddress; $2)
C_TEXT(Contacts_FullName; $0)
C_TEXT(Invoices_GetContactInfo; $0)
C_LONGINT(Invoices_SelectContact; $0)
C_LONGINT(LineItems_SelectProduct; $0)
C_BOOLEAN(Contacts_IsUSA; $0)
C_TEXT(Contacts_IsUSA; $1)

C_VARIANT(DISABLE BUTTON; $1)
C_VARIANT(ENABLE BUTTON; $1)

C_OBJECT(Fnd_Hook_Out_RowStyle; $0)

//Fnd_Hook_IO_InputFormButton
C_BOOLEAN(Fnd_Hook_IO_InputFormButton; $0)
C_TEXT(Fnd_Hook_IO_InputFormButton; $1)

//Fnd_Hook_Rec_Delete
C_BOOLEAN(Fnd_Hook_Rec_Delete; $0)

//Fnd_Hook_Rec_New
C_BOOLEAN(Fnd_Hook_Rec_New; $0)
C_POINTER(Fnd_Hook_Rec_New; $1)

//Fnd_Hook_Shell_Quit
// Entry retired 2026-08-15: the regenerated method declares itself with
//   #DECLARE, and a typing entry alongside #DECLARE is a compile error.
//C_BOOLEAN(Fnd_Hook_Shell_Quit; $0)

//Fnd_Hook_SqNo_SetIDField
C_POINTER(Fnd_Hook_SqNo_SetIDField; $0)
C_POINTER(Fnd_Hook_SqNo_SetIDField; $1)

//Fnd_Host_GetFormProperties
C_POINTER(Fnd_Host_GetFormProperties; $1)
C_TEXT(Fnd_Host_GetFormProperties; $2)
C_POINTER(Fnd_Host_GetFormProperties; $3)
C_POINTER(Fnd_Host_GetFormProperties; $4)

//Fnd_Host_GetPictureFromLibrary
C_TEXT(Fnd_Host_GetPictureFromLibrary; $1)
C_POINTER(Fnd_Host_GetPictureFromLibrary; $2)

//Fnd_Host_ExecuteFormula
C_TEXT(Fnd_Host_ExecuteFormula; $1)
C_POINTER(Fnd_Host_ExecuteFormula; $2)

//Fnd_Host_ListToArray
C_TEXT(Fnd_Host_ListToArray; $1)
C_POINTER(Fnd_Host_ListToArray; $2)

//Fnd_Host_GetIntegerValue
C_LONGINT(Fnd_Host_GetIntegerValue; $0)
C_TEXT(Fnd_Host_GetIntegerValue; $1)

//Fnd_Host_ArrayToList
C_POINTER(Fnd_Host_ArrayToList; $1)
C_TEXT(Fnd_Host_ArrayToList; $2)

//Fnd_Host_Tlbr_SetBtnPict
C_LONGINT(Fnd_Host_Tlbr_SetBtnPict; $1)
C_PICTURE(Fnd_Host_Tlbr_SetBtnPict; $2)

//Fnd_Host_Tlbr_SetMessage
C_TEXT(Fnd_Host_Tlbr_SetMessage; $1)

//Fnd_Host_Tlbr_ButtonClck
C_POINTER(Fnd_Host_Tlbr_ButtonClck; $1)

//Fnd_Host_IO_DisplayDialog
C_TEXT(Fnd_Host_IO_DisplayDialog; $1)



//Fnd_Host_SaveList
C_TEXT(Fnd_Host_SaveList; $1)
C_BLOB(Fnd_Host_SaveList; $2)




//contactName
C_TEXT(contactName; $0)

//Fnd_FCS_CompilationPath
C_TEXT(Fnd_FCS_CompilationPath; $0)

//Fnd_FCS_CompilerCheck
C_BOOLEAN(Fnd_FCS_CompilerCheck; $1)
C_TEXT(Fnd_FCS_CompilerCheck; $2)
C_TEXT(Fnd_FCS_CompilerCheck; $3)

//Fnd_FCS_RequestEcho
C_OBJECT(Fnd_FCS_RequestEcho; $0)
C_TEXT(Fnd_FCS_RequestEcho; $1)
C_TEXT(Fnd_FCS_RequestEcho; $2)

//Fnd_FCS_TestRunner
C_TEXT(Fnd_FCS_TestRunner; $1)
C_TEXT(Fnd_FCS_TestRunner; $2)

//Fnd_FCS_WriteFailedResult
C_TEXT(Fnd_FCS_WriteFailedResult; $1)
C_TEXT(Fnd_FCS_WriteFailedResult; $2)
C_TEXT(Fnd_FCS_WriteFailedResult; $3)

//Fnd_Hook_Shell_Quit
C_BOOLEAN(Fnd_Hook_Shell_Quit; $0)

//Fnd_Host_IO_DisplayDialog
C_OBJECT(Fnd_Host_IO_DisplayDialog; $2)
C_BOOLEAN(Fnd_Host_IO_DisplayDialog; $3)

//Fnd_Test_Assert
C_BOOLEAN(Fnd_Test_Assert; $1)
C_TEXT(Fnd_Test_Assert; $2)

//Fnd_Test_Begin
C_TEXT(Fnd_Test_Begin; $1)

//Fnd_Test_End
C_BOOLEAN(Fnd_Test_End; $1)

//Fnd_Test_Stamp
C_TEXT(Fnd_Test_Stamp; $0)

//Fnd_Test_Variadics
C_VARIANT(Fnd_Test_Variadics; $1)

//LBOX_highValue
C_OBJECT(LBOX_highValue; $0)
