//%attributes = {"invisible":true,"folder":"Fnd_FCS","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_FCS_RequestEcho ($requestBody_t : Text; $requestedAt_t : Text) --> Object

// Builds the object every scheduler result starts from: what was asked, when,
// and by a client believing what. Use it in place of New object when composing
// a result payload.

// The request may state the 4D version the client believes is running, and when
// the client wrote the request:

//   { "expectedVersion": "2007", "requestedAt": "2026-08-10T09:15:00" }

// Both are answered rather than trusted. versionMatch says whether the client
// was right, and requestAgeSeconds how long the request sat before the watcher
// took it - a large age means the watcher was not running when it was written,
// which otherwise reads as a slow compile.

// Access: Private

// Parameters:
//   $requestBody_t : Text : The request JSON, as read by the watcher
//   $requestedAt_t : Text : Timestamp stamped by the watcher when it took the request

// Returns:
//   $echo_o : Object : { v4D ; requestedAt ; and, when the client supplied them,
//      expectedVersion ; versionMatch ; clientRequestedAt ; requestAgeSeconds }

// Created by Wayne Stewart (Claude) on 2026-08-10
// ----------------------------------------------------

#DECLARE($requestBody_t : Text; $requestedAt_t : Text)->$echo_o : Object

var $request_o : Object
var $clientStamp_t : Text
var $clientDate_d; $acceptedDate_d : Date
var $clientTime_h; $acceptedTime_h : Time

$echo_o:=New object
$echo_o.v4D:=Application version
$echo_o.requestedAt:=$requestedAt_t

If ($requestBody_t#"")
	$request_o:=JSON Parse($requestBody_t)
End if 

If ($request_o#Null)
	
	If ($request_o.expectedVersion#Null)
		$echo_o.expectedVersion:=$request_o.expectedVersion
		$echo_o.versionMatch:=($request_o.expectedVersion=Application version)
	End if 
	
	If ($request_o.requestedAt#Null)
		$clientStamp_t:=$request_o.requestedAt
		$echo_o.clientRequestedAt:=$clientStamp_t
		
		$clientDate_d:=Fnd_Date_ISOtoDate($clientStamp_t)
		$clientTime_h:=Fnd_Date_ISOtoTime($clientStamp_t)
		$acceptedDate_d:=Fnd_Date_ISOtoDate($requestedAt_t)
		$acceptedTime_h:=Fnd_Date_ISOtoTime($requestedAt_t)
		
		$echo_o.requestAgeSeconds:=((($acceptedDate_d-$clientDate_d)*86400)+($acceptedTime_h-$clientTime_h))
	End if 
	
End if 
