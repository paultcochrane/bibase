# Bibase - Basic command line BibTeX database manager
# Copyright (C) 1999-2013  Paul Cochrane
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
# USA.

use strict;
use warnings;

sub editField {

    my $fieldArrayRef = shift;
    my $fieldAns = shift;
    my $paperArrayRef = shift;
    my @fieldArray = @$fieldArrayRef;
    my @paper = @$paperArrayRef;

    print("\nEditing $fieldArray[$fieldAns] field...\n");
    print("Enter new value for field:\n");
    print("$fieldArray[$fieldAns]");    # this acts as a prompt
    my $newEditVal = <>;
    chop( $newEditVal );
    $paper[$fieldAns] = $newEditVal;
    print("\n$fieldArray[$fieldAns] $paper[$fieldAns] (y/n) ");
    my $checkAns = <>;
    chop( $checkAns );

}
1;

# vim: expandtab shiftwidth=4:
