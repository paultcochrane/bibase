sub dotBibWrite {

    print("\nKeeping a copy of old .bib file");

    open( inFile, "< $DBFile" );
    $keepFname = join( '', "$DBFile", ".bak" );
    open( keepFile, "> $keepFname" );
    while (<inFile>) {
        print( keepFile "$_" );
    }
    close(keepFile);
    close(inFile);

    print("\nWriting new (sorted) .bib file...");

    open( outFile, "> $DBFile" );

    $sizeNewDBArray = @newDBArray;
    $i              = 0;

    while ( $i < $sizeNewDBArray ) {

        @bibArray = split( /\@/, @newDBArray[$i] );

        $bibkey       = @bibArray[0];
        $entry        = @bibArray[1];
        $author       = @bibArray[2];
        $title        = @bibArray[3];
        $journal      = @bibArray[4];
        $year         = @bibArray[5];
        $volume       = @bibArray[6];
        $number       = @bibArray[7];
        $month        = @bibArray[8];
        $pages        = @bibArray[9];
        $ref          = @bibArray[10];
        $publisher    = @bibArray[11];
        $editor       = @bibArray[12];
        $series       = @bibArray[13];
        $address      = @bibArray[14];
        $edition      = @bibArray[15];
        $chapter      = @bibArray[16];
        $type         = @bibArray[17];
        $school       = @bibArray[18];
        $organisation = @bibArray[19];
        $booktitle    = @bibArray[20];
        $crossref     = @bibArray[21];
        $howpub       = @bibArray[22];
        $institution  = @bibArray[23];
        $keywords     = @bibArray[24];

        print( outFile "\@$entry\{$bibkey,\n" );
        print( outFile "author = \{$author\},\n" );
        print( outFile "title = \{$title\},\n" );

      # I should really do some error checking here to see if the values exist
      # and exit with an error message if not
      # Maybe it would be quicker to put all elements in one big array and then
      # write out all at once - maybe a later version, memory hungry, but better
      # for huge .bib files

        if ( @bibArray[4] ne '' ) {
            print( outFile "journal = \{$journal\},\n" );
        }
        if ( @bibArray[5] ne '' ) { print( outFile "year = \{$year\},\n" ); }
        if ( @bibArray[6] ne '' ) {
            print( outFile "volume = \{$volume\},\n" );
        }
        if ( @bibArray[7] ne '' ) {
            print( outFile "number = \{$number\},\n" );
        }
        if ( @bibArray[8]  ne '' ) { print( outFile "month = \{$month\},\n" ); }
        if ( @bibArray[9]  ne '' ) { print( outFile "pages = \{$pages\},\n" ); }
        if ( @bibArray[10] ne '' ) { print( outFile "note = \{$ref\},\n" ); }

        if ( @bibArray[11] ne '' ) {
            print( outFile "publisher = \{$publisher\},\n" );
        }
        if ( @bibArray[12] ne '' ) {
            print( outFile "editor = \{$editor\},\n" );
        }
        if ( @bibArray[13] ne '' ) {
            print( outFile "series = \{$series\},\n" );
        }
        if ( @bibArray[14] ne '' ) {
            print( outFile "address = \{$address\},\n" );
        }
        if ( @bibArray[15] ne '' ) {
            print( outFile "edition = \{$edition\},\n" );
        }

        if ( @bibArray[16] ne '' ) {
            print( outFile "chapter = \{$chapter\},\n" );
        }
        if ( @bibArray[17] ne '' ) { print( outFile "type = \{$type\},\n" ); }
        if ( @bibArray[18] ne '' ) {
            print( outFile "school = \{$school\},\n" );
        }
        if ( @bibArray[19] ne '' ) {
            print( outFile "organization = \{$organisation\},\n" );
        }
        if ( @bibArray[20] ne '' ) {
            print( outFile "booktitle = \{$booktitle\},\n" );
        }
        if ( @bibArray[21] ne '' ) {
            print( outFile "crossref = \{$crossref\},\n" );
        }
        if ( @bibArray[22] ne '' ) {
            print( outFile "howpublished = \{$hwopub\},\n" );
        }
        if ( @bibArray[23] ne '' ) {
            print( outFile "institution = \{$institution\},\n" );
        }
        if ( @bibArray[24] ne '' ) {
            print( outFile "keywords = \{$keywords\}\n" );
        }
        print( outFile "\}\n\n" );

        $i++;
    }

    close(outFile);

    print("done\n");
}
1;

# vim: expandtab shiftwidth=4:
