//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_End ({$silent_b : Boolean})

// Closes the host-side run, writes it to a result file, one per matrix cell so
//   the six runs collate rather than being eyeballed six times, and reports the
//   tally.

// The report is an alert, because these tests are run by hand from the Method
//   editor and a run that ends with no word either way is indistinguishable from
//   one that died. Pass True to suppress it if this is ever driven headlessly —
//   a modal dialog in a headless process blocks it until someone clicks.

// The file is named for the cell — version, host state, component state — so a
//   run cannot silently overwrite a different configuration's result.

// The closing tally is also written to the "FPS_Test" log through the
//   Fnd_Log — see Fnd_Test_Begin — unconditionally, since
//   that log is the durable record for a headless run and $silent_b only
//   suppresses the pasteboard write and the alert.

// Access: Private

// Parameters:
//   $silent_b : Boolean : True suppresses the closing alert (optional)

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-11
// ----------------------------------------------------

#DECLARE($silent_b : Boolean)

var $result_o : Object
var $report_t : Text
var $resultsFolder_folder : 4D.Folder
var $resultFile_file : 4D.File
var $name_t : Text
var $componentLabel_t : Text

$report_t:="Storage.fpsTest=Null"
If (Storage.fpsTest#Null)
	
	Use (Storage.fpsTest)
		Storage.fpsTest.closed:=True
	End use 
	
	$result_o:=New object(\
		"stamp"; OB Copy(Storage.fpsTest.stamp); \
		"passed"; Storage.fpsTest.passed; \
		"failed"; Storage.fpsTest.failed; \
		"success"; (Storage.fpsTest.failed=0) && (Storage.fpsTest.passed>0); \
		"failures"; Storage.fpsTest.assertions.copy(); \
		"completedAt"; Fnd_Test_Stamp)
	
	// componentCompiled is the text "True", "False" or "Unknown" — see Fnd_Test_Begin.
	//   Case of rather than a ternary, because there are three outcomes and not two.
	Case of 
		: ($result_o.stamp.componentCompiled="True")
			$componentLabel_t:="Compiled"
			
		: ($result_o.stamp.componentCompiled="False")
			$componentLabel_t:="Interpreted"
			
		Else 
			$componentLabel_t:="Unknown"
		
	End case 
	
	$name_t:="fpsTest-"+$result_o.stamp.v4D\
		+"-host"+(($result_o.stamp.hostCompiled) ? "Compiled" : "Interpreted")\
		+"-component"+$componentLabel_t\
		+".json"
	
	$resultsFolder_folder:=Folder(fk database folder).folder("TestResults")
	
	If (Not($resultsFolder_folder.exists))
		$resultsFolder_folder.create()
	End if 
	
	$resultFile_file:=$resultsFolder_folder.file($name_t)
	$resultFile_file.setText(JSON Stringify($result_o; *); "UTF-8")
	
	// The durable record, written whether or not the alert is suppressed —
	//   see Fnd_Test_Begin. Info is level 1 and error is level 4.
	Fnd_Log_UseLog("FPS_Test")
	Fnd_Log_Enable(True)
	Fnd_Log_AddEntry(New object("logLevel"; (($result_o.failed=0) ? 1 : 4)); \
		"END"; String($result_o.passed)+" passed, "+String($result_o.failed)+" failed"; $result_o.stamp.configuration)
	
	If (Not($silent_b))
		$report_t:=($result_o.success ? "PASSED" : "FAILED")+" - "\
			+String($result_o.passed)+" passed, "+String($result_o.failed)+" failed"\
			+Char(Carriage return)+Char(Carriage return)\
			+$result_o.stamp.configuration+" on 4D "+$result_o.stamp.v4D\
			+Char(Carriage return)+$resultFile_file.platformPath
		
		If ($result_o.failed>0)
			$report_t:=$report_t+Char(Carriage return)+Char(Carriage return)\
				+"First failure:"+Char(Carriage return)+$result_o.failures[0].message
		End if 
		
	End if 
	
End if 

// Outside the block above, so that the Storage.fpsTest=Null case is reported too.
If (Not($silent_b))
	SET TEXT TO PASTEBOARD($report_t)
	ALERT($report_t)
End if 
