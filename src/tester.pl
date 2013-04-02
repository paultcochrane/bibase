#!perl

use strict;

use Mac::Windows;
use Mac::QuickDraw;
use Mac::Fonts;
use Mac::Events;
use Mac::Controls;
use Mac::Dialogs;

my($dlg);

$dlg = MacDialog->new(
Rect->new(50, 50, 450, 155),# dialog rectangle
'Welcome to MacPerl',# dialog title
1,# is visible?
movableDBoxProc(),# window style
0,# has go away box?
[ kButtonDialogItem(),
Rect->new(300, 30, 380, 50), 'Cancel'],
[ kButtonDialogItem(),
Rect->new(300, 70, 380, 90), 'OK'],
[ kStaticTextDialogItem(),
Rect->new(10, 10, 220, 30),
'How do you like MacPerl?'],
[ kCheckBoxDialogItem(),
Rect->new(15, 80, 180, 95),
'First time user?'],
[ kEditTextDialogItem(),
Rect->new(15, 50, 180, 65), ''],
);

SetDialogCancelItem ($dlg->window(), 1);
SetDialogDefaultItem($dlg->window(), 2);
SelectDialogItemText($dlg->window(), 5);

$dlg->item_hit(1 => \&d1);
$dlg->item_hit(2 => \&d2);
$dlg->item_hit(4 => \&d4);

sub d4 {
my($dlg, $item) = @_;
if ($dlg->item_value($item) == 0) {
$dlg->item_value($item, 1);
return(1);
} elsif ($dlg->item_value($item) == 1) {
$dlg->item_value($item, 0);
return(1);
}
}

sub d1 {
my($dlg) = @_;
print "You clicked Cancel\n";
$dlg->dispose();
return(1);
} 


sub d2 {
my($dlg) = @_;
printf "You typed: %s\n", $dlg->item_text(5);
printf "You are %s first time user\n",
$dlg->item_value(4) ? 'a' : 'not a';
$dlg->dispose();
return(1);
} 

END { $dlg->dispose() if (defined($dlg)) } 

while ($dlg->window()) {
$dlg->modal();
										

	

# $style = documentProc();
# $title = 'Mooooo';
# $winr = Rect->new(75, 75, 425, 250);
# $win = MacWindow->new($winr, $title, 1, $style, 1);
# $win->sethook('redraw' => \&draw_it);
# while($win->window()) {
# 	WaitNextEvent();
# 	}
# 
# END {
# 	$win->dispose() if (defined($win));
# 	}
# 
# sub draw_it {
# 	}

# vim: expandtab shiftwidth=4:
