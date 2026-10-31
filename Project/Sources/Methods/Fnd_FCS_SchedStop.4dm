//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_SchedStop

// Asks the compile-check watcher started by Fnd_FCS_SchedStart to stop.

// Sets Storage.sched.quitNow; the watcher notices on its next tick, so it can
//   take up to 5 seconds to exit. The watcher removes Storage.sched on its way
//   out, so calling this with no watcher running does nothing.

// Access: Private

// Parameters: None

// Returns: Nothing

// Created by Wayne Stewart (2026-07-12)
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
// ----------------------------------------------------

If (Storage.sched=Null)
	// No watcher running
	
Else 
	Use (Storage.sched)
		Storage.sched.quitNow:=True
	End use 
	
End if 
