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

package Bibase;

use warnings;
use strict;

use Moose;

=item init_db_files

Create the default BibTeX and database files if they do not already exist.

=cut

sub init_db_files {

    if ( not -e $main::DBFile ) {
        open my $startHandle, ">", $main::DBFile;
        print("opening new file $main::DBFile\n");
        close $startHandle;
    }

    if ( not -e $main::altDBFile ) {
        open my $startHandle, ">", $main::altDBFile;
        print("opening new file $main::altDBFile\n");
        close $startHandle;
    }

}

=item read_settings

Read in the configuration file and set the relevant config variables.

=cut

sub read_settings {

    my ( $self, $settingsFname ) = @_;

    $settingsFname = "bibase.settings" if not $settingsFname;
    open my $setFH, "<", $settingsFname or die $!;
    my @settingsArray = <$setFH>;
    close $setFH;

    my $dbfilepath;
    my $dbFname;
    my $bibFname;
    for my $line ( @settingsArray ) {
        my @lineData = split( '=', $line );

        if ( grep /dbfilepath/i,  @lineData ) {
            $dbfilepath = $lineData[1];
            $dbfilepath =~ s/\s+//g;
            chomp $dbfilepath;
        }
        elsif ( grep /bibfilename/i, @lineData ) {
            $bibFname = $lineData[1];
            $bibFname =~ s/\s+//g;
            chomp $bibFname;
        }
        elsif ( grep /dbfilename/i,  @lineData ) {
            $dbFname = $lineData[1];
            $dbFname =~ s/\s+//g;
            chomp $dbFname;
        }
    }

    $main::DBFile    = $bibFname ? join( '', $dbfilepath, $bibFname ) : "bibase.bib" ;
    $main::altDBFile = $dbFname ? join( '', $dbfilepath, $dbFname ) : "bibase.db";

}

1;

# vim: expandtab shiftwidth=4:
