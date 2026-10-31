//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Begin ($configuration_t : Text)

// Opens a host-side test run and stamps it with everything needed to tell one
//   matrix cell from another: the 4D version, whether Foundation is compiled,
//   and whether FPS is compiled.

// This is FPS's own copy, deliberately carrying the same name as Foundation's
//   harness so a test method reads identically in either project. Foundation's
//   Fnd_Test_ methods are Private, so they are not published to a host and there
//   is nothing to collide with — a call from FPS can only reach this one.

// FPS selects its own log, "FPS_Test", through Foundation's Fnd_Log_DeclareLog,
//   Fnd_Log_UseLog and Fnd_Log_Enable, all Shared. The label and file differ
//   from Foundation's "Fnd_Test" log, because the two projects cannot write to
//   the same one. Fnd_Log_AddEntry is one of the variadic methods under test, so
//   the instrument shares a failure with its subject; that risk is accepted.

// Access: Private

// Parameters:
//   $configuration_t : Text : Names the matrix cell, e.g. "interpreted-in-interpreted"

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-11
// ----------------------------------------------------

#DECLARE($configuration_t : Text)

var $stamp_o : Object
var $foundationCompiled_t : Text

// Foundation reports its own compiled state through Fnd_Gen_Info's "compiled"
//   label, reached across the component boundary via the Shared
//   Fnd_Gen_ComponentInfo — ours comes straight from Is compiled mode, since the
//   host is not itself a component and has no such label to ask. On success
//   Fnd_Gen_ComponentInfo answers with the text "True" or "False"; any of its
//   three documented failure replies ("Component Not Available", "Component Did
//   Not Respond", "Component Did Not Recognize Request") means the state
//   genuinely could not be determined, so that is stamped "Unknown" rather than
//   guessed as False — a guess would silently collide two different matrix cells
//   under the one result filename, which is the defect this replaces.
$foundationCompiled_t:=Fnd_Gen_ComponentInfo("Fnd_Gen"; "compiled")

If (($foundationCompiled_t="True") || ($foundationCompiled_t="False"))
	// Fnd_Gen_ComponentInfo answered cleanly — keep its reply as the stamp
	
Else 
	$foundationCompiled_t:="Unknown"
End if 

$stamp_o:=New object(\
"configuration"; $configuration_t; \
"v4D"; Application version; \
"hostCompiled"; Is compiled mode; \
"componentCompiled"; $foundationCompiled_t; \
"startedAt"; Fnd_Test_Stamp)

// The durable record. Declaring is idempotent — safe to repeat on every run —
//   and selecting the log is per process, so it must happen wherever the run
//   actually executes rather than being assumed from an earlier call.
Fnd_Log_DeclareLog("FPS_Test"; "FPS_Test.txt")
Fnd_Log_UseLog("FPS_Test")
Fnd_Log_Enable(True)
// Level 1 is info and 4 is error: the values Fnd_Log_AddEntry accepts.
Fnd_Log_AddEntry(New object("logLevel"; 1); "BEGIN"; JSON Stringify($stamp_o))

Use (Storage)
	Storage.fpsTest:=New shared object(\
		"passed"; 0; \
		"failed"; 0; \
		"closed"; False; \
		"stamp"; OB Copy($stamp_o; ck shared); \
		"assertions"; New shared collection)
End use 
