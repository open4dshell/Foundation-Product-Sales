//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_CompilationPath --> Text

// Returns the compilation_path setting, or "" if it cannot be read.

// It decides whether Compiler_ typing methods are honoured — "4" is direct
//   typing, which ignores them and requires #DECLARE on every method — so a
//   compile result is not comparable to another without it. The setting is not
//   in git, and only exists in projects converted from before 4D 20 R7.

// Access: Private

// Parameters: None

// Returns:
//   $compilationPath_t : Text : The compilation_path value, or "" if absent

// Created by Wayne Stewart on 2026-08-08
// ----------------------------------------------------

#DECLARE()->$compilationPath_t : Text

var $settingsPath_t; $settings_t : Text
var $position_i : Integer

$compilationPath_t:=""

$settingsPath_t:=Get 4D folder(Database folder)+"Project"+Folder separator+"Sources"+Folder separator+"settings.4DSettings"

If (Test path name($settingsPath_t)=Is a document)
	$settings_t:=Document to text($settingsPath_t)
	$position_i:=Position("compilation_path=\""; $settings_t)
	
	If ($position_i>0)
		$compilationPath_t:=Substring($settings_t; ($position_i+18))
		$compilationPath_t:=Substring($compilationPath_t; 1; (Position("\""; $compilationPath_t)-1))
	End if 
	
End if 
