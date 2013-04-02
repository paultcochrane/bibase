#!/usr/local/bin/perl

$bibErrMsg = "field is required for BibTeX\n\n";

if ($^O eq "linux" || $^O eq "dec_osf") {
    $HOME = $ENV{'HOME'};
    $settingsFname = "$HOME/.bibase.settings";
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



&startup;
&mainMenu;

sub mainMenu{

    print("\n\n");
    print("Would you like to:\n\n");
    print("(S)earch for an entry\n");
    print("(A)dd an entry\n");
    print("(R)emove an entry\n");
    print("(E)dit an entry\n");
    print("E(x)it\n\n");

    print("Please choose an option: ");
    chop($answer = <>);

    if($answer eq 'l' || $answer eq 'L' || $answer eq 's' || $answer eq 'S')
    {
        &lookup;
    }
    elsif($answer eq 'a' || $answer eq 'A')
    {
        &add;
    }
    elsif($answer eq 'r' || $answer eq 'R')
    {
        &remove;
    }
    elsif($answer eq 'c' || $answer eq 'C' || $answer eq 'e' || $answer eq 'E')
    {
        &edit;
    }
    elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q')
    {
        &sortAndCompCheck;
        exit(0);
    }
    else{
        print("woah, something weird must have happened\n");
        &mainMenu;
    }
    
}
1;

sub lookup{

    local ($dbInFile, $answer, @oldgrepArray, $grepCount,
            $i, @paper);

            
    $searchFlag = 1;
    $removeFlag = 0;
    $editFlag = 0;
    
    &sortAndCompCheck;
    
    @dbInArray = '';
    @titleArray = '';
    @authorArray = '';
    @entryArray = '';
    @bibkeyArray = '';
    @journalArray = '';
    @yearArray = '';
    @keywordsArray = '';
    @grepArray = '';

    open(dbInFile,"< $altDBFile");

    $dbNumLines = 0;
    while ( <dbInFile> ){
    @dbInArray [$dbNumLines] = $_;
    @lineArray = split('@',@dbInArray[$dbNumLines]);
    @titleArray[$dbNumLines] = @lineArray[3];
    @authorArray[$dbNumLines] = @lineArray[2];
    @entryArray[$dbNumLines] = @lineArray[1];
    @bibkeyArray[$dbNumLines] = @lineArray[0];
    @journalArray[$dbNumLines] = @lineArray[4];
    @yearArray[$dbNumLines] = @lineArray[5];
    @keywordsArray[$dbNumLines] = @lineArray[24];
    
    $dbNumLines++;
    }
    
    close(dbInFile);

    print "\nPossible search areas are:\n\n";
    
    print "(A)ll fields\n";
    print "(T)itle field only\n";
    print "(Au)thor field only\n";
    print "(K)eywords field only\n";
    print "(Y)ear field only\n";
    print "(J)ournal field only\n";
    print "(E)ntry type field only\n";
    print "(B)ibliography key field only\n";
    print "Return to (m)ain menu\n";
    print "\n";
    print "Enter an area within which to search: ";
    
    chop($answer = <>);

    print "\n";
    
    if ($answer eq '') {
        print "Please make a selection\n";
        &lookup;
    }
    elsif ($answer eq 'A' || $answer eq 'a') {
        &searchAll;
    }
    elsif ($answer eq 'T' || $answer eq 't') {
        &searchTitle;
    }
    elsif ($answer eq 'Au' || $answer eq 'au' || $answer eq 'AU' || $answer eq 'aU') {
        &searchAuthor;
    }
    elsif ($answer eq 'K' || $answer eq 'k') {
        &searchKeywords;
    }
    elsif ($answer eq 'Y' || $answer eq 'y') {
        &searchYear;
    }
    elsif ($answer eq 'J' || $answer eq 'j') {
        &searchJournal;
    }
    elsif ($answer eq 'E' || $answer eq 'e') {
        &searchEntry;
    }
    elsif ($answer eq 'B' || $answer eq 'b') {
        &searchBibkey;
    }
    elsif ($answer eq 'm' || $answer eq 'M') {
        &mainMenu;
    } else {
        print "something went wrong in lookup.pl\n";
        &lookup;
    }
    

    &mainMenu;
}
1;

sub add{

    local ($answer);

    print("\n\nDo you want to add:\n\n");
    print("A journal (a)rticle\n");
    print("A (b)ook\n");
    print("An (u)npublished work\n");
    print("An article in a conference (p)roceedings\n");
    print("A (t)hesis\n");
    print("A (c)onference proceedings\n");
    print("A page or chapter (i)n a book\n");
    print("A (misc)ellaneous article\n");
    print("An article in a c(o)llection\n");
    print("A (booklet)\n");
    print("A (man)ual\n");
    print("A (tech)nical report\n");
    print("The (m)ain menu\n");
    print("E(x)it\n\n");
    
    print("Choose an option: ");
    chop($answer = <>);

    # clear any variables to stop corruption of .db database file
    &cleanup;

    if($answer eq 'a'){
    &addArticle;}
    elsif($answer eq 'b'){
    &addBook;}
    elsif($answer eq 'u'){
    &addUnpublished;}
    elsif($answer eq 'p'){
    &addInProc;}
    elsif($answer eq 't'){
    &addThesis;}
    elsif($answer eq 'c'){
    &addProc;}
    elsif($answer eq 'i'){
    &addInBook;}
    elsif($answer eq 'misc'){
    &addMisc;}
    elsif($answer eq 'o'){
    &addInColl;}
    elsif($answer eq 'booklet'){
    &addBooklet;}
    elsif($answer eq 'man'){
    &addManual;}
    elsif($answer eq 'tech'){
    &addTechReport;}
    elsif($answer eq 'm'){
    &mainMenu;}
    elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q'){
    &sortAndCompCheck;
    exit(0);
    }
    else{print("woah, something weird happened\n");
     exit(1);}
    
}
1;

sub addThesis{

    local ($bibFile, $bibInFile, $title, $author, $school, $year, $address, 
            $type, $month, $keywords, $dummy, $dummyOld, $NumLines, @InArray,
            $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add a thesis\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author: ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("University: ");
    chop($school = <>);

    if ( $school eq "" ){
    print "University $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Address: ");
    chop($address = <>);

    print("Type: ");
    chop($type = <>);

    print("Month: ");
    chop($month = <>);
 
    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }

    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@PhdThesis{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "school = {$school},\n");
    print(bibFile "year = {$year},\n");
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $type ne "" ){
    print(bibFile "type = {$type},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @PhdThesis{,
#   author =      {},
#   title =      {},
#   school =      {},
#   year =      {},
#   OPTkey =      {},
#   OPTaddress =      {},
#   OPTtype =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addUnpublished{

    local ($title, $author, $ref, $year, $keywords, $dummy, $dummyOld, $answer,
        $NumLines, $bibInFile, @InArray, $checkNum, $count, $bibkey, $bibFile);    

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add an unpublished work\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }
    
    print("Reference (eg: quant-ph/): ");
    chop($ref = <>);

    if ( $ref eq "" ){
    print "Reference $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);
    
    if ( $year eq "" ){
    print "Year needed for proper referencing\n";
    &add;
    }

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Unpublished{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "note = {$ref},\n");
    print(bibFile "year = {$year},\n");
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

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

sub addBook{

    local ($bibFile, $bibInFile, $title, $authro, $publisher, $year, $editor, 
            $volume, $number, $series, $address, $edition, $month, $keywords,
            $dummy, $dummyOld, $NumLines, @InArray, $checkNum, $answer, $count,
            $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add a book\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Publisher: ");
    chop($publisher = <>);

    if ( $publisher eq "" ){
    print "Publisher $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Editor: ");
    chop($editor = <>);

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);

    print("Series: ");
    chop($series = <>);

    print("Address: ");
    chop($address = <>);

    print("Edition: ");
    chop($edition = <>);

    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Book{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "publisher = {$publisher},\n");
    print(bibFile "year = {$year},\n");

    if ( $editor ne "" ){
    print(bibFile "editor = {$editor},\n");
    }
    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }
    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $series ne "" ){
    print(bibFile "series = {$series},\n");
    }
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $edition ne "" ){
    print(bibFile "edition = {$edition},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @Book{,
#   author =      {},
#   title =      {},
#   publisher =      {},
#   year =      {},
#   OPTkey =      {},
#   OPTeditor =      {},
#   OPTvolume =      {},
#   OPTnumber =      {},
#   OPTseries =      {},
#   OPTaddress =      {},
#   OPTedition =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addArticle{

    local ($bibFile, $bibInFile, $title, $author, $journal, $year, $volume, 
            $number, $month, $page, $keywords, $dummy, $dummyOld, $NumLines,
            @InArray, $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add and a journal article\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Journal: ");
    chop($journal = <>);

    if ( $journal eq "" ){
    print "Journal $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);

    print("Month: ");
    chop($month = <>);

    print("Page: ");
    chop($page = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    &bibkeyMake($author);
    
    &titleCheck($title);
        
    print(bibFile "\@Article{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "journal = {$journal},\n");
    print(bibFile "year = {$year},\n");

    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }
    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    if ( $page ne "" ){
    print(bibFile "pages = {$page},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

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

sub addInProc{

    local ($bibFile, $bibInFile, $title, $author, $booktitle, $year, $crossref, 
            $editor, $volume, $number, $series, $organisation, $publisher, 
            $address, $month, $page, $keywords, $dummy, $dummyOld, $NumLines,
            @InArray, $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add an article in a conference proceedings\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Booktitle: ");
    chop($booktitle = <>);

    if ( $booktitle eq "" ){
    print "Booktitle $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year is required for proper referencing";
    &add;
    }

    print("Cross reference: ");
    chop($crossref = <>);

    print("Editor: ");
    chop($editor = <>);

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);
    
    print("Series: ");
    chop($series = <>);
    
    print("Organisation: ");
    chop($organisation = <>);

    print("Publisher: ");
    chop($publisher = <>);

    print("Address: ");
    chop($address = <>);

    print("Month: ");
    chop($month = <>);

    print("Page: ");
    chop($page = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@InProceedings{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "booktitle = {$booktitle},\n");

    if ( $crossref ne "" ){
    print(bibFile "crossref = {$crossref},\n");
    }

    if ( $editor ne "" ){
    print(bibFile "editor = {$editor},\n");
    }

    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }

    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }

    if ( $series ne "" ){
    print(bibFile "series = {$series},\n");
    }

    if ( $year ne "" ){
    print(bibFile "year = {$year},\n");
    }

    if ( $organisation ne "" ){
    print(bibFile "organization = {$organisation},\n");
    }

    if ( $publisher ne "" ){
    print(bibFile "publisher = {$publisher},\n");
    }

    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }

    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }

    if ( $page ne "" ){
    print(bibFile "page = {$page},\n");
    }

    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @InProceedings{,
#   author =      {},
#   title =      {},
#   booktitle =      {},
#   OPTcrossref =  {},
#   OPTkey =      {},
#   OPTeditor =      {},
#   OPTvolume =      {},
#   OPTnumber =      {},
#   OPTseries =      {},
#   OPTyear =      {},
#   OPTorganization = {},
#   OPTpublisher = {},
#   OPTaddress =      {},
#   OPTmonth =      {},
#   OPTpages =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addMisc{

    local ($bibFile, $bibInFile, $title, $author, $howpub, $year, $month, 
            $keywords, $dummy, $dummyOld, $NumLines, @InArray, $checkNum, 
            $answer, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add and a miscellaneous article\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("How published: ");
    chop($howpub = <>);

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Misc{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "year = {$year},\n");

    if ( $volume ne "" ){
    print(bibFile "howpublished = {$howpub},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @Misc{,
#   OPTkey =      {},
#   OPTauthor =      {},
#   OPTtitle =      {},
#   OPThowpublished = {},
#   OPTyear =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addProc{

    local ($bibFile, $bibInFile, $title, $year, $editor, $volume, $number, 
            $series, $publisher, $organisation, $address, $month, $keywords,
            $dummy, $dummyOld, $NumLines, @InArray, $checkNum, $answer, $count,
            $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add and a conference proceedings\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Editor: ");
    chop($editor = <>);

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);

    print("Series: ");
    chop($series = <>);

    print("Publisher: ");
    chop($publisher = <>);

    print("Organisation: ");
    chop($organisation = <>);
    
    print("Address: ");
    chop($address = <> );

    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Proceedings{$bibkey,\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "year = {$year},\n");

    if ( $editor ne "" ){
    print(bibFile "editor = {$editor},\n");
    }
    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }
    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $series ne "" ){
    print(bibFile "series = {$series},\n");
    }
    if ( $publisher ne "" ){
    print(bibFile "publisher = {$publisher},\n");
    }
    if ( $organisation ne "" ){
    print(bibFile "organization = {$organisation},\n");
    }
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @Proceedings{,
#   title =      {},
#   year =      {},
#   OPTkey =      {},
#   OPTeditor =      {},
#   OPTvolume =      {},
#   OPTnumber =      {},
#   OPTseries =      {},
#   OPTpublisher = {},
#   OPTorganization = {},
#   OPTaddress =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addInBook{

    local ($bibFile, $bibInFile, $title, $author, $chapter, $publisher, $year,
            $editor, $volume, $number, $series, $address, $edition, $month, 
            $page, $type, $keywords, $dummy, $dummyOld, $NumLines, @InArray,
            $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add and a page or chaper in a book\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Chapter: ");
    chop($chapter = <>);

    if ( $chapter eq "" ){
    print "Chapter $bibErrMsg";
    &add;
    }

    print("Publisher: ");
    chop($publisher = <>);
    
    if ( $publisher eq "" ){
    print "Publisher $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Editor: ");
    chop($editor = <>);

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);

    print("Series: ");
    chop($series = <>);

    print("Address: ");
    chop($address = <>);

    print("Edition: ");
    chop($edition = <>);

    print("Month: ");
    chop($month = <>);

    print("Page: ");
    chop($page = <>);

    print("Type: ");
    chop($type = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@InBook{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "chapter = {$chapter},\n");
    print(bibFile "publisher = {$publisher},\n");
    print(bibFile "year = {$year},\n");

    if ( $editor ne "" ){
    print(bibFile "editor = {$editor},\n");
    }
    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }
    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $series ne "" ){
    print(bibFile "series = {$series},\n");
    }
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $edition ne "" ){
    print(bibFile "edition = {$edition},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    if ( $page ne "" ){
    print(bibFile "pages = {$page},\n");
    }
    if ( $type ne "" ){
    print(bibFile "type = {$type},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @InBook{,
#   author =      {},
#   title =      {},
#   chapter =      {},
#   publisher =      {},
#   year =      {},
#   OPTkey =      {},
#   OPTeditor =      {},
#   OPTvolume =      {},
#   OPTnumber =      {},
#   OPTseries =      {},
#   OPTaddress =      {},
#   OPTedition =      {},
#   OPTmonth =      {},
#   OPTpages =      {},
#   OPTtype =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }


    &add;

}
1;

sub addInColl{

    local ($bibFile, $bibInFile, $title, $author, $booktitle, $year, $volume, 
            $number, $publisher, $editor, $series, $type, $chapter, $address,
            $edition, $month, $page, $keywords, $dummy, $dummyOld, $NumLines,
            @InArray, $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add an article in a collection\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Book title: ");
    chop($booktitle = <>);

    if ( $booktitle eq "" ){
    print "Book title $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Volume: ");
    chop($volume = <>);

    print("Number: ");
    chop($number = <>);

    print("Publisher: ");
    chop($publisher = <>);
    
    print("Editor: ");
    chop($editor = <>);
    
    print("Series: ");
    chop($series = <>);
    
    print("Type: ");
    chop($type = <>);
    
    print("Chapter: ");
    chop($chapter = <>);
    
    print("Address: ");
    chop($address = <>);

    print("Edition: ");
    chop($edition = <>);
    
    print("Month: ");
    chop($month = <>);

    print("Page: ");
    chop($page = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }


    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@InCollection{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "booktitle = {$booktitle},\n");
    print(bibFile "year = {$year},\n");

    if ( $volume ne "" ){
    print(bibFile "volume = {$volume},\n");
    }
    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $publisher ne "" ){
    print(bibFile "publisher = {$publisher},\n");
    }
    if ( $editor ne "" ){
    print(bibFile "editor = {$editor},\n");
    }
    if ( $series ne "" ){
    print(bibFile "series = {$series},\n");
    }
    if ( $type ne "" ){
    print(bibFile "type = {$type},\n");
    }
    if ( $chapter ne "" ){
    print(bibFile "chapter = {$chapter},\n");
    }
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $edition ne "" ){
    print(bibFile "edition = {$edition},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    if ( $page ne "" ){
    print(bibFile "pages = {$page},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @InCollection{,
#   author =      {},
#   title =      {},
#   booktitle =      {},
#   OPTcrossref =  {},
#   OPTkey =      {},
#   OPTpages =      {},
#   OPTpublisher = {},
#   OPTyear =      {},
#   OPTeditor =      {},
#   OPTvolume =      {},
#   OPTnumber =      {},
#   OPTseries =      {},
#   OPTtype =      {},
#   OPTchapter =      {},
#   OPTaddress =      {},
#   OPTedition =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addManual{

    local ($bibFile, $bibInFile, $title, $author, $organisation, $year, $address,
            $edition, $month, $keywords, $dummy, $dummyOld, $NumLines, @InArray,
            $checkNum, $answer, $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add a manual\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Organisation: ");
    chop($organisation = <>);

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Address: ");
    chop($address = <>);

    print("Edition: ");
    chop($edition = <>);
    
    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }


    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Manual{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "organization = {$organisation},\n");
    print(bibFile "year = {$year},\n");

    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $edition ne "" ){
    print(bibFile "edition = {$edition},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @Manual{,
#   title =      {},
#   OPTkey =      {},
#   OPTauthor =      {},
#   OPTorganization = {},
#   OPTaddress =      {},
#   OPTedition =      {},
#   OPTmonth =      {},
#   OPTyear =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addTechReport{

    local ($bibFile, $bibInFile, $title, $author, $institution, $year, $number,
            $type, $address, $month, $keywords, $dummy, $dummyOld, $NumLines,
            @InArray, $checkNum, $answer, $cound, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add a technical report\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Institution: ");
    chop($institution = <>);

    if ( $institution eq "" ){
    print "Institution $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("Number: ");
    chop($number = <>);

    print("Type: ");
    chop($type = <>);
    
    print("Address: ");
    chop($address = <>);

    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }


    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@TechReport{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "institution = {$institution},\n");
    print(bibFile "year = {$year},\n");

    if ( $number ne "" ){
    print(bibFile "number = {$number},\n");
    }
    if ( $type ne "" ){
    print(bibFile "type = {$type},\n");
    }
    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @TechReport{,
#   author =      {},
#   title =      {},
#   institution =  {},
#   year =      {},
#   OPTkey =      {},
#   OPTtype =      {},
#   OPTnumber =      {},
#   OPTaddress =      {},
#   OPTmonth =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub addInColl{

    local ($bibFile, $bibInFile, $title, $author, $year, $howpub, $address, $month,
            $keywords, $dummy, $dummyOld, $NumLines, @InArray, $checkNum, $answer,
            $count, $bibkey);

    open(bibFile,">> $DBFile") or die "$!";
    open(bibInFile,"< $DBFile") or die "$!";
    print("Choosing to add a booklet\n\n");

    print("Title: ");
    chop($title = <>);

    if ( $title eq "" ){
    print "Title $bibErrMsg";
    &add;
    }

    print("Author(s): ");
    chop($author = <>);

    if ( $author eq "" ){
    print "Author $bibErrMsg";
    &add;
    }

    print("Year: ");
    chop($year = <>);

    if ( $year eq "" ){
    print "Year $bibErrMsg";
    &add;
    }

    print("How published: ");
    chop($howpub = <>);

    print("Address: ");
    chop($address = <>);

    print("Month: ");
    chop($month = <>);

    print("Keywords: ");
    chop($keywords = <>);

    if ( $keywords eq "" ){
    print "you need to add a keyword or keywords";
    &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    $dummyOld = $dummy;
    $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }


    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

    print(bibFile "\@Booklet{$bibkey,\n");
    print(bibFile "author = {$author},\n");
    print(bibFile "title = {$title},\n");
    print(bibFile "howpublished = {$howpub},\n");
    print(bibFile "year = {$year},\n");

    if ( $address ne "" ){
    print(bibFile "address = {$address},\n");
    }
    if ( $month ne "" ){
    print(bibFile "month = {$month},\n");
    }
    if ( $page ne "" ){
    print(bibFile "pages = {$page},\n");
    }
    print(bibFile "keywords = {$keywords}\n");
    print(bibFile "}\n\n");

    close(bibFile);
    close(bibInFile);

# @Booklet{,
#   title =      {},
#   OPTkey =      {},
#   OPTauthor =      {},
#   OPThowpublished = {},
#   OPTaddress =      {},
#   OPTmonth =      {},
#   OPTyear =      {},
#   OPTnote =      {},
#   OPTannote =      {}
# }

    &add;

}
1;

sub sortDB{

    print("Sorting $altDBFile...");

    open(dbInFile, "< $altDBFile");

    @dbInArray = '';
    $dbNumLines = 0;
    while ( <dbInFile> ){
    @dbInArray [$dbNumLines] = $_;
    $dbNumLines++;
    }

    close(dbInFile);

    @newDBArray = sort(@dbInArray);

    open(dbOutFile, "> $altDBFile");

    print(dbOutFile @newDBArray);

    close(dbOutFile);

    print("done\n");
    
    &dotBibWrite;
    
}
1;

sub cleanup{

    # clear variables to stop .db database wrongly adding data
    $bibkey = "";
    $author = "";
    $title = "";
    $journal = "";
    $year = "";
    $volume = "";
    $number = "";
    $month = "";
    $page = "";
    $ref = "";
    $publisher = "";
    $editor = "";
    $series = "";
    $address = "";
    $edition = "";
    $chapter = "";
    $type = "";
    $school = "";
    $organisation = "";
    $booktitle = "";
    $crossref = "";
    $howpub = "";
    $institution = "";
    $keywords = "";

}
1;

sub bibCompile{

print("\nCompiling database file...");
    
open(bibAltDBFile, "> $altDBFile");

open(bibInFile, "< $DBFile");

$numLines = 0;
while( <bibInFile> ) {
    @inArray[$numLines] = $_;
    $numLines++;
}

close(bibInFile);

$numLines = $numLines - 1;
$lineNum = 0;
$comp = 0;
chop(@inArray);

while($lineNum < $numLines) {
    
    $lineStr = '';
    $lineStr = @inArray[$lineNum];
    $lineStr =~ s/^\s*//;
    
    $field = '';
    $fieldValue = '';
        
    if ($lineStr =~ m/^\@/) {
        $entry = $lineStr;
        $entry =~ s/\@//;
        $entry =~ s/[{].*//;
        $bibkey = $lineStr;
        $bibkey =~ s/^.*[{]//;
        $bibkey =~ s/,//;
    }
    elsif ($lineStr =~ m/^[a-zA-Z]/) {
        $field = @inArray[$lineNum];
        $field =~ s/\s*=.*//;
        $fieldValue = @inArray[$lineNum];
        $fieldValue =~ s/^[a-zA-Z\s]*=[\s{]*//;
        $fieldValue =~ s/\s*[}]*\s*[,]*$//;
    }
    
    if ($field eq 'author') {
        $author = $field;
        $authorValue = $fieldValue;
    }
    elsif ($field eq 'title') {
        $title = $field;
        $titleValue = $fieldValue;
    }
    elsif ($field eq 'journal') {
        $journal = $field;
        $journalValue = $fieldValue;
    }
    elsif ($field eq 'year') {
        $year = $field;
        $yearValue = $fieldValue;
    }
    elsif ($field eq 'volume') {
        $volume = $field;
        $volumeValue = $fieldValue;
    }
    elsif ($field eq 'number') {
        $number = $field;
        $numberValue = $fieldValue;
    }
    elsif ($field eq 'month') {
        $month = $field;
        $monthValue = $fieldValue;
    }
    elsif ($field eq 'pages') {
        $pages = page;
        $pagesValue = $fieldValue;
    }
    elsif ($field eq 'note') {
        $ref = ref;
        $refValue = $fieldValue;
    }
    elsif ($field eq 'publisher') {
        $publisher = $field;
        $publisherValue = $fieldValue;
    }
    elsif ($field eq 'editor') {
        $editor = $field;
        $editorValue = $fieldValue;
    }
    elsif ($field eq 'series') {
        $series = $field;
        $seriesValue = $fieldValue;
    }
    elsif ($field eq 'address') {
        $address = $field;
        $addressValue = $fieldValue;
    }
    elsif ($field eq 'edition') {
        $edition = $field;
        $editionValue = $fieldValue;
    }
    elsif ($field eq 'chapter') {
        $chapter = $field;
        $chapterValue = $fieldValue;
    }
    elsif ($field eq 'type') {
        $type = $field;
        $typeValue = $fieldValue;
    }
    elsif ($field eq 'school') {
        $school = $field;
        $schoolValue = $fieldValue;
    }
    elsif ($field eq 'organization') {
        $organisation = organisation;
        $organisationValue = $fieldValue;
    }
    elsif ($field eq 'booktitle') {
        $booktitle = $field;
        $booktitleValue = $fieldValue;
    }
    elsif ($field eq 'crossref') {
        $crossref = $field;
        $crossrefValue = $fieldValue;
    }
    elsif ($field eq 'howpublished') {
        $howpub = howpub;
        $howpubValue = $fieldValue;
    }
    elsif ($field eq 'institution') {
        $institution = $field;
        $institutionValue = $fieldValue;
    }
    elsif ($field eq 'keywords') {
        $keywords = $field;
        $keywordsValue = $fieldValue;
    }
    
    if ($lineStr =~ m/^[}]/) {
        
        print(bibAltDBFile "$bibkey", #0
                            "\@$entry", #1
                            "\@$authorValue", #2
                            "\@$titleValue", #3
                            "\@$journalValue", #4
                            "\@$yearValue", #5
                            "\@$volumeValue", #6
                            "\@$numberValue", #7
                            "\@$monthValue", #8
                            "\@$pagesValue", #9
                            "\@$refValue", #10
                            "\@$publisherValue", #11
                            "\@$editorValue", #12
                            "\@$seriesValue", #13
                            "\@$addressValue", #14
                            "\@$editionValue", #15
                            "\@$chapterValue", #16
                            "\@$typeValue", #17
                            "\@$schoolValue", #18
                            "\@$organisationValue", #19
                            "\@$booktitleValue", #20
                            "\@$crossrefValue", #21
                            "\@$howpubValue", #22
                            "\@$institutionValue", #23
                            "\@$keywordsValue", #24
                            "\@\n");

    $bibkey = '';
    $entry = '';
    $authorValue = '';
    $titleValue = '';
    $journalValue = '';
    $yearValue = '';
    $volumeValue = '';
    $numberValue = '';
    $monthValue = '';
    $pagesValue = '';
    $refValue = '';
    $publisherValue = '';
    $editorValue = '';
    $seriesValue = '';
    $addressValue = '';
    $editionValue = '';
    $chapterValue = '';
    $typeValue = '';
    $schoolValue = '';
    $organisationValue = '';
    $booktitleValue = '';
    $crossrefValue = '';
    $howpubValue = '';
    $institutionValue = '';
    $keywordsValue = '';
        
    }
    
    $pcThru = 100.*$lineNum/$numLines;
    $rem =  $comp - ($pcThru/10.);
    if ($rem < 0.0000000001) {
        printf("%d%s completed\n", $pcThru,'%');
        $comp++;
    }
    
    $lineNum++;
    
}

close(bibAltDBFile);

print("done\n");

}
1;

sub sortAndCompCheck{

    open(bibDBInFile,"< $DBFile") or die "$!";
    open(bibAltDBInFile,"< $altDBFile") or die "$!";

    $altdbNumLines = 0;
    while ( <bibAltDBInFile> ){
        @altdbInArray [$altdbNumLines] = $_;
        $altdbNumLines++;
    }
    
    $bibNumLines = 0;
    while ( <bibDBInFile> ){
        @bibInArray [$bibNumLines] = $_;
        $bibNumLines++;
    }
    
    $bibAtCount = grep(/\@/,@bibInArray);
    
    # print("dbAtCount = $dbAtCount\n");
    # print("altdbNumLines = $altdbNumLines\n");
    
    if ($bibAtCount != $altdbNumLines) {
        &bibCompile;
        &sortDB;
    }

}
1;


sub startup{

local ($moo, $startHandle);

$moo = open(startHandle, "< $DBFile");

if (!$moo) 
    {
    open(startHandle, "> $DBFile");
    print("opening new file $DBFile\n");
    }
close(startHandle); 

$moo = open(startHandle, "< $altDBFile");

if (!$moo) 
    {
    open(startHandle, "> $altDBFile");
    print("opening new file $altDBFile\n");
    }
close(startHandle); 


}
1;

sub bibkeyMake {

    local ($dummy, $dummyOld, $NumLines, @InArray, $count);

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;  # deletes everything after first 'and'
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
        $dummyOld = $dummy;
        $dummy =~ s/[^\s]\S*\s//; # deletes all characters in front of first surname
    }
    
    $NumLines = 0;
    while ( <bibInFile> ){
        @InArray [$NumLines] = $_;
        $NumLines++;
    }
    
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

}
1;
sub titleCheck{

    local ($NumLines, @InArray, $checkNum, $answer);

    $NumLines = 0;
    while ( <bibInFile> ){
    @InArray [$NumLines] = $_;
    $NumLines++;
    }

    $checkNum = grep(/\{$title\}/, @InArray);
    
    if ( $checkNum > 0 ){
    print "This title already exists in database\n";
    print "Add anyway? (y/n) ";
    chop($answer = <>);
    if ($answer eq "y"){
    }
    elsif ($answer eq "n"){
        &add;
    }
    else {
        print "something weird happened\n";
    }
    }


}
1;
sub dotBibWrite{

print("\nKeeping a copy of old .bib file");


open(inFile, "< $DBFile");
$keepFname = join('',"$DBFile",".bak");
open(keepFile, "> $keepFname");
while( <inFile> ) {
    print(keepFile "$_");
}
close(keepFile);
close(inFile);

print("\nWriting new (sorted) .bib file...");

open(outFile, "> $DBFile");

$sizeNewDBArray = @newDBArray;
$i = 0;

while ($i < $sizeNewDBArray) {
    
    @bibArray = split(/\@/,@newDBArray[$i]);
    
    $bibkey = @bibArray[0];
    $entry = @bibArray[1];
    $author = @bibArray[2];
    $title = @bibArray[3];
    $journal = @bibArray[4];
    $year = @bibArray[5];
    $volume = @bibArray[6];
    $number = @bibArray[7];
    $month = @bibArray[8];
    $pages = @bibArray[9];
    $ref = @bibArray[10];
    $publisher = @bibArray[11];
    $editor = @bibArray[12];
    $series = @bibArray[13];
    $address = @bibArray[14];
    $edition = @bibArray[15];
    $chapter = @bibArray[16];
    $type = @bibArray[17];
    $school = @bibArray[18];
    $organisation = @bibArray[19];
    $booktitle = @bibArray[20];
    $crossref = @bibArray[21];
    $howpub = @bibArray[22];
    $institution = @bibArray[23];
    $keywords = @bibArray[24];
    
    
    print(outFile "\@$entry\{$bibkey,\n");
    print(outFile "author = \{$author\},\n");
    print(outFile "title = \{$title\},\n");
    # I should really do some error checking here to see if the values exist
    # and exit with an error message if not
    # Maybe it would be quicker to put all elements in one big array and then
    # write out all at once - maybe a later version, memory hungry, but better
    # for huge .bib files
    
    if (@bibArray[4] ne '') {print(outFile "journal = \{$journal\},\n");}
    if (@bibArray[5] ne '') {print(outFile "year = \{$year\},\n");}
    if (@bibArray[6] ne '') {print(outFile "volume = \{$volume\},\n");}
    if (@bibArray[7] ne '') {print(outFile "number = \{$number\},\n");}
    if (@bibArray[8] ne '') {print(outFile "month = \{$month\},\n");}
    if (@bibArray[9] ne '') {print(outFile "pages = \{$pages\},\n");}
    if (@bibArray[10] ne '') {print(outFile "note = \{$ref\},\n");}
    if (@bibArray[11] ne '') {print(outFile "publisher = \{$publisher\},\n");}
    if (@bibArray[12] ne '') {print(outFile "editor = \{$editor\},\n");}
    if (@bibArray[13] ne '') {print(outFile "series = \{$series\},\n");}
    if (@bibArray[14] ne '') {print(outFile "address = \{$address\},\n");}
    if (@bibArray[15] ne '') {print(outFile "edition = \{$edition\},\n");}
    if (@bibArray[16] ne '') {print(outFile "chapter = \{$chapter\},\n");}
    if (@bibArray[17] ne '') {print(outFile "type = \{$type\},\n");}
    if (@bibArray[18] ne '') {print(outFile "school = \{$school\},\n");}
    if (@bibArray[19] ne '') {print(outFile "organization = \{$organisation\},\n");}
    if (@bibArray[20] ne '') {print(outFile "booktitle = \{$booktitle\},\n");}
    if (@bibArray[21] ne '') {print(outFile "crossref = \{$crossref\},\n");}
    if (@bibArray[22] ne '') {print(outFile "howpublished = \{$hwopub\},\n");}
    if (@bibArray[23] ne '') {print(outFile "institution = \{$institution\},\n");}
    if (@bibArray[24] ne '') {print(outFile "keywords = \{$keywords\}\n");}
    print(outFile "\}\n\n");
    
    $i++;
}

close(outFile);

print("done\n");
}
1;

sub searchAll {

    print "Searching in all fields\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchAll;
    }
    
    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @dbInArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    
    &entriesFoundDecide;    

}
1;
sub searchAuthor {

    print "Searching in author field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchAuthor(@authorArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @authorArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }    
    
    &entriesFoundDecide;    
    
}
1;
sub searchBibkey {

    print "Searching in bibkey field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchBibkey(@bibkeyArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @bibkeyArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    &entriesFoundDecide;    
    
}
1;
sub searchEntry {

    print "Searching in entry field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchEntry(@entryArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @entryArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    &entriesFoundDecide;    
    
}
1;
sub searchJournal {

    print "Searching in journal field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchJournal(@journalArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @journalArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    &entriesFoundDecide;    
    
}
1;
sub searchKeywords {

    print "Searching in keywords field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchKeywords(@keywordsArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @keywordsArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    &entriesFoundDecide;    
    
}
1;
sub searchTitle {

    print "Searching in title field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchTitle(@titleArray);
    }

    @grepArray = '';    
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @titleArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }
    
    &entriesFoundDecide;    
    
}
1;
sub searchYear {

    print "Searching in year field\n";
    print "What do you wish to search for? ";
    chop($answer = <>);
    print "\n";
    if ($answer eq '') {
        print "Please enter a search item\n";
        &searchYear(@yearArray);
    }

    @grepArray = '';
    @indArray = '';
    $ind = 0;
    for ($i=0; $i<$dbNumLines; $i++) {
        $matchFlag = grep(/$answer/i, @yearArray[$i]);
        if ($matchFlag != 0) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind] = $i;
            $ind++;
        }
    }

    &entriesFoundDecide;
    
}
1;
sub printSearchResults {

    print("\n$grepCount entries found\n");
    print("showing results...\n\n");
    
    for ($i=0; $i<$grepCount; $i++) {
        &prettyPrintSearchResults;
        if ($i != $grepCount-1) {
            
            print("\nshow next entry? (y/n) ");
            chop($answer = <>);
            if ($answer eq 'n' || $answer eq 'N') {
                &mainMenu;
            }
            elsif($answer eq 'y' || $answer eq 'Y' || $answer eq '') {
            } else {
                print "whoops, something weird happened in printSearchResults\n";
                &mainMenu;
            }
        }
    }
}
1;
sub prettyPrintSearchResults {

    local (@paper);

    @paper = split('@',@grepArray[$i]);
    
    print "\n";
    print "----------------------------------------------------------------------\n";
    print "Title: \t\t@paper[3]\n";
    print "Author: \t@paper[2]\n";
    print "Journal: \t@paper[4]\n";
    print "Year: \t\t@paper[5]\n";
    print "Volume: \t@paper[6]\n";
#      print "Number: \t@paper[7]\n";
#      print "Month: \t@paper[8]\n";
    print "Page: \t\t@paper[9]\n";
    print "Ref: \t\t@paper[10]\n";
    print "Keywords: \t@paper[24]\n";
    print "Bibkey: \t@paper[0]\n";
    print "Kind: \t\t@paper[1]\n";
#      print "Publisher: @paper[11]\n";
#      print "Editor: @paper[12]\n";
#      print "Series: @paper[13]\n";
#      print "Address: @paper[14]\n";
#      print "Edition: @paper[15]\n";
#      print "Chapter: @paper[16]\n";
#      print "Type: @paper[17]\n";
#      print "School: @paper[18]\n";
#      print "Organisation: @paper[19]\n";
#      print "Booktitle: @paper[20]\n";
#      print "Crossref: @paper[21]\n";
#      print "Howpub: @paper[22]\n";
#   print "Institution: @paper[23]\n";
    print "----------------------------------------------------------------------";
    print "\n";
    
}
1;
sub remove {

    local ($dbInFile, $answer, @oldgrepArray, $grepCount,
            $i);

    print "\nChoosing to remove an entry\n";
    print "Please search for the entry to remove\n";
            
    
    $searchFlag = 0;
    $removeFlag = 1;
    $editFlag = 0;

    open(dbInFile,"< $altDBFile");

    $dbNumLines = 0;
    while ( <dbInFile> ){
    @dbInArray [$dbNumLines] = $_;
    @lineArray = split('@',@dbInArray[$dbNumLines]);
    @titleArray[$dbNumLines] = @lineArray[3];
    @authorArray[$dbNumLines] = @lineArray[2];
    @entryArray[$dbNumLines] = @lineArray[1];
    @bibkeyArray[$dbNumLines] = @lineArray[0];
    @journalArray[$dbNumLines] = @lineArray[4];
    @yearArray[$dbNumLines] = @lineArray[5];
    @keywordsArray[$dbNumLines] = @lineArray[24];
    
    $dbNumLines++;
    }
    
    close(dbInFile);

    print "\nPossible search areas are:\n\n";
    
    print "(A)ll fields\n";
    print "(T)itle field only\n";
    print "(Au)thor field only\n";
    print "(K)eywords field only\n";
    print "(Y)ear field only\n";
    print "(J)ournal field only\n";
    print "(E)ntry type field only\n";
    print "(B)ibliography key field only\n";
    print "Return to (m)ain menu\n";
    print "\n";
    print "Enter an area within which to search: ";
    
    chop($answer = <>);

    print "\n";
    
    if ($answer eq '') {
        print "Please make a selection\n";
        &lookup;
    }
    elsif ($answer eq 'A' || $answer eq 'a') {
        &searchAll;
    }
    elsif ($answer eq 'T' || $answer eq 't') {
        &searchTitle;
    }
    elsif ($answer eq 'Au' || $answer eq 'au' || $answer eq 'AU' || $answer eq 'aU') {
        &searchAuthor;
    }
    elsif ($answer eq 'K' || $answer eq 'k') {
        &searchKeywords;
    }
    elsif ($answer eq 'Y' || $answer eq 'y') {
        &searchYear;
    }
    elsif ($answer eq 'J' || $answer eq 'j') {
        &searchJournal;
    }
    elsif ($answer eq 'E' || $answer eq 'e') {
        &searchEntry;
    }
    elsif ($answer eq 'B' || $answer eq 'b') {
        &searchBibkey;
    }
    elsif ($answer eq 'm' || $answer eq 'M') {
        &mainMenu;
    } else {
        print "something went wrong in remove.pl\n";
        &remove;
    }
    

    &mainMenu;



}
1;
sub removeEntry {

    print("\n$grepCount entries found\n\n");
    
    $i = 0;
    $answer = '';
    while ($answer eq 'n' || $answer eq 'N' || $answer eq '' || $i < $grepCount) {
        $num = $i + 1;
        print("printing entry $num of $grepCount\n");
        &prettyPrintSearchResults;
        print("\nremove this entry? (y/n/x) ");
        chop($answer = <>);
        if ($answer eq 'n' || $answer eq 'N' || $answer eq '') {
        }
        elsif($answer eq 'y' || $answer eq 'Y') {
            splice(@dbInArray, @indArray[$i], 1);
            @newDBArray = @dbInArray;
            print "removing entry...\n";
            &dotBibWrite;
            &bibCompile;
            &mainMenu;
        } 
        elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q' || $answer eq 'm' || $answer eq 'M') {
            &mainMenu;
        } else {
            print "whoops, something weird happened in removeEntry\n";
            &mainMenu;
        }
        $i++;
    }

}
1;
sub edit {
    
    local ($dbInFile, $answer, @oldgrepArray, $grepCount,
            $i);

    &sortAndCompCheck;

    print "\nChoosing to edit an entry\n";
    print "Please search for the entry to edit\n";
            
    
    $searchFlag = 0;
    $removeFlag = 0;
    $editFlag = 1;

    open(dbInFile,"< $altDBFile");

    $dbNumLines = 0;
    while ( <dbInFile> ){
    @dbInArray [$dbNumLines] = $_;
    @lineArray = split('@',@dbInArray[$dbNumLines]);
    @titleArray[$dbNumLines] = @lineArray[3];
    @authorArray[$dbNumLines] = @lineArray[2];
    @entryArray[$dbNumLines] = @lineArray[1];
    @bibkeyArray[$dbNumLines] = @lineArray[0];
    @journalArray[$dbNumLines] = @lineArray[4];
    @yearArray[$dbNumLines] = @lineArray[5];
    @keywordsArray[$dbNumLines] = @lineArray[24];
    
    $dbNumLines++;
    }
    
    close(dbInFile);

    print "\nPossible search areas are:\n\n";
    
    print "(A)ll fields\n";
    print "(T)itle field only\n";
    print "(Au)thor field only\n";
    print "(K)eywords field only\n";
    print "(Y)ear field only\n";
    print "(J)ournal field only\n";
    print "(E)ntry type field only\n";
    print "(B)ibliography key field only\n";
    print "Return to (m)ain menu\n";
    print "\n";
    print "Enter an area within which to search: ";
    
    chop($answer = <>);

    print "\n";
    
    if ($answer eq '') {
        print "Please make a selection\n";
        &lookup;
    }
    elsif ($answer eq 'A' || $answer eq 'a') {
        &searchAll;
    }
    elsif ($answer eq 'T' || $answer eq 't') {
        &searchTitle;
    }
    elsif ($answer eq 'Au' || $answer eq 'au' || $answer eq 'AU' || $answer eq 'aU') {
        &searchAuthor;
    }
    elsif ($answer eq 'K' || $answer eq 'k') {
        &searchKeywords;
    }
    elsif ($answer eq 'Y' || $answer eq 'y') {
        &searchYear;
    }
    elsif ($answer eq 'J' || $answer eq 'j') {
        &searchJournal;
    }
    elsif ($answer eq 'E' || $answer eq 'e') {
        &searchEntry;
    }
    elsif ($answer eq 'B' || $answer eq 'b') {
        &searchBibkey;
    }
    elsif ($answer eq 'm' || $answer eq 'M') {
        &mainMenu;
    } else {
        print "something went wrong in edit.pl\n";
        &edit;
    }
    

    &mainMenu;

}
1;
sub editEntry {

    print("\n$grepCount entries found\n\n");
    
    $i = 0;
    $answer = '';
    while ($answer eq 'n' || $answer eq 'N' || $answer eq '' || $i < $grepCount) {
        $num = $i + 1;
        print("printing entry $num of $grepCount\n");
        &prettyPrintSearchResults;
        print("\nedit this entry? (y/n/x) ");
        chop($answer = <>);
        if ($answer eq 'n' || $answer eq 'N' || $answer eq '') {
        }
        elsif($answer eq 'y' || $answer eq 'Y') {
            &editingEntry;                
        } 
        elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q' || $answer eq 'm' || $answer eq 'M') {
            &mainMenu;
        } else {
            print "whoops, something weird happened in editEntry\n";
            &mainMenu;
        }
        $i++;
    }

}
1;


sub printAllFields {

    @paper = '';
    @paper = split('@',@grepArray[$i]);
    
    @fieldArray = ("Bibkey: ", "Kind: ", "Author: ", "Title: ", "Journal: ",
            "Year: ", "Volume: ", "Number: ,", "Month: ", "Pages: ",
            "Ref: ", "Publisher: ", "Editor: ", "Series: ", "Address: ",
            "Edition: ", "Chapter: ", "Type: ", "School: ", "Organisation: ",
            "Booktitle: ", "Crossref: ", "How published: ", "Institution: ",
            "Keywords: ");    

format STDOUT_TOP=
----------------------------------------------------------------
.
            
format STDOUT=
(@##) @<<<<<<<<<<<<<<^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$j,$field,$fieldVal    
.
    
    for ($j=0; $j<25; $j++) {
        $fieldVal = @paper[$j];
        $field = @fieldArray[$j];
        if ($fieldVal ne '') {
            write ;
        }
    }            


}
1;

sub printToEdit {

    print("\nediting the following entry...\n");
    &printAllFields;
    print("\nwhich field do you wish to edit?\n");
    print("(enter the number beside the field you wish to edit) ");
    chop($fieldAns = <>);

}
1;

sub editField {

    print("\nEditing @fieldArray[$fieldAns] field...\n");
    print("Enter new value for field:\n");
    print("@fieldArray[$fieldAns]");  # this acts as a prompt
    chop($newEditVal = <>);
    @paper[$fieldAns] = $newEditVal;
    print("\n@fieldArray[$fieldAns] @paper[$fieldAns] (y/n) ");
    chop($checkAns = <>);

}
1;

sub entriesFoundDecide {

    $grepCount = @grepArray; # this construct gives the length of the array
    
    if ($ind == 0){
        print "\n";
        print "No entries found\n";
        if ($searchFlag == 1) {
            &lookup;
        }
        elsif ($removeFlag == 1) {
            &remove;
        }
        elsif ($editFlag == 1) {
            &edit;
        } else {
            print "something went wrong in entriesFoundDecide";
        }
    } else {
    
        if ($searchFlag == 1) {
            &printSearchResults;
        }
        elsif ($removeFlag == 1) {
            &removeEntry;
        }
        elsif ($editFlag == 1) {
            &editEntry;
        } else {
            print "something went wrong in entriesFoundDecide";
        }
    }

}
1;
sub editingEntry {

    &printToEdit;
    &editField;
    if ($checkAns eq 'y' || $checkAns eq 'Y' || $checkAns eq '') {
        print("\nDo you wish to edit another field? (y/n) ");
        chop($newFieldAns = <>);
        if ($newFieldAns eq 'y' || $newFieldAns eq 'Y') {
            &editingEntry;
        }
        elsif ($newFieldAns eq 'n' || $newFieldAns eq 'N') {
            @addedArray = '';
            for ($j=0; $j<25; $j++) {
                @addedArray = join('',@addedArray,@paper[$j],"\@");
            }
            @addedArray = join('',@addedArray,"\n");
            push(@dbInArray,@addedArray);
            splice(@dbInArray,@indArray[$i],1);
            @newDBArray = sort(@dbInArray);
            &dotBibWrite;
            &bibCompile;
            &mainMenu;
        } else {
            print "woah, something weird happened in editingEntry\n";
            &editEntry;
        }
    }
    
    elsif ($checkAns eq 'n' || $checkAns eq 'N') {
        &editField;
    } else {
        print("woah, something strange happened in editingEntry\n");
        &editEntry;
    }

}
1;

# vim: expandtab shiftwidth=4:
