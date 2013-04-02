sub startup {

    local ( $moo, $startHandle );

    $moo = open( startHandle, "< $DBFile" );

    if ( !$moo ) {
        open( startHandle, "> $DBFile" );
        print("opening new file $DBFile\n");
    }
    close(startHandle);

    $moo = open( startHandle, "< $altDBFile" );

    if ( !$moo ) {
        open( startHandle, "> $altDBFile" );
        print("opening new file $altDBFile\n");
    }
    close(startHandle);

}
1;

# vim: expandtab shiftwidth=4:
