//%attributes = {"shared":true,"folder":"Project_Methods","lang":"en"}
// aaa_Test
// Created by Wayne Stewart on 2026-08-14
//  Method is an autostart type
// ----------------------------------------------------

//#DECLARE($mode_t : Text)

var $ProcessID_i; $StackSize_i; $WindowID_i; $i_i; $last_i : Integer
var $w_i; $h_i : Integer
var $Form_t; $DesiredProcessName_t; $t; $text_t; $mode_t : Text

// ----------------------------------------------------

$StackSize_i:=0
$Form_t:=""
$DesiredProcessName_t:=Current method name


Case of 
	: (Current process name=$DesiredProcessName_t)
		RELOAD PROJECT
		DELAY PROCESS(Current process; 30)

		// Hook-update checklist (AgentNotes/Active/Hook-Update-Checklist.md)
		// "asIs" = item 1 (FPS's own hooks); "replace", "merge", "conflict" = items 2-4 (item 5 = merge, then Cancel)
		$mode_t:="replace"
		
		If ($mode_t#"asIs")
			$text_t:=JSON Parse(File("/Users/waynestewart/4D/f6/Resources/Fnd_Shell_Installer/HookTemplates.json"; fk posix path).getText("UTF-8")).Fnd_Hook_IO_DisplayTable[1].text
			$text_t:=Replace string($text_t; "{{date}}"; "Nov 10, 2026")
			
			Case of 
				: ($mode_t="merge")
					$text_t:=$text_t+"// My own line, kept by the merge"+Char(Carriage return)
					
				: ($mode_t="conflict")
					$text_t:=Replace string($text_t; "//\t\tFnd_Out_Active(True)"; "//\t\tFnd_Out_Active(False)")
			End case 
			
			METHOD SET CODE("Fnd_Hook_IO_DisplayTable"; $text_t)
		End if 
		
		Fnd_Shell_Installer
		
	Else 
		// This version allows for any number of processes
		// $ProcessID_i:=New Process(Current method name;$StackSize_i;$DesiredProcessName_t)
		
		// On the other hand, this version allows for one unique process
		$ProcessID_i:=New process(Current method name; $StackSize_i; $DesiredProcessName_t; *)
		
		RESUME PROCESS($ProcessID_i)
		SHOW PROCESS($ProcessID_i)
		BRING TO FRONT($ProcessID_i)
End case 
