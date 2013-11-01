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

sub mainMenu {

    my $config = shift;

    print("\n\n");
    print("Would you like to:\n\n");
    print("(S)earch for an entry\n");
    print("(A)dd an entry\n");
    print("(R)emove an entry\n");
    print("(E)dit an entry\n");
    print("E(x)it\n\n");

    my $answer;
    print("Please choose an option: ");
    chop( $answer = <> );

    if ( $answer eq 'l' || $answer eq 'L' || $answer eq 's' || $answer eq 'S' )
    {
        &lookup;
    }
    elsif ( $answer eq 'a' || $answer eq 'A' ) {
        &add;
    }
    elsif ( $answer eq 'r' || $answer eq 'R' ) {
        &remove;
    }
    elsif ($answer eq 'c'
        || $answer eq 'C'
        || $answer eq 'e'
        || $answer eq 'E' )
    {
        &edit;
    }
    elsif ($answer eq 'x'
        || $answer eq 'X'
        || $answer eq 'q'
        || $answer eq 'Q' )
    {
        sortAndCompCheck( $config );
        exit(0);
    }
    else {
        print("woah, something weird must have happened\n");
        mainMenu( $config );
    }

}
1;

# vim: expandtab shiftwidth=4:
