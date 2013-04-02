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
#   author = 	 {},
#   title = 	 {},
#   chapter = 	 {},
#   publisher = 	 {},
#   year = 	 {},
#   OPTkey = 	 {},
#   OPTeditor = 	 {},
#   OPTvolume = 	 {},
#   OPTnumber = 	 {},
#   OPTseries = 	 {},
#   OPTaddress = 	 {},
#   OPTedition = 	 {},
#   OPTmonth = 	 {},
#   OPTpages = 	 {},
#   OPTtype = 	 {},
#   OPTnote = 	 {},
#   OPTannote = 	 {}
# }


    &add;

}
1;

# vim: expandtab shiftwidth=4:
