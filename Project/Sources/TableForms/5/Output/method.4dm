// ----------------------------------------------------

// Form Method: [Products].Output


// Created by 4D, Inc. on May 2, 2003

// Modified by 4D, Inc. on Jun 27, 2003

//   Now the records are sorted when the window is first displayed.

// Modified by Dave Batton on Aug 29, 2004

//   Money formats are now handled procedurally.

// ----------------------------------------------------


Case of 
	: (Form event code=On Load)
		OBJECT SET FORMAT([Products]ListPrice; <>Gen_MoneyFormat_t)  // DB040829 - Added
		
		ORDER BY([Products]; [Products]ProductNumber; >)  // 4D030627 - Added
		
End case 

Fnd_IO_OutputFormMethod