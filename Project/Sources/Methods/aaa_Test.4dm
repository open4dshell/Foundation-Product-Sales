//%attributes = {"shared":true,"folder":"Project_Methods","lang":"en"}
// aaa_Test
// Created by Wayne Stewart on 2026-08-14
//  Method is an autostart type
// ----------------------------------------------------

#DECLARE($mode_t : Text)

var $ProcessID_i; $StackSize_i; $WindowID_i; $i_i; $last_i : Integer
var $Form_t; $DesiredProcessName_t; $t : Text

// ----------------------------------------------------

$StackSize_i:=0
$Form_t:=""
$DesiredProcessName_t:=Current method name

Case of 
	: (Current process name=$DesiredProcessName_t)
		RELOAD PROJECT
		DELAY PROCESS(Current process; 30)
		
		Fnd_Shell_Documentation
		
	Else 
		// This version allows for any number of processes
		// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
		
		// On the other hand, this version allows for one unique process
		$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
		
		RESUME PROCESS($ProcessID_i)
		SHOW PROCESS($ProcessID_i)
		BRING TO FRONT($ProcessID_i)
End case 
