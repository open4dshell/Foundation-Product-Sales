// ----------------------------------------------------
// Database Method: On Exit
// ----------------------------------------------------

Fnd_Shell_OnExit

If (Fnd_Gen_ComponentAvailable("iLB@"))
	EXECUTE METHOD("iLB_ShutDown")
End if 
