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

sub addInProc {

    open( my $bibFile,   ">> $main::DBFile" ) or die "$!";
    open( my $bibInFile, "< $main::DBFile" )  or die "$!";
    print("Choosing to add an article in a conference proceedings\n\n");

    my $title;
    print("Title: ");
    chop( $title = <> );

    if ( $title eq "" ) {
        print "Title $main::bibErrMsg";
        &add;
    }

    my $author;
    print("Author(s): ");
    chop( $author = <> );

    if ( $author eq "" ) {
        print "Author $main::bibErrMsg";
        &add;
    }

    my $booktitle;
    print("Booktitle: ");
    chop( $booktitle = <> );

    if ( $booktitle eq "" ) {
        print "Booktitle $main::bibErrMsg";
        &add;
    }

    my $year;
    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year is required for proper referencing";
        &add;
    }

    my $crossref;
    print("Cross reference: ");
    chop( $crossref = <> );

    my $editor;
    print("Editor: ");
    chop( $editor = <> );

    my $volume;
    print("Volume: ");
    chop( $volume = <> );

    my $number;
    print("Number: ");
    chop( $number = <> );

    my $series;
    print("Series: ");
    chop( $series = <> );

    my $organisation;
    print("Organisation: ");
    chop( $organisation = <> );

    my $publisher;
    print("Publisher: ");
    chop( $publisher = <> );

    my $address;
    print("Address: ");
    chop( $address = <> );

    my $month;
    print("Month: ");
    chop( $month = <> );

    my $page;
    print("Page: ");
    chop( $page = <> );

    my $keywords;
    print("Keywords: ");
    chop( $keywords = <> );

    if ( $keywords eq "" ) {
        print "you need to add a keyword or keywords";
        &add;
    }

    my $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    my $dummyOld = "zzzzzzzz";
    while ( $dummyOld ne $dummy ) {
        $dummyOld = $dummy;
        $dummy =~ s/[^\s]\S*\s//;
    }

    my $NumLines = 0;
    my @InArray;
    while (<$bibInFile>) {
        @InArray[$NumLines] = $_;
        $NumLines++;
    }

    my $checkNum = grep( /\{$title\}/, @InArray );

    if ( $checkNum > 0 ) {
        print "This title already exists in database\n";
        print "Add anyway? (y/n) ";
        my $answer;
        chop( $answer = <> );
        if ( $answer eq "y" ) {
        }
        elsif ( $answer eq "n" ) {
            &add;
        }
        else {
            print "something weird happened\n";
        }
    }

    my $count = grep( /\{$dummy:$year/i, @InArray );
    $count++;

    my $bibkey = join( ":", $dummy, $year, $count );

    print( $bibFile "\@InProceedings{$bibkey,\n" );
    print( $bibFile "author = {$author},\n" );
    print( $bibFile "title = {$title},\n" );
    print( $bibFile "booktitle = {$booktitle},\n" );

    if ( $crossref ne "" ) {
        print( $bibFile "crossref = {$crossref},\n" );
    }

    if ( $editor ne "" ) {
        print( $bibFile "editor = {$editor},\n" );
    }

    if ( $volume ne "" ) {
        print( $bibFile "volume = {$volume},\n" );
    }

    if ( $number ne "" ) {
        print( $bibFile "number = {$number},\n" );
    }

    if ( $series ne "" ) {
        print( $bibFile "series = {$series},\n" );
    }

    if ( $year ne "" ) {
        print( $bibFile "year = {$year},\n" );
    }

    if ( $organisation ne "" ) {
        print( $bibFile "organization = {$organisation},\n" );
    }

    if ( $publisher ne "" ) {
        print( $bibFile "publisher = {$publisher},\n" );
    }

    if ( $address ne "" ) {
        print( $bibFile "address = {$address},\n" );
    }

    if ( $month ne "" ) {
        print( $bibFile "month = {$month},\n" );
    }

    if ( $page ne "" ) {
        print( $bibFile "page = {$page},\n" );
    }

    print( $bibFile "keywords = {$keywords}\n" );
    print( $bibFile "}\n\n" );

    close($bibFile);
    close($bibInFile);

    # @InProceedings{,
    #   author =      {},
    #   title =      {},
    #   booktitle =      {},
    #   OPTcrossref =  {},
    #   OPTkey =      {},
    #   OPTeditor =      {},
    #   OPTvolume =      {},
    #   OPTnumber =      {},
    #   OPTseries =      {},
    #   OPTyear =      {},
    #   OPTorganization = {},
    #   OPTpublisher = {},
    #   OPTaddress =      {},
    #   OPTmonth =      {},
    #   OPTpages =      {},
    #   OPTnote =      {},
    #   OPTannote =      {}
    # }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
