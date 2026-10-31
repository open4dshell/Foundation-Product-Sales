// ----------------------------------------------------

// Object Method: [Company Info].Input.Company_TermsPopup_at


// Created by 4D, Inc. on May 2, 2003

// Modified by Dave Batton on Oct 1, 2004

// ----------------------------------------------------


If (Form event code=On Data Change)
	Self->{0}:=Fnd_Data_FormatText(Self->{0})
End if 

If ((Form event code=On Clicked) | (Form event code=On Data Change))
	[CompanyInfo]DefaultTerms:=Self->{0}
End if 
