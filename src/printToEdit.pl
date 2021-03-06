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

use warnings;
use strict;

sub printToEdit {

    my $entryLine = shift;

    print("\nediting the following entry...\n");
    my ( $fieldArrayRef, $paperArrayRef ) = &printAllFields( $entryLine );
    print("\nwhich field do you wish to edit?\n");
    print("(enter the number beside the field you wish to edit) ");
    my $fieldAns;
    chop( $fieldAns = <> );

    return ( $fieldArrayRef, $fieldAns, $paperArrayRef );
}
1;

# vim: expandtab shiftwidth=4:
