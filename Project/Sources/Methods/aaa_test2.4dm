//%attributes = {"invisible":true,"shared":true,"lang":"en"}

// _Testing
// Created by Wayne Stewart on 2026-08-10
//  Method is an autostart type
// ----------------------------------------------------

var $ProcessID_i; $StackSize_i; $WindowID_i; $lastFieldNumber_i; $tableNum_i : Integer
var $Form_t; $DesiredProcessName_t; $path_t : Text
var $results_o : Object

// ----------------------------------------------------

$StackSize_i:=Fnd_Gen_DefaultStackSize
$Form_t:=""
$DesiredProcessName_t:=Current method name

If (Current process name=$DesiredProcessName_t)
	
	RELOAD PROJECT
	DELAY PROCESS(Current process; 30)
	
	Fnd_Shell_Installer()
	
	
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
	
	RESUME PROCESS($ProcessID_i)
	SHOW PROCESS($ProcessID_i)
	BRING TO FRONT($ProcessID_i)
End if 
