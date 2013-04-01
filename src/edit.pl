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