//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Variadics ({$options_v : Variant})

// Calls a Foundation variadic method across the component boundary and checks
//   that every argument arrived. Run it from the Method editor with FPS open.

// Fnd_Msg_PackParameters is the subject: it takes any number of text arguments
//   and returns them joined by a delimiter, so the answer comes straight back
//   and nothing sits between the call and the assertion.

// It replaced Fnd_Log_AddEntry, which was tried first because it leaves evidence
//   on disk. That was the wrong choice: the evidence path is log selection and
//   then a worker, and Fnd_Log_UseLog is Private, so a host cannot select a log.
//   The test could not tell "the arguments did not arrive" from "logging wrote
//   nowhere" — the instrument was entangled with the subject.

// What is under test is the seam between numbered and named parameter access.
//   Under the classic declaration $1 is copied into a named local; under the
//   ellipsis form that copy is a self-assignment. An alias line commented on the
//   wrong side leaves arguments empty AND STILL COMPILES, so only a call finds
//   it. PackParameters loops ${$i} from 2 to Count parameters, so the symptom is
//   missing or empty trailing segments rather than an error.

// The assertions deliberately mirror Foundation's own Fnd_Test_PackParameters,
//   so a difference between the two is a difference the boundary made.

// Widened rather than narrowed — Fnd_FCS_TestRunner drives this through the
//   scheduler as { "parameters": [{"silent": true}] }, so the single parameter
//   is an object, not the Text this method used to take. $options_v accepts
//   either, dispatching on Value type: an object may carry .configuration
//   (Text) and .silent (Boolean), and a bare Text value is still taken as the
//   configuration name exactly as before. A caller passing Text or nothing at
//   all sees no change in behaviour.

// Access: Private

// Parameters:
//   $options_v : Variant : Either an options object ({configuration: Text; silent: Boolean}) or the legacy Text configuration name (optional, defaults to a description of the running state)

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-11
// ----------------------------------------------------

#DECLARE($options_v : Variant)

var $delimiter_t; $result_t; $expected_t; $configuration_t : Text
var $silent_b : Boolean

$silent_b:=False

If (Count parameters=0)
	$configuration_t:="host"+(Is compiled mode ? "Compiled" : "Interpreted")
	
Else 
	
	If (Value type($options_v)=Is object)
		$configuration_t:=($options_v.configuration=Null) ? ("host"+(Is compiled mode ? "Compiled" : "Interpreted")) : $options_v.configuration
		$silent_b:=($options_v.silent=True)
		
	Else 
		$configuration_t:=String($options_v)
	End if 
	
End if 

Fnd_Test_Begin($configuration_t)

// The delimiter is an interprocess variable inside the component, so a host
//   cannot read it. Derive it: two empty arguments pack to the delimiter alone.
//   This is also the first assertion — it proves two arguments crossed.
$delimiter_t:=Fnd_Msg_PackParameters(""; "")
Fnd_Test_Assert($delimiter_t#""; "two empty arguments should pack to the delimiter alone, but gave an empty string - either the second argument did not arrive or the delimiter is empty")

// One argument comes back unchanged.
$result_t:=Fnd_Msg_PackParameters("message")
Fnd_Test_Assert($result_t="message"; "one argument should come back unchanged but gave \""+$result_t+"\"")

// Two arguments, joined.
$result_t:=Fnd_Msg_PackParameters("message"; "one")
$expected_t:="message"+$delimiter_t+"one"
Fnd_Test_Assert($result_t=$expected_t; "two arguments should be joined by the delimiter but gave \""+$result_t+"\"")

// Four arguments, in order. This is the case that fails when the declaration
//   form is wrong: the trailing ones go missing rather than the call erroring.
$result_t:=Fnd_Msg_PackParameters("message"; "one"; "two"; "three")
$expected_t:="message"+$delimiter_t+"one"+$delimiter_t+"two"+$delimiter_t+"three"
Fnd_Test_Assert($result_t=$expected_t; "four arguments should be joined in order but gave \""+$result_t+"\"")

// Read the segments back, which exercises the boundary in the other direction.
$result_t:=Fnd_Msg_PackParameters("message"; "one"; "two")
Fnd_Test_Assert(Fnd_Msg_GetParameter($result_t; 1)="message"; "segment 1 should be \"message\" but is \""+Fnd_Msg_GetParameter($result_t; 1)+"\"")
Fnd_Test_Assert(Fnd_Msg_GetParameter($result_t; 2)="one"; "segment 2 should be \"one\" but is \""+Fnd_Msg_GetParameter($result_t; 2)+"\"")
Fnd_Test_Assert(Fnd_Msg_GetParameter($result_t; 3)="two"; "segment 3 should be \"two\" but is \""+Fnd_Msg_GetParameter($result_t; 3)+"\"")

Fnd_Test_End($silent_b)
