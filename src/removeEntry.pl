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

sub removeEntry {

    print("\n$grepCount entries found\n\n");

    $i      = 0;
    $answer = '';
    while ($answer eq 'n'
        || $answer eq 'N'
        || $answer eq ''
        || $i < $grepCount )
    {
        $num = $i + 1;
        print("printing entry $num of $grepCount\n");
        &prettyPrintSearchResults;
        print("\nremove this entry? (y/n/x) ");
        chop( $answer = <> );
        if ( $answer eq 'n' || $answer eq 'N' || $answer eq '' ) {
        }
        elsif ( $answer eq 'y' || $answer eq 'Y' ) {
            splice( @dbInArray, @indArray[$i], 1 );
            @newDBArray = @dbInArray;
            print "removing entry...\n";
            &dotBibWrite;
            &bibCompile;
            &mainMenu;
        }
        elsif ($answer eq 'x'
            || $answer eq 'X'
            || $answer eq 'q'
            || $answer eq 'Q'
            || $answer eq 'm'
            || $answer eq 'M' )
        {
            &mainMenu;
        }
        else {
            print "whoops, something weird happened in removeEntry\n";
            &mainMenu;
        }
        $i++;
    }

}
1;

# vim: expandtab shiftwidth=4:
