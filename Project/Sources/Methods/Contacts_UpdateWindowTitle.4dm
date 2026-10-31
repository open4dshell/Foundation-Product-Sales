//%attributes = {"invisible":true,"shared":true,"folder":"Project_Methods","lang":"en"}
// ----------------------------------------------------
// Project Method: Contacts_UpdateWindowTitle

// Updates the window title and the item in the Window menu.

// Parameters: None

// Returns: Nothing

// Created by Dave Batton on Feb 23, 2005
// ----------------------------------------------------

Fnd_Wnd_Title("Contact: "+Contacts_FullName)
Fnd_Menu_Window_Add