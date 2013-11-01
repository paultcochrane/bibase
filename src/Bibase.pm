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

    my ( $self, $config ) = @_;

    if ( not -e $config->bibFname ) {
        open my $startHandle, ">", $config->bibFname;
        print "opening new file ", $config->bibFname, "\n";
        close $startHandle;
    }

    if ( not -e $config->dbFname ) {
        open my $startHandle, ">", $config->dbFname;
        print "opening new file ", $config->dbFname, "\n";
        close $startHandle;
    }

}

=item mainMenu

Show the main menu of the application.

=cut

sub mainMenu {

    use IO::Prompt;

    my ( $self, $config ) = @_;

    print("\n\n");
    print("Would you like to:\n\n");
    print("(S)earch for an entry\n");
    print("(A)dd an entry\n");
    print("(R)emove an entry\n");
    print("(E)dit an entry\n");
    print("E(x)it\n\n");

    my $answer = prompt "Please choose an option: ";

    if ( $answer =~ m/(l|s)/i ) {
        main::lookup( $config );
    }
    elsif ( $answer =~ m/a/i ) {
        main::add( $config );
    }
    elsif ( $answer =~ m/r/i ) {
        main::remove( $config );
    }
    elsif ( $answer =~ m/(c|e)/i ) {
        main::edit( $config );
    }
    elsif ( $answer =~ m/(x|q)/i ) {
        main::sortAndCompCheck( $config );
        exit(0);
    }
    else {
        print("woah, something weird must have happened\n");
        $self->mainMenu( $config );
    }

}

1;

# vim: expandtab shiftwidth=4:
