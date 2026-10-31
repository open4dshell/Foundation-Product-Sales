//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_TestRunner ($requestedAt_t : Text; $requestBody_t : Text)

// Runs test methods on request and writes the results. Spawned by
// Fnd_FCS_SchedStart on a request whose action is "test"; not called directly.
// The request body is handed in rather than read from disk, because the watcher
// has already consumed it.

// The request names what to run, in any of three ways:
//   { "method": "Test_Fnd_Data" }
//   { "methods": ["Test_Fnd_Data"; "Fnd_Test_StripSpaces"] }
//   { "filter": "Test_Fnd_@" }
// with an optional "parameters" collection passed to each method, up to five.
// An empty or unreadable request runs every test method.

// Tests are named Test_Fnd_<module>, one or two per module rather than one per
// function, so they sort together rather than scattering through the Fnd_ names.
// The older Fnd_Test_<subject> names are still picked up while any remain.

// Anything callable can be driven through here, not only tests. The documentation
// rebuild is the standing example, and it takes a single options object rather
// than five positional parameters:
//   { "action": "test"; "method": "Fnd_FCS_WriteDocumentation";
//     "parameters": [{"silent": true; "inline": true}] }

// Results land in <Resources>/schedulerResult.json, always, including on failure.
// requestedAt is echoed so a client can tell a fresh result from a stale one.

// Interpreted mode only, and never preemptive: it executes arbitrary methods.

// Access: Private

// Parameters:
//   $requestedAt_t : Text : Timestamp stamped by the watcher when it took the request
//   $requestBody_t : Text : The request JSON, as read by the watcher

// Returns: Nothing

// Created by Wayne Stewart (Claude) on 2026-08-10
// ----------------------------------------------------

#DECLARE($requestedAt_t : Text; $requestBody_t : Text)

var $resultsPath_t; $method_t; $name_t; $oldErrorHandler_t : Text
var $request_o; $summary_o; $methodResult_o : Object
var $methods_c; $parameters_c; $results_c; $parts_c; $keep_c : Collection
var $i : Integer
var $result_v : Variant

ARRAY TEXT($paths_at; 0)

RELOAD PROJECT

// ----------------------------------------------------

$resultsPath_t:=Get 4D folder(Current resources folder)+"schedulerResult.json"

$request_o:=New object
$methods_c:=New collection
$parameters_c:=New collection
$results_c:=New collection

// The watcher leaves the body in Storage; the parameter is a fallback.
If ($requestBody_t="")
	
	If (Storage.sched#Null)
		$requestBody_t:=Storage.sched.requestBody
	End if 
	
End if 

If ($requestBody_t#"")
	$request_o:=JSON Parse($requestBody_t)
End if 

If ($request_o=Null)
	$request_o:=New object
End if 

If ($request_o.parameters#Null)
	$parameters_c:=$request_o.parameters
End if 

// ----------------------------------------------------
// Which methods to run

Case of 
		
	: ($request_o.method#Null)
		$methods_c.push($request_o.method)
		
	: ($request_o.methods#Null)
		$methods_c:=$request_o.methods.copy()
		
	Else 
		// A filter, or nothing at all, which means every test.
		$method_t:=($request_o.filter#Null) ? $request_o.filter : ""
		
		METHOD GET PATHS(Path project method; $paths_at)
		
		For ($i; 1; Size of array($paths_at))
			
			// The paths are folder qualified - "Fnd_Test/Test_Fnd_Data" - so
			//   match on the name, which is also what EXECUTE METHOD wants.
			$parts_c:=Split string($paths_at{$i}; "/")
			$name_t:=$parts_c[$parts_c.length-1]
			
			Case of 
				: ($method_t#"")
					
					If ($name_t=$method_t)  // = honours the @ wildcard
						$methods_c.push($name_t)
					End if 
					
					// No filter, so every test method under either naming. Tests are
					//   Test_Fnd_<module>; the older Fnd_Test_ names are matched while
					//   any of them remain.
				: (($name_t="Test_Fnd_@") | ($name_t="Fnd_Test_@"))
					$methods_c.push($name_t)
				
			End case 
			
		End for 
	
End case 

// Fnd_Test_Assert and Fnd_Test_End are the harness, not tests. Filtered by
//   hand: query's "value" placeholder addresses object properties, so it finds
//   nothing in a collection of plain strings and would empty the list.
$keep_c:=New collection

For each ($name_t; $methods_c)
	
	If (($name_t#"Fnd_Test_Assert") && ($name_t#"Fnd_Test_End"))
		$keep_c.push($name_t)
	End if 
	
End for each 

$methods_c:=$keep_c

// ----------------------------------------------------
// Run them

For each ($method_t; $methods_c)
	
	$methodResult_o:=New object("method"; $method_t; "passed"; 0; "failed"; 0; "failures"; New collection; "error"; "")
	
	// Established here rather than left to Fnd_Test_Assert, so a test that
	//   errors before its first assertion still has somewhere to be recorded.
	Use (Storage)
		Storage.test:=New shared object("passed"; 0; "failed"; 0; "closed"; False; "assertions"; New shared collection)
	End use 
	
	$oldErrorHandler_t:=Method called on error
	ON ERR CALL("Fnd_FCS_TestRunnerOnErr")
	
	Case of 
		: ($parameters_c.length=0)
			EXECUTE METHOD($method_t)
			
		: ($parameters_c.length=1)
			EXECUTE METHOD($method_t; $result_v; $parameters_c[0])
			
		: ($parameters_c.length=2)
			EXECUTE METHOD($method_t; $result_v; $parameters_c[0]; $parameters_c[1])
			
		: ($parameters_c.length=3)
			EXECUTE METHOD($method_t; $result_v; $parameters_c[0]; $parameters_c[1]; $parameters_c[2])
			
		: ($parameters_c.length=4)
			EXECUTE METHOD($method_t; $result_v; $parameters_c[0]; $parameters_c[1]; $parameters_c[2]; $parameters_c[3])
			
		Else 
			EXECUTE METHOD($method_t; $result_v; $parameters_c[0]; $parameters_c[1]; $parameters_c[2]; $parameters_c[3]; $parameters_c[4])
	End case 
	
	ON ERR CALL($oldErrorHandler_t)
	
	$methodResult_o.passed:=Storage.test.passed
	$methodResult_o.failed:=Storage.test.failed
	$methodResult_o.failures:=Storage.test.assertions.copy()
	
	If (Storage.test.error#Null)
		$methodResult_o.error:=Storage.test.error
	End if 
	
	$results_c.push($methodResult_o)
	
	Use (Storage)
		OB REMOVE(Storage; "test")
	End use 
	
End for each 

// ----------------------------------------------------
// Report

$summary_o:=Fnd_FCS_RequestEcho($requestBody_t; $requestedAt_t)
$summary_o.project:="FPS"
$summary_o.action:="test"
$summary_o.methodCount:=$results_c.length
$summary_o.passed:=$results_c.sum("passed")
$summary_o.failed:=$results_c.sum("failed")
$summary_o.success:=(($results_c.length>0) && ($summary_o.failed=0) && ($results_c.query("error != :1"; "").length=0))
$summary_o.methods:=$results_c
$summary_o.completedAt:=Fnd_Date_LocalTimestamp

TEXT TO DOCUMENT($resultsPath_t; JSON Stringify($summary_o))
