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

sub dotBibWrite {

    print("\nKeeping a copy of old .bib file");

    open( my $inFile, "< $main::DBFile" );
    my $keepFname = join( '', "$main::DBFile", ".bak" );
    open( my $keepFile, "> $keepFname" );
    while (<$inFile>) {
        print( $keepFile "$_" );
    }
    close($keepFile);
    close($inFile);

    print("\nWriting new (sorted) .bib file...");

    open( my $outFile, "> $main::DBFile" );

    my $sizeNewDBArray = @main::newDBArray;
    my $i              = 0;

    while ( $i < $sizeNewDBArray ) {

        my @bibArray = split( /\@/, $main::newDBArray[$i] );

        my $bibkey       = @bibArray[0];
        my $entry        = @bibArray[1];
        my $author       = @bibArray[2];
        my $title        = @bibArray[3];
        my $journal      = @bibArray[4];
        my $year         = @bibArray[5];
        my $volume       = @bibArray[6];
        my $number       = @bibArray[7];
        my $month        = @bibArray[8];
        my $pages        = @bibArray[9];
        my $ref          = @bibArray[10];
        my $publisher    = @bibArray[11];
        my $editor       = @bibArray[12];
        my $series       = @bibArray[13];
        my $address      = @bibArray[14];
        my $edition      = @bibArray[15];
        my $chapter      = @bibArray[16];
        my $type         = @bibArray[17];
        my $school       = @bibArray[18];
        my $organisation = @bibArray[19];
        my $booktitle    = @bibArray[20];
        my $crossref     = @bibArray[21];
        my $howpub       = @bibArray[22];
        my $institution  = @bibArray[23];
        my $keywords     = @bibArray[24];

        print( $outFile "\@$entry\{$bibkey,\n" );
        print( $outFile "author = \{$author\},\n" );
        print( $outFile "title = \{$title\},\n" );

      # I should really do some error checking here to see if the values exist
      # and exit with an error message if not
      # Maybe it would be quicker to put all elements in one big array and then
      # write o$ut all at once - maybe a later version, memory hungry, but better
      # for huge .bib files

        if ( @bibArray[4] ne '' ) {
            print( $outFile "journal = \{$journal\},\n" );
        }
        if ( @bibArray[5] ne '' ) { print( $outFile "year = \{$year\},\n" ); }
        if ( @bibArray[6] ne '' ) {
            print( $outFile "volume = \{$volume\},\n" );
        }
        if ( @bibArray[7] ne '' ) {
            print( $outFile "number = \{$number\},\n" );
        }
        if ( @bibArray[8]  ne '' ) { print( $outFile "month = \{$month\},\n" ); }
        if ( @bibArray[9]  ne '' ) { print( $outFile "pages = \{$pages\},\n" ); }
        if ( @bibArray[10] ne '' ) { print( $outFile "note = \{$ref\},\n" ); }

        if ( @bibArray[11] ne '' ) {
            print( $outFile "publisher = \{$publisher\},\n" );
        }
        if ( @bibArray[12] ne '' ) {
            print( $outFile "editor = \{$editor\},\n" );
        }
        if ( @bibArray[13] ne '' ) {
            print( $outFile "series = \{$series\},\n" );
        }
        if ( @bibArray[14] ne '' ) {
            print( $outFile "address = \{$address\},\n" );
        }
        if ( @bibArray[15] ne '' ) {
            print( $outFile "edition = \{$edition\},\n" );
        }

        if ( @bibArray[16] ne '' ) {
            print( $outFile "chapter = \{$chapter\},\n" );
        }
        if ( @bibArray[17] ne '' ) { print( $outFile "type = \{$type\},\n" ); }
        if ( @bibArray[18] ne '' ) {
            print( $outFile "school = \{$school\},\n" );
        }
        if ( @bibArray[19] ne '' ) {
            print( $outFile "organization = \{$organisation\},\n" );
        }
        if ( @bibArray[20] ne '' ) {
            print( $outFile "booktitle = \{$booktitle\},\n" );
        }
        if ( @bibArray[21] ne '' ) {
            print( $outFile "crossref = \{$crossref\},\n" );
        }
        if ( @bibArray[22] ne '' ) {
            print( $outFile "howpublished = \{$howpub\},\n" );
        }
        if ( @bibArray[23] ne '' ) {
            print( $outFile "institution = \{$institution\},\n" );
        }
        if ( @bibArray[24] ne '' ) {
            print( $outFile "keywords = \{$keywords\}\n" );
        }
        print( $outFile "\}\n\n" );

        $i++;
    }

    close($outFile);

    print("done\n");
}
1;

# vim: expandtab shiftwidth=4:
