//%attributes = {"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_CompilerCheck ({$inline_b : Boolean {; $requestedAt_t : Text}})

// Runs a syntax check (Compile project with no targets) and reports the result.

// Called from outside its own process it spawns itself into the unique process
//   $DesiredProcessName_t and returns; running inside that process it does the
//   work. RELOAD PROJECT runs first so that .4dm files edited outside the IDE
//   are picked up — which is also why this must never run preemptively.

// With $inline_b the summary is written to <Resources>/schedulerResult.json for
//   the file-based protocol driven by Fnd_FCS_SchedStart; otherwise it goes to
//   the pasteboard and an alert. Holding Option (Alt on Windows) while an
//   interactive check finishes puts the concise rather than the indented JSON
//   on the pasteboard.

// A result file is written on every path, including failure, so a polling
//   client always gets an answer.

// Access: Private

// Parameters:
//   $inline_b      : Boolean : True to write the result file instead of alerting (optional)
//   $requestedAt_t : Text : Timestamp of the originating request, echoed back (optional)

// Returns: Nothing

// Created by Wayne Stewart (2026-07-07)
//  Method is an autostart type
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
// ----------------------------------------------------

#DECLARE($inline_b : Boolean; $requestedAt_t : Text; $requestBody_t : Text)

var $DesiredProcessName_t; $syntaxCheckResults_t : Text

// ----------------------------------------------------

$DesiredProcessName_t:=Current method name

If (Count parameters=0)
	$inline_b:=False
End if 

If (Count parameters<2)
	$requestedAt_t:=Fnd_Date_LocalTimestamp
End if 


If (Current process name=$DesiredProcessName_t)
	
	var $options_o; $result_o; $summary_o : Object
	var $issue_o; $message_o; $code_o : Object
	var $resultJSON_t : Text
	var $startMilli_i : Integer
	var $oldErrorHandler_t : Text
	
	$syntaxCheckResults_t:=Get 4D folder(Current resources folder)+"schedulerResult.json"
	
	$startMilli_i:=Milliseconds
	
	$options_o:=New object
	$options_o.targets:=New collection  //("x86_64_generic"; "arm64_macOS_lib")  //Empty collection for syntax checking
	
	// Compile project returns its errors rather than raising them, but
	//   RELOAD PROJECT can fail outright, and Compile project itself errors if
	//   another compilation is already running. Either would otherwise end the
	//   process with no result file at all.
	$oldErrorHandler_t:=Method called on error
	ON ERR CALL("Fnd_FCS_CompilerCheckOnErr")
	
	$result_o:=Null
	
	RELOAD PROJECT
	DELAY PROCESS(Current process; 30)
	
	$result_o:=Compile project($options_o)
	
	ON ERR CALL($oldErrorHandler_t)
	
	If ($result_o=Null)
		// The handler has already written a failure result; make sure one
		//   exists even if the error arrived before it could run.
		Fnd_FCS_WriteFailedResult("Compile project returned nothing"; $requestedAt_t; $requestBody_t)
		
	Else 
		
		$summary_o:=Fnd_FCS_RequestEcho($requestBody_t; $requestedAt_t)
		$summary_o.project:=File(Convert path system to POSIX(Structure file)).name
		$summary_o.action:="compile"
		$summary_o.syntaxCheckDone:=False
		$summary_o.errorCount:=0
		$summary_o.warningCount:=0
		$summary_o.timeInMilliSeconds:=0
		$summary_o.compilationPath:=Fnd_FCS_CompilationPath
		$summary_o.messages:=New collection
		
		If (OB Is defined($result_o; "success"))
			$summary_o.syntaxCheckDone:=$result_o.success  // Compile project completed; it is not a verdict on the code
		End if 
		
		If (OB Is defined($result_o; "errors"))
			For each ($issue_o; $result_o.errors)
				$message_o:=New object
				
				If (OB Is defined($issue_o; "isError"))
					$message_o.isError:=$issue_o.isError
					If ($issue_o.isError)
						$summary_o.errorCount:=$summary_o.errorCount+1
					Else 
						$summary_o.warningCount:=$summary_o.warningCount+1
					End if 
				End if 
				
				If ($issue_o.isError)  // Only accumulate the errors
					If (OB Is defined($issue_o; "message"))
						$message_o.message:=$issue_o.message
					End if 
					If (OB Is defined($issue_o; "line"))
						$message_o.line:=$issue_o.line
					End if 
					If (OB Is defined($issue_o; "lineInFile"))
						$message_o.lineInFile:=$issue_o.lineInFile
					End if 
					
					If (OB Is defined($issue_o; "code"))
						$code_o:=New object
						If (OB Is defined($issue_o.code; "type"))
							$code_o.type:=$issue_o.code.type
						End if 
						If (OB Is defined($issue_o.code; "path"))
							$code_o.path:=$issue_o.code.path
						End if 
						If (OB Is defined($issue_o.code; "methodName"))
							$code_o.methodName:=$issue_o.code.methodName
						End if 
						If (OB Is defined($issue_o.code; "databaseMethod"))
							$code_o.databaseMethod:=$issue_o.code.databaseMethod
						End if 
						If (OB Is defined($issue_o.code; "className"))
							$code_o.className:=$issue_o.code.className
						End if 
						If (OB Is defined($issue_o.code; "functionName"))
							$code_o.functionName:=$issue_o.code.functionName
						End if 
						If (OB Is defined($issue_o.code; "formName"))
							$code_o.formName:=$issue_o.code.formName
						End if 
						If (OB Is defined($issue_o.code; "objectName"))
							$code_o.objectName:=$issue_o.code.objectName
						End if 
						$message_o.code:=$code_o
					End if 
					
					$summary_o.messages.push($message_o)
					
				End if   // Only accumulate the errors
				
			End for each   // ($issue_o; $result_o.errors)
		End if 
		
		$summary_o.timeInMilliSeconds:=Milliseconds-$startMilli_i
		
		$summary_o.completedAt:=Fnd_Date_LocalTimestamp
		
		var $conciseJSON_t; $report_t : Text
		$conciseJSON_t:=JSON Stringify($summary_o)
		$resultJSON_t:=JSON Stringify($summary_o; *)
		
		If ($inline_b)
			TEXT TO DOCUMENT($syntaxCheckResults_t; $conciseJSON_t)
			
		Else 
			// Macintosh option down reads the Option key on macOS and the Alt
			//   key on Windows, so this test is cross-platform.
			If (Macintosh option down)
				$report_t:=$conciseJSON_t
			Else 
				$report_t:=$resultJSON_t
			End if 
			
			SET TEXT TO PASTEBOARD($report_t)
			ALERT("Done"+Char(13)+$conciseJSON_t)
		End if 
		
	End if 
	
Else 
	// This version allows for any number of processes
	// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
	
	// On the other hand, this version allows for one unique process
	var $ProcessID_i; $StackSize_i : Integer
	
	$StackSize_i:=0
	
	$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; $inline_b; $requestedAt_t; *)
	
	If ($ProcessID_i>0)
		RESUME PROCESS($ProcessID_i)
		SHOW PROCESS($ProcessID_i)
		BRING TO FRONT($ProcessID_i)
		
	Else 
		Fnd_FCS_WriteFailedResult("the compiler process could not be started"; $requestedAt_t; $requestBody_t)
	End if 
	
End if 
