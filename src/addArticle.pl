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
#   author = 	 {},
#   title = 	 {},
#   journal = 	 {},
#   year = 	 {},
#   OPTkey = 	 {},
#   OPTvolume = 	 {},
#   OPTnumber = 	 {},
#   OPTmonth = 	 {},
#   OPTpages = 	 {},
#   OPTnote = 	 {},
#   OPTannote = 	 {}
# }

    &add;

}
1;

# vim: expandtab shiftwidth=4:
