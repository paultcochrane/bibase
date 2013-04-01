#!/usr/local/bin/perl

use DB_File;

$bibErrMsg = "field is required for BibTeX\n\n";

if ($^O eq "linux" || $^O eq "dec_osf") {
	$settingsFname = "bibase.settings";
	print "This is bibase version 1.0 on $^O\n\n";
}
elsif ($^O eq "MacOS") {
	$settingsFname = "bibase.settings";
	print "This is bibase version 1.0 on $^O\n\n";
} else {
	$settingsFname = "bibase.settings";
}

open(setFH, "< $settingsFname") || die $!;
$numLines = 0;
while(<setFH>) {
		@settingsArray[$numLines] = $_;
		$numLines++;
	}
close(setFH);

$settingsFileLen = @settingsArray;
for ($i=0; $i<$settingsFileLen; $i++) {
	@line = split('=', @settingsArray[$i]);
	$dbpathMatch = grep(/dbfilepath/i, @line);
	$bibfileMatch = grep(/bibfilename/i, @line);
	$dbfileMatch = grep(/dbfilename/i, @line);
	
	if ($dbpathMatch != 0) {
		$dbfilepath = @line[1];
		$dbfilepath =~ s/ //g;
		chop($dbfilepath);
	}
	elsif ($bibfileMatch != 0) {
		$bibFname = @line[1];
		$bibFname =~ s/ //g;
		chop($bibFname);
	}
	elsif ($dbfileMatch != 0) {
		$dbFname = @line[1];
		$dbFname =~ s/ //g;
		chop($dbFname);
	}
	
}

$DBFile = join('',$dbfilepath,$bibFname);
$altDBFile = join('',$dbfilepath,$dbFname);

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
