// ----------------------------------------------------
// Object Method: Address

// Created by Dave Batton on Oct 1, 2004
// ----------------------------------------------------
C_TEXT($TextFilter_txt)

Case of 
	: (Form event code=On Load)
		$TextFilter_txt:="&"+Char(Double quote)+"a-z;A-Z;0-9; -?;:-@;[-';_;];{;};|"+Char(13)+Char(Double quote)  // Credit to Chuck Miller for this filter
		OBJECT SET FILTER(Self->; $TextFilter_txt)
	: (Form event code=On Data Change)
		Self->:=Fnd_Data_FormatText(Self->)
End case 
