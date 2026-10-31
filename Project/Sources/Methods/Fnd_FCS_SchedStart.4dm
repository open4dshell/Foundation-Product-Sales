//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_SchedStart

// Starts, and then is, the compile-check watcher process $Fnd_FCS_SchedStart.

// Called with no watcher running it spawns itself into that unique process and
//   returns; running inside it, it polls <Resources>/schedulerRequest.json
//   every 5 seconds and dispatches on the request's action:

//   nothing, or "compile"  Fnd_FCS_CompilerCheck
//   "test"                 Fnd_FCS_TestRunner
//   "relaunch"             Fnd_FCS_SchedRelaunch, which restarts this watcher

// Results always land in <Resources>/schedulerResult.json.

// A developer tool, driven by the developer and by AI working alongside them.

// Interpreted mode only. In compiled mode this is a no-op, and the child calls
//   RELOAD PROJECT, which must never run preemptively.

// Stopped by Fnd_FCS_SchedStop.

// Access: Private

// Parameters: None

// Returns: Nothing

// Created by Wayne Stewart (2026-07-12)
//  Method is an autostart type
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
// ----------------------------------------------------

var $ProcessID_i; $child_i; $StackSize_i : Integer
var $DesiredProcessName_t; $compilerMethod_t; $testMethod_t; $relaunchMethod_t : Text
var $request_t; $results_t; $requestBody_t; $action_t; $requestedAt_t : Text
var $request_o : Object

// ----------------------------------------------------

$StackSize_i:=0
$DesiredProcessName_t:="$"+Current method name


If (Current process name=$DesiredProcessName_t)
	$ProcessID_i:=Current process
	
	// One request file, one result file, whatever the job. The action is read
	//   from the request; anything without one is a compile check.
	$request_t:=Get 4D folder(Current resources folder)+"schedulerRequest.json"
	$results_t:=Get 4D folder(Current resources folder)+"schedulerResult.json"
	
	$compilerMethod_t:="Fnd_FCS_CompilerCheck"
	$testMethod_t:="Fnd_FCS_TestRunner"
	$relaunchMethod_t:="Fnd_FCS_SchedRelaunch"
	
	If (Storage.sched=Null)
		Use (Storage)
			Storage.sched:=New shared object("quitNow"; False)
		End use 
	End if 
	
	// A watcher aborted between Fnd_FCS_SchedStop setting quitNow and the
	//   cleanup below leaves the shared object behind with quitNow still True.
	//   Without this reset the next watcher exits on its first tick.
	Use (Storage.sched)
		Storage.sched.quitNow:=False
	End use 
	
	Repeat
		
		// The delay leads the tick. Acting on a request is then the last thing
		//   the loop does before Until is evaluated, so a request that sets
		//   quitNow leaves immediately instead of waiting out another delay.
		DELAY PROCESS($ProcessID_i; 300)  // Delay for 5 seconds
		
		If (Test path name($request_t)=Is a document)
			
			$requestedAt_t:=Fnd_Date_LocalTimestamp  // echoed into the result so a client can tell fresh from stale
			
			$requestBody_t:=Document to text($request_t)
			$request_o:=($requestBody_t="") ? New object : JSON Parse($requestBody_t)
			
			If ($request_o=Null)
				$request_o:=New object
			End if 
			
			// No action named means a compile check, which is what an empty
			//   request has always meant.
			$action_t:=($request_o.action#Null) ? $request_o.action : "compile"
			
			If (Test path name($results_t)=Is a document)  // Are the previous still there?
				DELETE DOCUMENT($results_t)  // Delete them
			End if 
			
			DELETE DOCUMENT($request_t)  // Always before dispatching, or a relaunch would see it again
			
			// The body travels in Storage rather than as a process parameter, so
			//   the child reads it the same way whatever New process does with
			//   arguments beyond the first.
			Use (Storage.sched)
				Storage.sched.requestBody:=$requestBody_t
			End use 
			
			Case of 
					
				: ($action_t="test")
					$child_i:=New process($testMethod_t; $StackSize_i; $testMethod_t; $requestedAt_t; $requestBody_t; *)
					
				: ($action_t="relaunch")
					$child_i:=New process($relaunchMethod_t; $StackSize_i; "$"+$relaunchMethod_t; *)
					
					Use (Storage.sched)
						Storage.sched.quitNow:=True  // Leave the loop cleanly; the relauncher waits for it
					End use 
					
				: ($action_t="restart")
					Use (Storage.sched)
						Storage.sched.quitNow:=True  // Leave the loop cleanly; the relauncher waits for it
					End use 
					DELAY PROCESS(Current process; 30)
					RESTART 4D()
					
				Else 
					$child_i:=New process($compilerMethod_t; $StackSize_i; $compilerMethod_t; True; $requestedAt_t; $requestBody_t; *)
				
			End case 
			
		End if 
		
	Until (Process aborted) | (Storage.sched.quitNow)
	
	Use (Storage)
		OB REMOVE(Storage; "sched")
	End use 
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	If (Is compiled mode())
		// Do nothing
		
	Else 
		$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
		
	End if 
	
End if 
