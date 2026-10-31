//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_SchedRelaunch

// Waits for the compile-check watcher to stop, then starts it again. Spawned by
// Fnd_FCS_SchedStart when <Resources>/schedRestart.json appears; not called
// directly.

// This is how an edit to the watcher itself takes effect. RELOAD PROJECT
// refreshes the compiler child but not the running loop, so the process has to
// go and come back, and something outside it has to do that.

// Access: Private

// Parameters: None

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-10
// ----------------------------------------------------

var $watcherName_t : Text
var $waited_i; $limit_i : Integer

$watcherName_t:="$Fnd_FCS_SchedStart"
$waited_i:=0
$limit_i:=900  // 15 seconds, in ticks

// The watcher only tests quitNow after its five second delay, so it can take
//   that long to leave the loop and remove Storage.sched. Starting the new one
//   before then would have the old one delete the new one's shared object, so
//   wait for the process to actually go rather than guess a delay.
Repeat
	DELAY PROCESS(Current process; 30)  // half a second
	$waited_i:=$waited_i+30
Until ((Process number($watcherName_t)<=0) || ($waited_i>=$limit_i))

If (Process number($watcherName_t)<=0)
	Fnd_FCS_SchedStart
	
Else 
	// It did not stop. Starting a second watcher would leave two of them
	//   competing for the same requests, so leave it alone. There is nowhere
	//   to record that here — see the header note above.
	
End if 
