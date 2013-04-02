sub searchBibkey {

    print "Searching in bibkey field\n";
    print "What do you wish to search for? ";
    chop( $answer = <> );
    print "\n";
    if ( $answer eq '' ) {
        print "Please enter a search item\n";
        &searchBibkey(@bibkeyArray);
    }

    @grepArray = '';
    @indArray  = '';
    $ind       = 0;
    for ( $i = 0 ; $i < $dbNumLines ; $i++ ) {
        $matchFlag = grep( /$answer/i, @bibkeyArray[$i] );
        if ( $matchFlag != 0 ) {
            @grepArray[$ind] = @dbInArray[$i];
            @indArray[$ind]  = $i;
            $ind++;
        }
    }

    &entriesFoundDecide;

}
1;

# vim: expandtab shiftwidth=4:
