//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project Method: Util_StripTokens

// One-shot maintenance sweep: re-saves every code object without tokens.
// Pairs with "tokenizedText": false in the .4DProject file (which governs
// FUTURE saves only — existing files keep their tokens until re-saved,
// which is what this method does).

// Adapted from 4Vet's ______StripTokens. 

// Run once from the Method editor, interpreted mode, then relaunch.

// Created by Wayne Stewart (2023-05-17); Suppository adaptation 2026-07-07
// ----------------------------------------------------
// __StripTokens
// Created by Wayne Stewart (7/7/2026)
//  Method is an autostart type
// ----------------------------------------------------

var $ProcessID_i; $StackSize_i; $WindowID_i : Integer
var $Form_t; $DesiredProcessName_t : Text

// ----------------------------------------------------

$StackSize_i:=0
$Form_t:=""
$DesiredProcessName_t:=Current method name

If (Current process name=$DesiredProcessName_t)
	If (Not(Is compiled mode))
		
		var $progress_i : Integer
		$progress_i:=Progress New
		
		ARRAY TEXT($path_at; 0)
		ARRAY TEXT($code_at; 0)
		
		Progress SET TITLE($progress_i; "Retrieving Methods"; -1; "All at once")
		METHOD GET PATHS(Path all objects; $path_at)
		METHOD GET CODE($path_at; $code_at; 0)  // 0 = strip tokens
		
		Progress SET TITLE($progress_i; "Writing Methods"; -1; "One after another")
		
		var $method_i; $numberOfMethods_i : Integer
		$numberOfMethods_i:=Size of array($path_at)
		
		For ($method_i; 1; $numberOfMethods_i)
			If ($path_at{$method_i}=Current method name)
			Else 
				METHOD SET CODE($path_at{$method_i}; $code_at{$method_i})
			End if 
			Progress SET TITLE($progress_i; "Writing Methods"; $method_i/$numberOfMethods_i; "One after another"; True)
		End for 
		
		Progress QUIT($progress_i)
		
		ALERT("Stripped tokens from "+String($numberOfMethods_i)+" code objects.")
		
	End if 
	
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
	
	RESUME PROCESS($ProcessID_i)
	SHOW PROCESS($ProcessID_i)
	BRING TO FRONT($ProcessID_i)
End if 

