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

sub bibCompile {

    print("\nCompiling database file...");

    open( my $bibAltDBFile, "> $main::altDBFile" );

    open( my $bibInFile, "< $main::DBFile" );

    my $numLines = 0;
    my @inArray;
    while (<$bibInFile>) {
        @inArray[$numLines] = $_;
        $numLines++;
    }

    close($bibInFile);

    $numLines = $numLines - 1;
    my $lineNum  = 0;
    my $comp     = 0;
    chop(@inArray);

    while ( $lineNum < $numLines ) {

        my $lineStr = '';
        $lineStr = @inArray[$lineNum];
        $lineStr =~ s/^\s*//;

        my $field      = '';
        my $fieldValue = '';

        my $entry;
        my $bibkey;
        if ( $lineStr =~ m/^\@/ ) {
            $entry = $lineStr;
            $entry =~ s/\@//;
            $entry =~ s/[{].*//;
            $bibkey = $lineStr;
            $bibkey =~ s/^.*[{]//;
            $bibkey =~ s/,//;
        }
        elsif ( $lineStr =~ m/^[a-zA-Z]/ ) {
            $field = @inArray[$lineNum];
            $field =~ s/\s*=.*//;
            $fieldValue = @inArray[$lineNum];
            $fieldValue =~ s/^[a-zA-Z\s]*=[\s{]*//;
            $fieldValue =~ s/\s*[}]*\s*[,]*$//;
        }

        my $author;
        my $authorValue;
        my $title;
        my $titleValue;
        my $journal;
        my $journalValue;
        my $year;
        my $yearValue;
        my $volume;
        my $volumeValue;
        my $number;
        my $numberValue;
        my $month;
        my $monthValue;
        my $pages;
        my $pagesValue;
        my $ref;
        my $refValue;
        my $publisher;
        my $publisherValue;
        my $editor;
        my $editorValue;
        my $series;
        my $seriesValue;
        my $address;
        my $addressValue;
        my $edition;
        my $editionValue;
        my $chapter;
        my $chapterValue;
        my $type;
        my $typeValue;
        my $school;
        my $schoolValue;
        my $organisation;
        my $organisationValue;
        my $booktitle;
        my $booktitleValue;
        my $crossref;
        my $crossrefValue;
        my $howpub;
        my $howpubValue;
        my $institution;
        my $institutionValue;
        my $keywords;
        my $keywordsValue;
        if ( $field eq 'author' ) {
            $author      = $field;
            $authorValue = $fieldValue;
        }
        elsif ( $field eq 'title' ) {
            $title      = $field;
            $titleValue = $fieldValue;
        }
        elsif ( $field eq 'journal' ) {
            $journal      = $field;
            $journalValue = $fieldValue;
        }
        elsif ( $field eq 'year' ) {
            $year      = $field;
            $yearValue = $fieldValue;
        }
        elsif ( $field eq 'volume' ) {
            $volume      = $field;
            $volumeValue = $fieldValue;
        }
        elsif ( $field eq 'number' ) {
            $number      = $field;
            $numberValue = $fieldValue;
        }
        elsif ( $field eq 'month' ) {
            $month      = $field;
            $monthValue = $fieldValue;
        }
        elsif ( $field eq 'pages' ) {
            $pages      = $field;
            $pagesValue = $fieldValue;
        }
        elsif ( $field eq 'note' ) {
            $ref      = $field;
            $refValue = $fieldValue;
        }
        elsif ( $field eq 'publisher' ) {
            $publisher      = $field;
            $publisherValue = $fieldValue;
        }
        elsif ( $field eq 'editor' ) {
            $editor      = $field;
            $editorValue = $fieldValue;
        }
        elsif ( $field eq 'series' ) {
            $series      = $field;
            $seriesValue = $fieldValue;
        }
        elsif ( $field eq 'address' ) {
            $address      = $field;
            $addressValue = $fieldValue;
        }
        elsif ( $field eq 'edition' ) {
            $edition      = $field;
            $editionValue = $fieldValue;
        }
        elsif ( $field eq 'chapter' ) {
            $chapter      = $field;
            $chapterValue = $fieldValue;
        }
        elsif ( $field eq 'type' ) {
            $type      = $field;
            $typeValue = $fieldValue;
        }
        elsif ( $field eq 'school' ) {
            $school      = $field;
            $schoolValue = $fieldValue;
        }
        elsif ( $field eq 'organization' ) {
            $organisation      = $field;
            $organisationValue = $fieldValue;
        }
        elsif ( $field eq 'booktitle' ) {
            $booktitle      = $field;
            $booktitleValue = $fieldValue;
        }
        elsif ( $field eq 'crossref' ) {
            $crossref      = $field;
            $crossrefValue = $fieldValue;
        }
        elsif ( $field eq 'howpublished' ) {
            $howpub      = $field;
            $howpubValue = $fieldValue;
        }
        elsif ( $field eq 'institution' ) {
            $institution      = $field;
            $institutionValue = $fieldValue;
        }
        elsif ( $field eq 'keywords' ) {
            $keywords      = $field;
            $keywordsValue = $fieldValue;
        }

        if ( $lineStr =~ m/^[}]/ ) {

            print( bibAltDBFile "$bibkey",    #0
                "\@$entry",                   #1
                "\@$authorValue",             #2
                "\@$titleValue",              #3
                "\@$journalValue",            #4
                "\@$yearValue",               #5
                "\@$volumeValue",             #6
                "\@$numberValue",             #7
                "\@$monthValue",              #8
                "\@$pagesValue",              #9
                "\@$refValue",                #10
                "\@$publisherValue",          #11
                "\@$editorValue",             #12
                "\@$seriesValue",             #13
                "\@$addressValue",            #14
                "\@$editionValue",            #15
                "\@$chapterValue",            #16
                "\@$typeValue",               #17
                "\@$schoolValue",             #18
                "\@$organisationValue",       #19
                "\@$booktitleValue",          #20
                "\@$crossrefValue",           #21
                "\@$howpubValue",             #22
                "\@$institutionValue",        #23
                "\@$keywordsValue",           #24
                "\@\n"
            );

            $bibkey            = '';
            $entry             = '';
            $authorValue       = '';
            $titleValue        = '';
            $journalValue      = '';
            $yearValue         = '';
            $volumeValue       = '';
            $numberValue       = '';
            $monthValue        = '';
            $pagesValue        = '';
            $refValue          = '';
            $publisherValue    = '';
            $editorValue       = '';
            $seriesValue       = '';
            $addressValue      = '';
            $editionValue      = '';
            $chapterValue      = '';
            $typeValue         = '';
            $schoolValue       = '';
            $organisationValue = '';
            $booktitleValue    = '';
            $crossrefValue     = '';
            $howpubValue       = '';
            $institutionValue  = '';
            $keywordsValue     = '';

        }

        my $pcThru = 100. * $lineNum / $numLines;
        my $rem = $comp - ( $pcThru / 10. );
        if ( $rem < 0.0000000001 ) {
            printf( "%d%s completed\n", $pcThru, '%' );
            $comp++;
        }

        $lineNum++;

    }

    close($bibAltDBFile);

    print("done\n");

}
1;

# vim: expandtab shiftwidth=4:
