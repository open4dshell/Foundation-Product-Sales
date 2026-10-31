//%attributes = {"invisible":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Test_Stamp --> Text

// A local timestamp for the test records: YYYY-MM-DDThh:mm:ss.

// Written by hand rather than with String(date; ISO date), which already yields
//   a complete datetime and produced "2026-08-11T00:00:00T19:04:35" when a time
//   was appended to it.

// Access: Private

// Parameters: None

// Returns:
//   $stamp_t : Text : Local date and time, YYYY-MM-DDThh:mm:ss

// Created by Wayne Stewart (Claude) on 2026-08-11
// ----------------------------------------------------

#DECLARE->$stamp_t : Text

$stamp_t:=String(Year of(Current date); "0000")\
+"-"+String(Month of(Current date); "00")\
+"-"+String(Day of(Current date); "00")\
+"T"+String(Current time; HH MM SS)
