//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_CompilerCheckOnErr

// Error handler installed by Fnd_FCS_CompilerCheck around RELOAD PROJECT and
//   Compile project.

// It writes an immediate failure result so a client polling for
//   compilerResults.json is never left waiting on a compile that died.
//   Fnd_FCS_CompilerCheck overwrites that file with the real summary if it
//   goes on to complete normally, so a recoverable error costs nothing.

// Access: Private

// Parameters: None

// Returns: Nothing

// Created by Wayne Stewart on 2026-08-07
// ----------------------------------------------------

var $error_i : Integer
var $reason_t : Text

$error_i:=Error  // Writing the result may change the Error variable.

$reason_t:="error "+String($error_i)+" in "+Error method+", line "+String(Error line)

Fnd_FCS_WriteFailedResult($reason_t)

Error:=$error_i
