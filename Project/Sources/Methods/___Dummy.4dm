//%attributes = {"invisible":true,"shared":true,"lang":"en"}
// ___Dummy
// Created by Wayne Stewart on 2026-08-11
// ----------------------------------------------------

var $ProcessID_i; $StackSize_i; $WindowID_i : Integer
var $Form_t; $DesiredProcessName_t : Text
var $t : Pointer

// Foundation's modules through the class store. The namespace is "fnd", set in
//   the component's own Settings > General, so a host addresses them as
//   cs.fnd.<module> — inside Foundation the same classes are plain cs.<module>.
// Declaring the type is what gives the code editor something to complete on:
//   type $textFnd_o. and the function list should appear.
var $textFnd_o : cs.fnd.text
var $pswdFnd_o : cs.fnd.pswd
var $dateFnd_o : cs.fnd.date
var $baseFnd_o : cs.fnd.fnd
var $report_c : Collection
var $strength_o : Object

// ----------------------------------------------------

$StackSize_i:=0
$Form_t:=""
$DesiredProcessName_t:=Current method name

If (Current process name=$DesiredProcessName_t)
	RELOAD PROJECT
	DELAY PROCESS(Current process; 30)
	
	SET DATABASE PARAMETER([Fnd_Pref]; Table sequence number; 4)
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
	
	RESUME PROCESS($ProcessID_i)
	SHOW PROCESS($ProcessID_i)
	BRING TO FRONT($ProcessID_i)
End if 
