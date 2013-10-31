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

sub editingEntry {

    my ( $fieldArrayRef, $fieldAns, $paperArrayRef ) = &printToEdit;
    my @paper = @$paperArrayRef;
    &editField( $fieldArrayRef, $fieldAns, $paperArrayRef );
    if ( $checkAns eq 'y' || $checkAns eq 'Y' || $checkAns eq '' ) {
        print("\nDo you wish to edit another field? (y/n) ");
        chop( $newFieldAns = <> );
        if ( $newFieldAns eq 'y' || $newFieldAns eq 'Y' ) {
            &editingEntry;
        }
        elsif ( $newFieldAns eq 'n' || $newFieldAns eq 'N' ) {
            @addedArray = '';
            for ( $j = 0 ; $j < 25 ; $j++ ) {
                @addedArray = join( '', @addedArray, @paper[$j], "\@" );
            }
            @addedArray = join( '', @addedArray, "\n" );
            push( @dbInArray, @addedArray );
            splice( @dbInArray, @indArray[$i], 1 );
            @newDBArray = sort(@dbInArray);
            &dotBibWrite;
            &bibCompile;
            &mainMenu;
        }
        else {
            print "woah, something weird happened in editingEntry\n";
            &editEntry( 0 );
        }
    }

    elsif ( $checkAns eq 'n' || $checkAns eq 'N' ) {
        &editField( $fieldArrayRef, $fieldAns, $paperArrayRef );
    }
    else {
        print("woah, something strange happened in editingEntry\n");
        &editEntry( 0 );
    }

}
1;

# vim: expandtab shiftwidth=4:
