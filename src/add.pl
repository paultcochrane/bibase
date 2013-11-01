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

sub add {

    my $config = shift;

    print("\n\nDo you want to add:\n\n");
    print("A journal (a)rticle\n");
    print("A (b)ook\n");
    print("An (u)npublished work\n");
    print("An article in a conference (p)roceedings\n");
    print("A (t)hesis\n");
    print("A (c)onference proceedings\n");
    print("A page or chapter (i)n a book\n");
    print("A (misc)ellaneous article\n");
    print("An article in a c(o)llection\n");
    print("A (booklet)\n");
    print("A (man)ual\n");
    print("A (tech)nical report\n");
    print("The (m)ain menu\n");
    print("E(x)it\n\n");

    my $answer;
    print("Choose an option: ");
    chop( $answer = <> );

    if ( $answer eq 'a' ) {
        addArticle( $config );
    }
    elsif ( $answer eq 'b' ) {
        addBook( $config );
    }
    elsif ( $answer eq 'u' ) {
        addUnpublished( $config );
    }
    elsif ( $answer eq 'p' ) {
        addInProc( $config );
    }
    elsif ( $answer eq 't' ) {
        addThesis( $config );
    }
    elsif ( $answer eq 'c' ) {
        addProc( $config );
    }
    elsif ( $answer eq 'i' ) {
        addInBook( $config );
    }
    elsif ( $answer eq 'misc' ) {
        addMisc( $config );
    }
    elsif ( $answer eq 'o' ) {
        addInColl( $config );
    }
    elsif ( $answer eq 'booklet' ) {
        addBooklet( $config );
    }
    elsif ( $answer eq 'man' ) {
        addManual( $config );
    }
    elsif ( $answer eq 'tech' ) {
        addTechReport( $config );
    }
    elsif ( $answer eq 'm' ) {
        mainMenu( $config );
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
        print("woah, something weird happened\n");
        exit(1);
    }

}
1;

# vim: expandtab shiftwidth=4:
