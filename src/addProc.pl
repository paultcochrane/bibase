sub addProc {

    local (
        $bibFile,  $bibInFile, $title,    $year,      $editor,
        $volume,   $number,    $series,   $publisher, $organisation,
        $address,  $month,     $keywords, $dummy,     $dummyOld,
        $NumLines, @InArray,   $checkNum, $answer,    $count,
        $bibkey
    );

    open( bibFile,   ">> $DBFile" ) or die "$!";
    open( bibInFile, "< $DBFile" )  or die "$!";
    print("Choosing to add and a conference proceedings\n\n");

    print("Title: ");
    chop( $title = <> );

    if ( $title eq "" ) {
        print "Title $bibErrMsg";
        &add;
    }

    print("Year: ");
    chop( $year = <> );

    if ( $year eq "" ) {
        print "Year $bibErrMsg";
        &add;
    }

    print("Editor: ");
    chop( $editor = <> );

    print("Volume: ");
    chop( $volume = <> );

    print("Number: ");
    chop( $number = <> );

    print("Series: ");
    chop( $series = <> );

    print("Publisher: ");
    chop( $publisher = <> );

    print("Organisation: ");
    chop( $organisation = <> );

    print("Address: ");
    chop( $address = <> );

    print("Month: ");
    chop( $month = <> );

    print("Keywords: ");
    chop( $keywords = <> );

    if ( $keywords eq "" ) {
        print "you need to add a keyword or keywords";
        &add;
    }

    $dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ) {
        $dummyOld = $dummy;
        $dummy =~ s/[^\s]\S*\s//;
    }

    $NumLines = 0;
    while (<bibInFile>) {
        @InArray[$NumLines] = $_;
        $NumLines++;
    }

    $checkNum = grep( /\{$title\}/, @InArray );

    if ( $checkNum > 0 ) {
        print "This title already exists in database\n";
        print "Add anyway? (y/n) ";
        chop( $answer = <> );
        if ( $answer eq "y" ) {
        }
        elsif ( $answer eq "n" ) {
            &add;
        }
        else {
            print "something weird happened\n";
        }
    }

    $count = grep( /\{$dummy:$year/i, @InArray );
    $count++;

    $bibkey = join( ":", $dummy, $year, $count );

    print( bibFile "\@Proceedings{$bibkey,\n" );
    print( bibFile "title = {$title},\n" );
    print( bibFile "year = {$year},\n" );

    if ( $editor ne "" ) {
        print( bibFile "editor = {$editor},\n" );
    }
    if ( $volume ne "" ) {
        print( bibFile "volume = {$volume},\n" );
    }
    if ( $number ne "" ) {
        print( bibFile "number = {$number},\n" );
    }
    if ( $series ne "" ) {
        print( bibFile "series = {$series},\n" );
    }
    if ( $publisher ne "" ) {
        print( bibFile "publisher = {$publisher},\n" );
    }
    if ( $organisation ne "" ) {
        print( bibFile "organization = {$organisation},\n" );
    }
    if ( $address ne "" ) {
        print( bibFile "address = {$address},\n" );
    }
    if ( $month ne "" ) {
        print( bibFile "month = {$month},\n" );
    }
    print( bibFile "keywords = {$keywords}\n" );
    print( bibFile "}\n\n" );

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

# vim: expandtab shiftwidth=4:
