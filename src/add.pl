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

    # clear any variables to stop corruption of .db database file
    &cleanup;

    if ( $answer eq 'a' ) {
        &addArticle;
    }
    elsif ( $answer eq 'b' ) {
        &addBook;
    }
    elsif ( $answer eq 'u' ) {
        &addUnpublished;
    }
    elsif ( $answer eq 'p' ) {
        &addInProc;
    }
    elsif ( $answer eq 't' ) {
        &addThesis;
    }
    elsif ( $answer eq 'c' ) {
        &addProc;
    }
    elsif ( $answer eq 'i' ) {
        &addInBook;
    }
    elsif ( $answer eq 'misc' ) {
        &addMisc;
    }
    elsif ( $answer eq 'o' ) {
        &addInColl;
    }
    elsif ( $answer eq 'booklet' ) {
        &addBooklet;
    }
    elsif ( $answer eq 'man' ) {
        &addManual;
    }
    elsif ( $answer eq 'tech' ) {
        &addTechReport;
    }
    elsif ( $answer eq 'm' ) {
        &mainMenu;
    }
    elsif ($answer eq 'x'
        || $answer eq 'X'
        || $answer eq 'q'
        || $answer eq 'Q' )
    {
        &sortAndCompCheck;
        exit(0);
    }
    else {
        print("woah, something weird happened\n");
        exit(1);
    }

}
1;

# vim: expandtab shiftwidth=4:
