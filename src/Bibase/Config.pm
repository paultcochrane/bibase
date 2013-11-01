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

package Bibase::Config;

use warnings;
use strict;

use Moose;

has 'bibFname' => (
    is => 'rw',
    isa => 'Str',
);

=item read_settings

Read in the configuration file and set the relevant config variables.

=cut

sub read_settings {

    my ( $self, $settingsFname ) = @_;

    $settingsFname = "bibase.settings" if not $settingsFname;
    open my $setFH, "<", $settingsFname or die $!;
    my @settingsArray = <$setFH>;
    close $setFH;
    chomp @settingsArray;

    my $dbfilepath;
    my $dbFname;
    my $bibFname;
    for my $line ( @settingsArray ) {
        my @lineData = split( '=', $line );

        if ( grep /dbfilepath/i,  @lineData ) {
            $dbfilepath = $lineData[1] ? $lineData[1] : '';
            $dbfilepath =~ s/\s+//g;
        }
        elsif ( grep /bibfilename/i, @lineData ) {
            $bibFname = $lineData[1] ? $lineData[1] : '';
            $bibFname =~ s/\s+//g;
        }
        elsif ( grep /dbfilename/i,  @lineData ) {
            $dbFname = $lineData[1] ? $lineData[1] : '';
            $dbFname =~ s/\s+//g;
        }
    }

    $self->bibFname( $bibFname ? join( '', $dbfilepath, $bibFname ) : "bibase.bib" );
    $main::altDBFile = $dbFname ? join( '', $dbfilepath, $dbFname ) : "bibase.db";

}

1;

# vim: expandtab shiftwidth=4:
