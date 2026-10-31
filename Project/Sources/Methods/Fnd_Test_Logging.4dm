//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Logging
// Host-side logging probe; writes evidence directly, independent of either logger.
// Options: phase = smoke/create/records; silent accepted, no dialogs are issued.
// Created by Wayne Stewart on 2026-09-13
// ----------------------------------------------------

#DECLARE($options_o : Object)
var $logger_o; $text_o; $report_o; $check_o; $creation_o; $records_o; $entity_o; $notDropped_o : Object
var $checks_c : Collection
var $phase_t; $label_t; $marker_t; $folder_t; $file_t; $content_t; $savedLabel_t; $compiled_t : Text
var $savedEnabled_b : Boolean
var $start_r : Real
$phase_t:="smoke"
If (($options_o#Null) && ($options_o.phase#Null))
	$phase_t:=$options_o.phase
End if 
$checks_c:=New collection
$compiled_t:=Fnd_Gen_ComponentInfo("Fnd_Gen"; "compiled")
$report_o:=New object("phase"; $phase_t; "runtime"; Application version; "hostCompiled"; Is compiled mode; "componentCompiled"; $compiled_t; "checks"; $checks_c; "startedAt"; Fnd_Date_LocalTimestamp)
$report_o.applicationType:=Application type
$report_o.remote:=(Application type=4D Remote mode)
$report_o.resourcesPath:=Get 4D folder(Current resources folder)
$logger_o:=cs.fnd.log.new()
$text_o:=cs.fnd.text.new()
$checks_c.push(New object("ok"; $compiled_t="True"; "message"; "Foundation reports compiled mode"))
$checks_c.push(New object("ok"; $text_o.trim(Char(9)+" hello "+Char(13))="hello"; "message"; "Text trim crosses component boundary"))
$savedLabel_t:=Fnd_Log_Label
$savedEnabled_b:=Fnd_Log_Enable
$label_t:="FND26FPS_"+Generate UUID
$marker_t:=Generate UUID
$folder_t:=Folder(Temporary folder; fk platform path).platformPath
$logger_o.enable(True)

Case of 
	: ($phase_t="observeCentral")
		$report_o.server:=Fnd_Test_LogServer($options_o.label)
		$checks_c.push(New object("ok"; $report_o.server.applicationType=4D Server; "message"; "Observation executes on server"))
		$checks_c.push(New object("ok"; $report_o.server.exists; "message"; "Server default Logs folder contains probe file"))
		If ($report_o.server.exists)
			$checks_c.push(New object("ok"; Position("central-one-"+$options_o.marker; $report_o.server.content)>0; "message"; "First remote entry reached server file"))
			$checks_c.push(New object("ok"; Position("central-two-"+$options_o.marker; $report_o.server.content)>0; "message"; "Second remote entry reached server file"))
		End if
	: ($phase_t="remoteReject")
		$checks_c.push(New object("ok"; $report_o.remote; "message"; "Creation rejection probe executes remotely"))
		If ($report_o.remote)
			$creation_o:=$logger_o.createTable()
			$report_o.creation:=$creation_o
			$checks_c.push(New object("ok"; Not($creation_o.success) && Not($creation_o.created) && Not($creation_o.restartRequired); "message"; "Remote creation rejected without schema change"))
			$checks_c.push(New object("ok"; Position("interpreted server or local host"; $creation_o.message)>0; "message"; "Rejection directs caller to server or local host"))
		End if
	: ($phase_t="central")
		$checks_c.push(New object("ok"; $report_o.remote; "message"; "Central probe executes remotely"))
		$logger_o.declareLog($label_t; "client-"+$label_t+".txt"; $folder_t; New object("destinations"; 2; "flushInterval"; 60); True)
		$logger_o.useLog($label_t)
		$report_o.label:=$label_t
		$report_o.marker:=$marker_t
		$report_o.clientFile:=$folder_t+$logger_o.fileName()
		$logger_o.addEntry("central-one-"+$marker_t)
		$logger_o.addEntry("central-two-"+$marker_t)
		$logger_o.closeLog($label_t)
		DELAY PROCESS(Current process; 60)
		$checks_c.push(New object("ok"; Not(File($report_o.clientFile; fk platform path).exists); "message"; "Server-only destination leaves client file absent"))
		$report_o.serverObservationRequired:=True
	: ($phase_t="smoke")
		$logger_o.declareLog($label_t; $label_t+".txt"; $folder_t; New object("destinations"; 1; "flushInterval"; 60); True)
		$logger_o.useLog($label_t)
		$file_t:=$folder_t+$logger_o.fileName()
		$report_o.file:=$file_t
		$checks_c.push(New object("ok"; $logger_o.label()=$label_t; "message"; "Class declaration and selection cross component boundary"))
		$checks_c.push(New object("ok"; Fnd_Log_Enable; "message"; "Class and method share enable state"))
		$logger_o.addEntry("class-"+$marker_t)
		Fnd_Log_AddEntry("method-"+$marker_t; "second column")
		$logger_o.addEntry(New collection("collection-"+$marker_t; "third column"); New object("logLevel"; 4))
		$logger_o.closeLog($label_t)
		$start_r:=Milliseconds
		Repeat 
			DELAY PROCESS(Current process; 1)
			If (File($file_t; fk platform path).exists)
				$content_t:=File($file_t; fk platform path).getText()
			End if 
		Until ((Position("collection-"+$marker_t; $content_t)>0) || ((Milliseconds-$start_r)>5000))
		$checks_c.push(New object("ok"; Position("class-"+$marker_t; $content_t)>0; "message"; "Class entry written by dedicated worker"))
		$checks_c.push(New object("ok"; Position("method-"+$marker_t+Char(9)+"second column"; $content_t)>0; "message"; "Variadic method columns cross component boundary"))
		$checks_c.push(New object("ok"; Position("collection-"+$marker_t+Char(9)+"third column"; $content_t)>0; "message"; "Class collection columns cross component boundary"))
		$report_o.content:=$content_t
		If (File($file_t; fk platform path).exists)
			File($file_t; fk platform path).delete()
		End if 
	: ($phase_t="create")
		$creation_o:=$logger_o.createTable()
		$report_o.creation:=$creation_o
		$checks_c.push(New object("ok"; $creation_o.success; "message"; "Compiled component explicitly creates or validates interpreted host table"))
	: ($phase_t="records")
		$checks_c.push(New object("ok"; ds["Fnd_Log"]#Null; "message"; "Host Fnd_Log table available through ORDA"))
		If (ds["Fnd_Log"]#Null)
			$logger_o.declareLog($label_t; ""; ""; New object("destinations"; 4; "useBatch"; False); True)
			$logger_o.useLog($label_t)
			$logger_o.addEntry(New collection($marker_t; "record second column"); New object("logLevel"; 4))
			$start_r:=Milliseconds
			Repeat 
				DELAY PROCESS(Current process; 1)
				$records_o:=ds["Fnd_Log"].query("logLabel = :1 and message = :2"; $label_t; $marker_t)
			Until (($records_o.length>0) || ((Milliseconds-$start_r)>5000))
			$checks_c.push(New object("ok"; $records_o.length=1; "message"; "Component saves exactly one host record"))
			If ($records_o.length=1)
				$entity_o:=$records_o.first()
				$checks_c.push(New object("ok"; Length($entity_o.ID)=32; "message"; "Host record UUID generated"))
				$checks_c.push(New object("ok"; $entity_o.logLevel=4; "message"; "Host record severity retained"))
				$checks_c.push(New object("ok"; $entity_o.destinationMask=4; "message"; "Host record destination retained"))
				$checks_c.push(New object("ok"; $entity_o.processName=Current process name; "message"; "Host source process retained"))
				$checks_c.push(New object("ok"; Position($marker_t+Char(9)+"record second column"; $entity_o.renderedLine)>0; "message"; "Host record rendered columns retained"))
			End if 
			$notDropped_o:=$records_o.drop()
			$checks_c.push(New object("ok"; ($notDropped_o.length=0) && (ds["Fnd_Log"].query("logLabel = :1 and message = :2"; $label_t; $marker_t).length=0); "message"; "Only unique test records removed and cleanup confirmed"))
			$logger_o.closeLog($label_t)
		End if 
	Else 
		$checks_c.push(New object("ok"; False; "message"; "Unknown phase"))
End case 

Fnd_Log_UseLog($savedLabel_t)
Fnd_Log_Enable($savedEnabled_b)
$report_o.passed:=0
$report_o.failed:=0
For each ($check_o; $checks_c)
	If ($check_o.ok)
		$report_o.passed:=$report_o.passed+1
	Else 
		$report_o.failed:=$report_o.failed+1
	End if 
End for each 
$report_o.success:=($report_o.failed=0)
$report_o.completedAt:=Fnd_Date_LocalTimestamp
File(Get 4D folder(Database folder)+"TestResults"+Folder separator+"fnd26-"+$phase_t+".json"; fk platform path).setText(JSON Stringify($report_o; *))
