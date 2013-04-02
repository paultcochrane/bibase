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
#   author = 	 {},
#   title = 	 {},
#   booktitle = 	 {},
#   OPTcrossref =  {},
#   OPTkey = 	 {},
#   OPTeditor = 	 {},
#   OPTvolume = 	 {},
#   OPTnumber = 	 {},
#   OPTseries = 	 {},
#   OPTyear = 	 {},
#   OPTorganization = {},
#   OPTpublisher = {},
#   OPTaddress = 	 {},
#   OPTmonth = 	 {},
#   OPTpages = 	 {},
#   OPTnote = 	 {},
#   OPTannote = 	 {}
# }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
