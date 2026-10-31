// ----------------------------------------------------
// Database Method: On Startup

// 4D Product Sales
// Version 1.0
// A 4D 2003 Template by 4D, Inc.

// Created by 4D, Inc. on May 2, 2003
// ----------------------------------------------------
If (Fnd_Gen_ComponentAvailable("iLB@"))
	EXECUTE METHOD("iLB_StartUp")
End if 
//iLB_StartUp 






Fnd_Shell_OnStartup


