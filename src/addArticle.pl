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

sub addArticle {

    open my $bibFile,   ">>", $main::DBFile or die "$!";
    open my $bibInFile, "<", $main::DBFile  or die "$!";
    print("Choosing to add and a journal article\n\n");

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

    my $journal;
    print("Journal: ");
    chop( $journal = <> );

    if ( $journal eq "" ) {
        print "Journal $main::bibErrMsg";
        &add;
    }

    my $year;
    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year $main::bibErrMsg";
        &add;
    }

    my $volume;
    print("Volume: ");
    chop( $volume = <> );

    my $number;
    print("Number: ");
    chop( $number = <> );

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

    &bibkeyMake($author, $year, $bibInFile);

    &titleCheck($title);

    my $bibkey;
    print( $bibFile "\@Article{$bibkey,\n" );
    print( $bibFile "author = {$author},\n" );
    print( $bibFile "title = {$title},\n" );
    print( $bibFile "journal = {$journal},\n" );
    print( $bibFile "year = {$year},\n" );

    if ( $volume ne "" ) {
        print( $bibFile "volume = {$volume},\n" );
    }
    if ( $number ne "" ) {
        print( $bibFile "number = {$number},\n" );
    }
    if ( $month ne "" ) {
        print( $bibFile "month = {$month},\n" );
    }
    if ( $page ne "" ) {
        print( $bibFile "pages = {$page},\n" );
    }
    print( $bibFile "keywords = {$keywords}\n" );
    print( $bibFile "}\n\n" );

    close($bibFile);
    close($bibInFile);

    # @Article{,
    #   author =      {},
    #   title =      {},
    #   journal =      {},
    #   year =      {},
    #   OPTkey =      {},
    #   OPTvolume =      {},
    #   OPTnumber =      {},
    #   OPTmonth =      {},
    #   OPTpages =      {},
    #   OPTnote =      {},
    #   OPTannote =      {}
    # }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
