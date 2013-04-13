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

sub bibkeyMake {

    my $author = shift;
    my $year = shift;
    my $bibInFile = shift;

    my $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;    # deletes everything after first 'and'
    my $dummyOld = "zzzzzzzz";
    while ( $dummyOld ne $dummy ) {
        $dummyOld = $dummy;
        $dummy =~
          s/[^\s]\S*\s//;    # deletes all characters in front of first surname
    }

    my $NumLines = 0;
    my @InArray;
    while (<$bibInFile>) {
        $InArray[$NumLines] = $_;
        $NumLines++;
    }

    my $count = grep( /\{$dummy:$year/i, @InArray );
    $count++;

    my $bibkey = join( ":", $dummy, $year, $count );

}
1;

# vim: expandtab shiftwidth=4:
