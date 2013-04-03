#!/usr/local/bin/perl

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

$bibErrMsg = "field is required for BibTeX\n\n";

if ( $^O eq "linux" || $^O eq "dec_osf" ) {
    $settingsFname = "bibase.settings";
    print "This is bibase version 1.0 on $^O\n\n";
}
elsif ( $^O eq "MacOS" ) {
    $settingsFname = "bibase.settings";
    print "This is bibase version 1.0 on $^O\n\n";
}
else {
    $settingsFname = "bibase.settings";
}

open( setFH, "< $settingsFname" ) || die $!;
$numLines = 0;
while (<setFH>) {
    @settingsArray[$numLines] = $_;
    $numLines++;
}
close(setFH);

$settingsFileLen = @settingsArray;
for ( $i = 0 ; $i < $settingsFileLen ; $i++ ) {
    @line = split( '=', @settingsArray[$i] );
    $dbpathMatch  = grep( /dbfilepath/i,  @line );
    $bibfileMatch = grep( /bibfilename/i, @line );
    $dbfileMatch  = grep( /dbfilename/i,  @line );

    if ( $dbpathMatch != 0 ) {
        $dbfilepath = @line[1];
        $dbfilepath =~ s/ //g;
        chop($dbfilepath);
    }
    elsif ( $bibfileMatch != 0 ) {
        $bibFname = @line[1];
        $bibFname =~ s/ //g;
        chop($bibFname);
    }
    elsif ( $dbfileMatch != 0 ) {
        $dbFname = @line[1];
        $dbFname =~ s/ //g;
        chop($dbFname);
    }

}

$DBFile    = join( '', $dbfilepath, $bibFname );
$altDBFile = join( '', $dbfilepath, $dbFname );

require "mainMenu.pl";
require "lookup.pl";
require "add.pl";
require "addThesis.pl";
require "addUnpublished.pl";
require "addBook.pl";
require "addArticle.pl";
require "addInProc.pl";
require "addMisc.pl";
require "addProc.pl";
require "addInBook.pl";
require "addInColl.pl";
require "addManual.pl";
require "addTechReport.pl";
require "addBooklet.pl";
require "sortDB.pl";
require "cleanup.pl";
require "bibCompile.pl";
require "sortAndCompCheck.pl";
require "startup.pl";
require "bibkeyMake.pl";
require "titleCheck.pl";
require "dotBibWrite.pl";
require "searchAll.pl";
require "searchAuthor.pl";
require "searchBibkey.pl";
require "searchEntry.pl";
require "searchJournal.pl";
require "searchKeywords.pl";
require "searchTitle.pl";
require "searchYear.pl";
require "printSearchResults.pl";
require "prettyPrintSearchResults.pl";
require "remove.pl";
require "removeEntry.pl";
require "edit.pl";
require "editEntry.pl";
require "printAllFields.pl";
require "printToEdit.pl";
require "editField.pl";
require "entriesFoundDecide.pl";
require "editingEntry.pl";

&startup;
&mainMenu;

# vim: expandtab shiftwidth=4:
