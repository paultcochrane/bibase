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

sub addUnpublished {

    local (
        $title,   $author,   $ref,    $year,     $keywords,
        $dummy,   $dummyOld, $answer, $NumLines, $bibInFile,
        @InArray, $checkNum, $count,  $bibkey,   $bibFile
    );

    open( bibFile,   ">> $DBFile" ) or die "$!";
    open( bibInFile, "< $DBFile" )  or die "$!";
    print("Choosing to add an unpublished work\n\n");

    print("Title: ");
    chop( $title = <> );

    if ( $title eq "" ) {
        print "Title $bibErrMsg";
        &add;
    }

    print("Author(s): ");
    chop( $author = <> );

    if ( $author eq "" ) {
        print "Author $bibErrMsg";
        &add;
    }

    print("Reference (eg: quant-ph/): ");
    chop( $ref = <> );

    if ( $ref eq "" ) {
        print "Reference $bibErrMsg";
        &add;
    }

    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year needed for proper referencing\n";
        &add;
    }

    print("Keywords: ");
    chop( $keywords = <> );

    if ( $keywords eq "" ) {
        print "you need to add a keyword or keywords";
        &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ) {
        $dummyOld = $dummy;
        $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while (<bibInFile>) {
        @InArray[$NumLines] = $_;
        $NumLines++;
    }

    $checkNum = grep( /\{$title\}/, @InArray );

    if ( $checkNum > 0 ) {
        print "This title already exists in database\n";
        print "Add anyway? (y/n) ";
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

    $count = grep( /\{$dummy:$year/i, @InArray );
    $count++;

    $bibkey = join( ":", $dummy, $year, $count );

    print( bibFile "\@Unpublished{$bibkey,\n" );
    print( bibFile "author = {$author},\n" );
    print( bibFile "title = {$title},\n" );
    print( bibFile "note = {$ref},\n" );
    print( bibFile "year = {$year},\n" );
    print( bibFile "keywords = {$keywords}\n" );
    print( bibFile "}\n\n" );

    close(bibFile);
    close(bibInFile);

    # @Unpublished{,
    #   author =      {},
    #   title =      {},
    #   note =      {},
    #   OPTkey =      {},
    #   OPTyear =      {},
    #   OPTmonth =      {},
    #   OPTannote =      {}
    # }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
