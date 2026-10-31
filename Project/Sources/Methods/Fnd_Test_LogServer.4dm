//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en","executedOnServer":true}
// Project Method: Fnd_Test_LogServer
// Read-only server observation of a uniquely named logging probe file.
// Created by Wayne Stewart
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
#DECLARE($label_t : Text)->$report_o : Object
var $file_o; $logger_o : Object
$report_o:=New object("applicationType"; Application type; "logsPath"; Get 4D folder(Logs folder); "dataFile"; Data file; "exists"; False)
$logger_o:=cs.fnd.log.new()
$report_o.foundationPath:=$logger_o.path()
If ((Position("FND26FPS_"; $label_t)=1) && (Length($label_t)=41))
	$file_o:=File($report_o.logsPath+$label_t+".txt"; fk platform path)
	$report_o.file:=$file_o.platformPath
	$report_o.exists:=$file_o.exists
	If ($file_o.exists)
		$report_o.content:=$file_o.getText()
	End if
End if
