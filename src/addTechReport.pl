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
#   author = 	 {},
#   title = 	 {},
#   institution =  {},
#   year = 	 {},
#   OPTkey = 	 {},
#   OPTtype = 	 {},
#   OPTnumber = 	 {},
#   OPTaddress = 	 {},
#   OPTmonth = 	 {},
#   OPTnote = 	 {},
#   OPTannote = 	 {}
# }

    &add;

}
1;
