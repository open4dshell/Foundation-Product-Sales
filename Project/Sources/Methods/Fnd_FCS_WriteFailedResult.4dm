//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_WriteFailedResult ($reason_t : Text {; $requestedAt_t : Text})

// Writes a definite failure payload to <Resources>/schedulerResult.json.

// The file-based compile-check protocol gives a client no way to distinguish
//   "the compile is still running" from "the compile never ran", so every
//   abnormal exit must land here rather than leaving a polling client waiting
//   on a file that will never appear. errorCount is -1 to mark the payload as
//   a non-result: the compiler was not reached, so no error count exists.

// Access: Private

// Parameters:
//   $reason_t      : Text : Why the compile did not run (appended to the message)
//   $requestedAt_t : Text : Timestamp the watcher accepted the request (optional)

// Returns: Nothing

// Created by Wayne Stewart on 2026-08-07
// ----------------------------------------------------

#DECLARE($reason_t : Text; $requestedAt_t : Text; $requestBody_t : Text)

var $message_o; $summary_o : Object
var $resultsPath_t : Text

If (Count parameters<2)
	$requestedAt_t:=""
End if 

$resultsPath_t:=Get 4D folder(Current resources folder)+"schedulerResult.json"

$message_o:=New object
$message_o.isError:=True
$message_o.message:="compile did not run: "+$reason_t

$summary_o:=Fnd_FCS_RequestEcho($requestBody_t; $requestedAt_t)
$summary_o.project:=File(Convert path system to POSIX(Structure file)).name
$summary_o.action:="compile"
$summary_o.syntaxCheckDone:=False
$summary_o.errorCount:=-1
$summary_o.warningCount:=0
$summary_o.timeInMilliSeconds:=0
$summary_o.compilationPath:=Fnd_FCS_CompilationPath
$summary_o.completedAt:=Fnd_Date_LocalTimestamp
$summary_o.messages:=New collection($message_o)

TEXT TO DOCUMENT($resultsPath_t; JSON Stringify($summary_o))
