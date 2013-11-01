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

sub printSearchResults {

    my $grepArrayRef = shift;
    my $grepCount = @$grepArrayRef;

    print("\n$grepCount entries found\n");
    print("showing results...\n\n");

    for ( my $i = 0 ; $i < $grepCount ; $i++ ) {
        &prettyPrintSearchResults( ${$grepArrayRef}[$i] );
        if ( $i != $grepCount - 1 ) {

            my $answer;
            print("\nshow next entry? (y/n) ");
            chop( $answer = <> );
            if ( $answer eq 'n' || $answer eq 'N' ) {
                mainMenu( $config );
            }
            elsif ( $answer eq 'y' || $answer eq 'Y' || $answer eq '' ) {
            }
            else {
                print
                  "whoops, something weird happened in printSearchResults\n";
                mainMenu( $config );
            }
        }
    }
}
1;

# vim: expandtab shiftwidth=4:
