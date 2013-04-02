sub sortAndCompCheck {

    open( bibDBInFile,    "< $DBFile" )    or die "$!";
    open( bibAltDBInFile, "< $altDBFile" ) or die "$!";

    $altdbNumLines = 0;
    while (<bibAltDBInFile>) {
        @altdbInArray[$altdbNumLines] = $_;
        $altdbNumLines++;
    }

    $bibNumLines = 0;
    while (<bibDBInFile>) {
        @bibInArray[$bibNumLines] = $_;
        $bibNumLines++;
    }

    $bibAtCount = grep( /\@/, @bibInArray );

    # print("dbAtCount = $dbAtCount\n");
    # print("altdbNumLines = $altdbNumLines\n");

    if ( $bibAtCount != $altdbNumLines ) {
        &bibCompile;
        &sortDB;
    }

}
1;

# vim: expandtab shiftwidth=4:
