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

sub prettyPrintSearchResults {

    my $entryLine = shift;

    my @paper = split( '@', $entryLine );

    print "\n";
    print
"----------------------------------------------------------------------\n";
    print "Title: \t\t$paper[3]\n";
    print "Author: \t$paper[2]\n";
    print "Journal: \t$paper[4]\n";
    print "Year: \t\t$paper[5]\n";
    print "Volume: \t$paper[6]\n";

    #      print "Number: \t$paper[7]\n";
    #      print "Month: \t$paper[8]\n";
    print "Page: \t\t$paper[9]\n";
    print "Ref: \t\t$paper[10]\n";
    print "Keywords: \t$paper[24]\n";
    print "Bibkey: \t$paper[0]\n";
    print "Kind: \t\t$paper[1]\n";

    #      print "Publisher: $paper[11]\n";
    #      print "Editor: $paper[12]\n";
    #      print "Series: $paper[13]\n";
    #      print "Address: $paper[14]\n";
    #      print "Edition: $paper[15]\n";
    #      print "Chapter: $paper[16]\n";
    #      print "Type: $paper[17]\n";
    #      print "School: $paper[18]\n";
    #      print "Organisation: $paper[19]\n";
    #      print "Booktitle: $paper[20]\n";
    #      print "Crossref: $paper[21]\n";
    #      print "Howpub: $paper[22]\n";
    #   print "Institution: $paper[23]\n";
    print
      "----------------------------------------------------------------------";
    print "\n";

}
1;

# vim: expandtab shiftwidth=4:
