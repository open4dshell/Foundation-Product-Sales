// _Matrix_Testing window-dimensions diagnostic.
// Created by Wayne Stewart
// Wayne Stewart (Claude) 2026-08-01 -> 2026-11-01 - Prepare Foundation 6 release
var $o : Object
var $left; $top; $right; $bottom; $width; $height : Integer

$o:=New object
GET WINDOW RECT($left; $top; $right; $bottom)
FORM GET PROPERTIES("_Matrix_Testing"; $width; $height)

$o.Left:=$left
$o.Top:=$top
$o.Right:=$right
$o.Bottom:=$bottom
$o.windowWidth:=$right-$left
$o.windowHeight:=$bottom-$top
$o.formWidth:=$width
$o.formHeight:=$height
$o.screenWidth:=Screen width
$o.screenHeight:=Screen height
$o.menuBar:=Menu bar height
$o.toolbarHeight:=Fnd_Wnd_ToolbarHeight
//$o.titleBarHeight:=$o.formHeight-($top-$bottom)

SET TEXT TO PASTEBOARD(JSON Stringify($o; *))
