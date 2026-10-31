//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Release ({$options_v : Variant})

// Checks, from the host, what the open-source release changed in Foundation:
//   its own licensing is gone, localized strings come back, cs.fnd.wnd is no
//   longer published, the About box's credits name Dave Batton and Walt
//   Nelson, and Resources/MIT Licence.txt names all three copyright holders and
//   matches the root LICENSE.

// Checks that read the component's source are logged as "not run" when the
//   component is built rather than linked. Fnd_Reg_Init is always "not run":
//   its missing-table question is a modal, so Fnd_Reg is tested by hand during
//   development (FND-85).

// Run it through the scheduler as { "parameters": [{"silent": true}] }. Each
//   run of this or Fnd_Test_Variadics rewrites the matrix cell's result file.

// Access: Private

// Parameters:
//   $options_v : Variant : Either an options object ({configuration: Text; silent: Boolean}) or a Text configuration name (optional, defaults to a description of the running state)

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-10-23
// ----------------------------------------------------

#DECLARE($options_v : Variant)

var $configuration_t; $label_t; $string_t; $name_t; $language_t; $text_t : Text
var $silent_b : Boolean
var $licence_x; $license_x : Blob
var $component_folder; $sources_folder : 4D.Folder
var $link_file; $method_file; $form_file; $credits_file; $licence_file; $license_file : 4D.File
var $regMethods_c; $objectNames_c : Collection
var $form_o; $page_o : Object

$silent_b:=False
$configuration_t:="host"+(Is compiled mode ? "Compiled" : "Interpreted")

If (Count parameters>0)

	If (Value type($options_v)=Is object)

		If ($options_v.configuration#Null)
			$configuration_t:=$options_v.configuration
		End if

		$silent_b:=($options_v.silent=True)

	Else
		$configuration_t:=String($options_v)
	End if

End if

Fnd_Test_Begin($configuration_t)

// The linked component's Project folder, found through its symlink in
//   Components. A built component has no source, and leaves this Null.
For each ($link_file; Folder(fk database folder).folder("Components").files())

	If ($link_file.isAlias && ($link_file.original#Null))

		If (($link_file.original.extension=".4DProject") && ($link_file.original.name="Foundation@"))
			$component_folder:=$link_file.original.parent
		End if

	End if

End for each

If ($component_folder#Null)
	$sources_folder:=$component_folder.folder("Sources")
End if

//MARK:- Foundation's own licensing is gone

// Fnd_Shell_DoesMethodExist looks in the host. Fnd_Gen_ComponentAvailable
//   runs METHOD GET NAMES inside the component, for <name>_Info.
Fnd_Test_Assert(Not(Fnd_Gen_ComponentAvailable("Fnd_Gen_Reg")); "the component should not report Fnd_Gen_Reg as available, but Fnd_Gen_ComponentAvailable(\"Fnd_Gen_Reg\") is True")

If ($sources_folder=Null)
	Fnd_Log_AddEntry(New object("logLevel"; 1); "not run"; Current method name; "Fnd_Gen_Reg* methods and forms: the component is not linked source")

Else
	$regMethods_c:=New collection

	For each ($method_file; $sources_folder.folder("Methods").files())
		$name_t:=$method_file.name

		If (($name_t="Fnd_Gen_Reg@") | ($name_t="Fnd_Gen_RemoveActivationCode"))
			$regMethods_c.push($name_t)
		End if

	End for each

	Fnd_Test_Assert($regMethods_c.length=0; "the component source should have no Fnd_Gen_Reg* method but has "+String($regMethods_c.length)+": "+$regMethods_c.join(", "))
	Fnd_Test_Assert(Not($sources_folder.folder("Forms").folder("Fnd_Gen_Reg_DemoDialog").exists); "the component should have no Fnd_Gen_Reg_DemoDialog form")
	Fnd_Test_Assert(Not($sources_folder.folder("Forms").folder("Fnd_Gen_Reg_RegisterDialog").exists); "the component should have no Fnd_Gen_Reg_RegisterDialog form")

End if

// Fnd_Hook_Shell_Startup starts the watcher last, so a registration or demo
//   dialog at startup would have stopped it from ever running.
Fnd_Test_Assert(Process number("$Fnd_FCS_SchedStart")>0; "the scheduler should be running, which startup reaches only after any registration or demo dialog")

//MARK:- Fnd_Reg_Init

Fnd_Log_AddEntry(New object("logLevel"; 1); "not run"; Current method name; "Fnd_Reg_Init: Fnd_Reg's missing-table behaviour is tested by hand during development (FND-85), because its question is a modal")

//MARK:- Localized strings

// Fnd_Loc_ListToArray reports a missing hook by this same test.
Fnd_Test_Assert(Fnd_Shell_DoesMethodExist("Fnd_Host_ListToArray")=1; "the host should have Fnd_Host_ListToArray")

// Fnd_Gen's strings are loaded when Foundation starts.
For each ($label_t; New collection("OK"; "Cancel"; "Stop"))
	$string_t:=Fnd_Loc_GetString("Fnd_Gen"; $label_t)
	Fnd_Test_Assert($string_t#""; "Fnd_Loc_GetString(\"Fnd_Gen\"; \""+$label_t+"\") should not be empty")
End for each

// FPS carries the Fnd_List lists itself, so these can come through the hook.
For each ($label_t; New collection("SortButton"; "DeleteButton"; "AddButton"))
	$string_t:=Fnd_Loc_GetString("Fnd_List"; $label_t)
	Fnd_Test_Assert($string_t#""; "Fnd_Loc_GetString(\"Fnd_List\"; \""+$label_t+"\") should not be empty")
End for each

//MARK:- cs.fnd.wnd is not published

// Bracket access, so a compiled host does not resolve the names at compile time.
Fnd_Test_Assert(cs.fnd#Null; "the component class store cs.fnd should be reachable")

If (cs.fnd#Null)
	Fnd_Test_Assert(cs.fnd["text"]#Null; "cs.fnd.text should still be published")
	Fnd_Test_Assert(cs.fnd["wnd"]=Null; "cs.fnd.wnd should no longer be published")
End if

//MARK:- About box credit and licence

If ($sources_folder=Null)
	Fnd_Log_AddEntry(New object("logLevel"; 1); "not run"; Current method name; "Fnd_Art credits files and About tabs: the component is not linked source")
	
Else 
	
	// The Foundation tab shows Resources/Fnd_Art/Credits_<language>.txt.
	For each ($language_t; New collection("EN"; "FR"))
		$credits_file:=$component_folder.parent.folder("Resources").folder("Fnd_Art").file("Credits_"+$language_t+".txt")
		Fnd_Test_Assert($credits_file.exists; "the component should have "+$credits_file.platformPath)
		
		If ($credits_file.exists)
			$text_t:=$credits_file.getText("UTF-8")
			
			For each ($name_t; New collection("Dave Batton"; "Walt Nelson"))
				Fnd_Test_Assert(Position($name_t; $text_t)>0; "Credits_"+$language_t+".txt should contain \""+$name_t+"\"")
			End for each 
			
		End if 
		
	End for each 
	
	$form_file:=$sources_folder.folder("Forms").folder("Fnd_Art_About").file("form.4DForm")
	Fnd_Test_Assert($form_file.exists; "the component should have the Fnd_Art_About form at "+$form_file.platformPath)
	
	$objectNames_c:=New collection
	
	If ($form_file.exists)
		$form_o:=JSON Parse($form_file.getText("UTF-8"))
		
		For each ($page_o; $form_o.pages)
			
			If ($page_o#Null)
				
				If ($page_o.objects#Null)
					$objectNames_c.combine(OB Keys($page_o.objects))
				End if 
				
			End if 
			
		End for each 
		
	End if 
	
	Fnd_Test_Assert($objectNames_c.indexOf("aboutFoundation")>=0; "the Fnd_Art_About form should have the aboutFoundation object, the Foundation tab")
	Fnd_Test_Assert($objectNames_c.indexOf("MIT")>=0; "the Fnd_Art_About form should have the MIT object, the Licence tab")
	
	// The Licence tab shows Resources/MIT Licence.txt, a copy of the root LICENSE.
	$licence_file:=$component_folder.parent.folder("Resources").file("MIT Licence.txt")
	$license_file:=$component_folder.parent.file("LICENSE")
	Fnd_Test_Assert($licence_file.exists; "the component should have "+$licence_file.platformPath)
	Fnd_Test_Assert($license_file.exists; "the component should have "+$license_file.platformPath)
	
	If ($licence_file.exists)
		$text_t:=$licence_file.getText("UTF-8")
		
		For each ($name_t; New collection("Dave Batton"; "Walt Nelson"; "Wayne Stewart"))
			Fnd_Test_Assert(Position($name_t; $text_t; *)>0; "MIT Licence.txt should contain \""+$name_t+"\"")
		End for each 
		
		If ($license_file.exists)
			// A digest, because = on Text ignores case and diacritics. Generate digest takes a Blob variable.
			$licence_x:=$licence_file.getContent()
			$license_x:=$license_file.getContent()
			Fnd_Test_Assert(Generate digest($licence_x; MD5 digest)=Generate digest($license_x; MD5 digest); "MIT Licence.txt should be identical to LICENSE, but is "+String($licence_file.size)+" bytes against "+String($license_file.size))
		End if 
		
	End if 
	
End if 

Fnd_Test_End($silent_b)
