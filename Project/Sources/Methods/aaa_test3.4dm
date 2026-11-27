//%attributes = {}
// aaa_test3
// Created by Wayne Stewart (27/11/2026)
//  Method is an autostart type
//     waynestewart@mac.com
// ----------------------------------------------------

var $ProcessID_i; $StackSize_i; $WindowID_i : Integer
var $Form_t; $DesiredProcessName_t : Text

// ----------------------------------------------------

$StackSize_i:=0
$Form_t:=""
$DesiredProcessName_t:=Current method name

If (Current process name=$DesiredProcessName_t)
	RELOAD PROJECT
	DELAY PROCESS(Current process; 30)
	
	
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
	
	RESUME PROCESS($ProcessID_i)
	SHOW PROCESS($ProcessID_i)
	BRING TO FRONT($ProcessID_i)
End if 
