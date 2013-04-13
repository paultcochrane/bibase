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

sub addBooklet {

    open( my $bibFile,   ">> $main::DBFile" ) or die "$!";
    open( my $bibInFile, "< $main::DBFile" )  or die "$!";
    print("Choosing to add a booklet\n\n");

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

    my $year;
    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year $main::bibErrMsg";
        &add;
    }

    my $howpub;
    print("How published: ");
    chop( $howpub = <> );

    my $address;
    print("Address: ");
    chop( $address = <> );

    my $month;
    print("Month: ");
    chop( $month = <> );

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

    print( $bibFile "\@Booklet{$bibkey,\n" );
    print( $bibFile "author = {$author},\n" );
    print( $bibFile "title = {$title},\n" );
    print( $bibFile "howpublished = {$howpub},\n" );
    print( $bibFile "year = {$year},\n" );

    if ( $address ne "" ) {
        print( $bibFile "address = {$address},\n" );
    }
    if ( $month ne "" ) {
        print( $bibFile "month = {$month},\n" );
    }
    print( $bibFile "keywords = {$keywords}\n" );
    print( $bibFile "}\n\n" );

    close($bibFile);
    close($bibInFile);

    # @Booklet{,
    #   title =      {},
    #   OPTkey =      {},
    #   OPTauthor =      {},
    #   OPThowpublished = {},
    #   OPTaddress =      {},
    #   OPTmonth =      {},
    #   OPTyear =      {},
    #   OPTnote =      {},
    #   OPTannote =      {}
    # }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
