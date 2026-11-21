Foundation

This folder belongs to Foundation, the open-source 4D component
(https://foundation.open4dshell.com). It holds what Foundation keeps in this
database's Resources folder.

Pictures
Foundation's installer, the method Fnd_Shell_Installer, put the pictures here
after you agreed. They are read by the Foundation forms that were copied into
this database's Forms folder. Each form names its pictures as
/RESOURCES/Foundation/<file>.

Picture                           Form that uses it     Variants present
Fnd_Tlbr_HideThis.png             Fnd_Tlbr_Toolbar
Fnd_Tlbr_Info_Mac.png             Fnd_Tlbr_Toolbar
Fnd_Tlbr_Info_Win.png             Fnd_Tlbr_Toolbar
Fnd_Tlbr_Tlbr_MacLarge.png        Fnd_Tlbr_Toolbar
Fnd_Tlbr_Tlbr_MacSmall.png        Fnd_Tlbr_Toolbar
Fnd_Tlbr_Tlbr_WinLarge.png        Fnd_Tlbr_Toolbar
Fnd_Tlbr_Tlbr_WinSmall.png        Fnd_Tlbr_Toolbar
Fnd_IO_FirstRec.png               Fnd_IO_InputForm      @2x _dark @2x_dark
Fnd_IO_LastRec.png                Fnd_IO_InputForm      @2x _dark @2x_dark
Fnd_IO_NextRec.png                Fnd_IO_InputForm      @2x _dark @2x_dark
Fnd_IO_PrevRec.png                Fnd_IO_InputForm      @2x _dark @2x_dark

The @2x files are for high-resolution displays and the _dark files for the dark
colour scheme. 4D picks them automatically from the plain name.

The installer never replaces a picture that is already here, so you may edit
one. Run Fnd_Shell_Installer at any time to see what Foundation would add and
which pictures differ from the ones it supplies.

List configuration
The folder Fnd_Out, which may not exist, holds one <Table>.json per table: the
list configuration (columns, layouts, the table's own Standard layout,
appearance) saved by the developer from Foundation's list window. Those files
are yours. The installer never creates, replaces or removes them, and they
belong in version control with the rest of the database. A database set up with
an earlier beta may still have them in Resources/Fnd_Out. Foundation reads them
from there until each is next saved, and saves here.

This file itself is rewritten each time the installer copies a form. Do not keep
notes in it.
