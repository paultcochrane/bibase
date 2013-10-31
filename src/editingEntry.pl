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

sub editingEntry {

    my $entryLine = shift;
    my $indArrayElem = shift;

    my ( $fieldArrayRef, $fieldAns, $paperArrayRef ) = &printToEdit( $entryLine );
    my $checkAns = &editField( $fieldArrayRef, $fieldAns, $paperArrayRef );
    if ( $checkAns eq 'y' || $checkAns eq 'Y' || $checkAns eq '' ) {
        print("\nDo you wish to edit another field? (y/n) ");
        my $newFieldAns = <>;
        chop( $newFieldAns );
        if ( $newFieldAns eq 'y' || $newFieldAns eq 'Y' ) {
            &editingEntry( $entryLine, $indArrayElem );
        }
        elsif ( $newFieldAns eq 'n' || $newFieldAns eq 'N' ) {
            my @addedArray = '';
            for ( my $j = 0 ; $j < 25 ; $j++ ) {
                @addedArray = join( '', @addedArray, ${$paperArrayRef}[$j], "\@" );
            }
            @addedArray = join( '', @addedArray, "\n" );
            push( @main::dbInArray, @addedArray );
            splice( @main::dbInArray, $indArrayElem, 1 );
            my @newDBArray = sort(@main::dbInArray);
            &dotBibWrite( \@newDBArray );
            &bibCompile;
            &mainMenu;
        }
        else {
            print "woah, something weird happened in editingEntry\n";
            &editEntry( 0, 0 );
        }
    }

    elsif ( $checkAns eq 'n' || $checkAns eq 'N' ) {
        $checkAns = &editField( $fieldArrayRef, $fieldAns, $paperArrayRef );
    }
    else {
        print("woah, something strange happened in editingEntry\n");
        &editEntry( 0, 0 );
    }

}
1;

# vim: expandtab shiftwidth=4:
