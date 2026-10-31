//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_TestRunnerOnErr

// Error handler installed by Fnd_FCS_TestRunner around each test method, so a
// test that raises an error is recorded rather than stopping the run or opening
// the debugger in the watcher process.

// Access: Private

// Parameters: None

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-10
// ----------------------------------------------------

If (Storage.test#Null)
	
	Use (Storage.test)
		Storage.test.error:=Error method+" ("+String(Error)+"): "+Error formula
	End use 
	
End if 
