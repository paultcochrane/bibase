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

sub addProc {

    my $config = shift;

    open my $bibFile,   ">>", $config->bibFname or die "$!";
    open my $bibInFile, "<", $config->bibFname  or die "$!";
    print("Choosing to add and a conference proceedings\n\n");

    my $title;
    print("Title: ");
    chop( $title = <> );

    if ( $title eq "" ) {
        print "Title $main::bibErrMsg";
        add( $config )
    }

    my $year;
    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year $main::bibErrMsg";
        add( $config )
    }

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

    my $publisher;
    print("Publisher: ");
    chop( $publisher = <> );

    my $organisation;
    print("Organisation: ");
    chop( $organisation = <> );

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
        add( $config )
    }

    my $dummy = $editor;
    $dummy =~ s/\sand[\w\W]*//;
    my $dummyOld = "zzzzzzzz";
    while ( $dummyOld ne $dummy ) {
        $dummyOld = $dummy;
        $dummy =~ s/[^\s]\S*\s//;
    }

    my $NumLines = 0;
    my @InArray;
    while (<$bibInFile>) {
        $InArray[$NumLines] = $_;
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
            add( $config )
        }
        else {
            print "something weird happened\n";
        }
    }

    my $count = grep( /\{$dummy:$year/i, @InArray );
    $count++;

    my $bibkey = join( ":", $dummy, $year, $count );

    print( $bibFile "\@Proceedings{$bibkey,\n" );
    print( $bibFile "title = {$title},\n" );
    print( $bibFile "year = {$year},\n" );

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
    if ( $publisher ne "" ) {
        print( $bibFile "publisher = {$publisher},\n" );
    }
    if ( $organisation ne "" ) {
        print( $bibFile "organization = {$organisation},\n" );
    }
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

    # @Proceedings{,
    #   title =      {},
    #   year =      {},
    #   OPTkey =      {},
    #   OPTeditor =      {},
    #   OPTvolume =      {},
    #   OPTnumber =      {},
    #   OPTseries =      {},
    #   OPTpublisher = {},
    #   OPTorganization = {},
    #   OPTaddress =      {},
    #   OPTmonth =      {},
    #   OPTnote =      {},
    #   OPTannote =      {}
    # }

    add( $config )

}
1;

# vim: expandtab shiftwidth=4:
