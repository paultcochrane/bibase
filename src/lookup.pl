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

sub lookup {

    my $config = shift;

    $main::searchFlag = 1;
    $main::removeFlag = 0;
    $main::editFlag   = 0;

    sortAndCompCheck( $config );

    @main::dbInArray     = '';
    my @titleArray    = '';
    my @authorArray   = '';
    my @entryArray    = '';
    my @bibkeyArray   = '';
    my @journalArray  = '';
    my @yearArray     = '';
    my @keywordsArray = '';

    open my $dbInFile, "<", $config->dbFname;

    my $dbNumLines = 0;
    while (<$dbInFile>) {
        $main::dbInArray[$dbNumLines] = $_;
        my @lineArray = split( '@', $main::dbInArray[$dbNumLines] );
        $titleArray[$dbNumLines]    = $lineArray[3];
        $authorArray[$dbNumLines]   = $lineArray[2];
        $entryArray[$dbNumLines]    = $lineArray[1];
        $bibkeyArray[$dbNumLines]   = $lineArray[0];
        $journalArray[$dbNumLines]  = $lineArray[4];
        $yearArray[$dbNumLines]     = $lineArray[5];
        $keywordsArray[$dbNumLines] = $lineArray[24];

        $dbNumLines++;
    }

    close($dbInFile);

    print "\nPossible search areas are:\n\n";

    print "(A)ll fields\n";
    print "(T)itle field only\n";
    print "(Au)thor field only\n";
    print "(K)eywords field only\n";
    print "(Y)ear field only\n";
    print "(J)ournal field only\n";
    print "(E)ntry type field only\n";
    print "(B)ibliography key field only\n";
    print "Return to (m)ain menu\n";
    print "\n";
    print "Enter an area within which to search: ";

    my $answer;
    chop( $answer = <> );

    print "\n";

    if ( $answer eq '' ) {
        print "Please make a selection\n";
        &lookup;
    }
    elsif ( $answer eq 'A' || $answer eq 'a' ) {
        &searchAll($dbNumLines);
    }
    elsif ( $answer eq 'T' || $answer eq 't' ) {
        &searchTitle( @titleArray );
    }
    elsif ($answer eq 'Au'
        || $answer eq 'au'
        || $answer eq 'AU'
        || $answer eq 'aU' )
    {
        &searchAuthor( @authorArray );
    }
    elsif ( $answer eq 'K' || $answer eq 'k' ) {
        &searchKeywords( @keywordsArray );
    }
    elsif ( $answer eq 'Y' || $answer eq 'y' ) {
        &searchYear( @yearArray );
    }
    elsif ( $answer eq 'J' || $answer eq 'j' ) {
        &searchJournal( @journalArray );
    }
    elsif ( $answer eq 'E' || $answer eq 'e' ) {
        &searchEntry( @entryArray );
    }
    elsif ( $answer eq 'B' || $answer eq 'b' ) {
        &searchBibkey( @bibkeyArray );
    }
    elsif ( $answer eq 'm' || $answer eq 'M' ) {
        &mainMenu;
    }
    else {
        print "something went wrong in lookup.pl\n";
        &lookup;
    }

    &mainMenu;
}
1;

# vim: expandtab shiftwidth=4:
