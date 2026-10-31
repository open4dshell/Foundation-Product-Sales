//%attributes = {"invisible":true,"shared":true,"folder":"Fnd_Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Fnd_Hook_SqNo_SetIDField (->table) --> Pointer

// Foundation's Sequence Number routines (specifically the Fnd_SqNo_SetRecordID
//   method) assume the first field for every table is the table's key field. If this is
//   not the case, you can show Foundation any table's key field here.
// The key field must be a long integer and must be indexed.
// Return a nil pointer to use the first field of the table.

// Method Type: Public

// Parameters: 
//   $1 : Pointer : The table in question.

// Returns: 
//   $0 : Pointer : A pointer to the table's key field
// ----------------------------------------------------

C_POINTER($0; $1; $table_ptr; $keyField_ptr)

$table_ptr:=$1

Case of 
		// Example code. Needed only when the key field is not the first
		//   field created for the table pointed to by $table_ptr.
		
		//: ($table_ptr=(->[People]))
		//   $keyField_ptr:=->[People]ID
End case 

$0:=$keyField_ptr