//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Assert ($ok_b : Boolean; $message_t : Text)

// Records one host-side assertion. Same name and signature as Foundation's, so
//   a test reads identically in either project; see Fnd_Test_Begin for why the
//   body differs.

// The message should state the expectation and the actual value, because a
//   failure is read later from a file rather than watched as it happens.

// Never alerts. A modal dialog in a test blocks the process it runs in, and in a
//   compiled host there is no debugger to interrupt it.

// Every assertion, pass and fail alike, is also written to the "FPS_Test" log
//   through Fnd_Log — see Fnd_Test_Begin — matching
//   Foundation's own Fnd_Test_Assert, which logs every assertion the same way.

// Access: Private

// Parameters:
//   $ok_b : Boolean : The assertion
//   $message_t : Text : What was expected, and what was actually seen

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-11
// ----------------------------------------------------

#DECLARE($ok_b : Boolean; $message_t : Text)

var $callChain_c : Collection
var $caller_t : Text
var $frame_o : Object

// Get call chain was renamed between versions, so it is reached through
//   Foundation's wrapper, which is Shared and therefore visible here.
// The wrapper runs inside the component, so the chain begins with its own
//   frames: element 0 is Fnd_Shell_CommandWrapper and element 1 is this method.
//   Take the first frame that is neither, which is the test that called us.
$callChain_c:=Fnd_Shell_CommandWrapper("Get call chain")
$caller_t:=""

For each ($frame_o; $callChain_c) Until ($caller_t#"")
	
	If (($frame_o.name#"Fnd_Test_Assert") && ($frame_o.name#"Fnd_Shell_CommandWrapper"))
		$caller_t:=$frame_o.name
	End if 
	
End for each 

If (Storage.fpsTest=Null)
	// A test that forgot to open a run still has somewhere to be recorded.
	Fnd_Test_Begin("unnamed")
End if 

Use (Storage.fpsTest)
	
	If ($ok_b)
		Storage.fpsTest.passed:=Storage.fpsTest.passed+1
		
	Else 
		Storage.fpsTest.failed:=Storage.fpsTest.failed+1
		Storage.fpsTest.assertions.push(New shared object(\
			"ok"; False; "test"; $caller_t; "message"; $message_t))
		
	End if 
	
End use 

// Info is level 1 and error is level 4. The log is selected per process, so it
//   is chosen here rather than assumed from Fnd_Test_Begin.
Fnd_Log_UseLog("FPS_Test")
Fnd_Log_Enable(True)
Fnd_Log_AddEntry(New object("logLevel"; ($ok_b ? 1 : 4)); \
	($ok_b ? "pass" : "FAIL"); $caller_t; $message_t)
