sub removeEntry {

    print("\n$grepCount entries found\n\n");
    
    $i = 0;
    $answer = '';
    while ($answer eq 'n' || $answer eq 'N' || $answer eq '' || $i < $grepCount) {
		$num = $i + 1;
    	print("printing entry $num of $grepCount\n");
    	&prettyPrintSearchResults;
    	print("\nremove this entry? (y/n/x) ");
    	chop($answer = <>);
    	if ($answer eq 'n' || $answer eq 'N' || $answer eq '') {
    	}
    	elsif($answer eq 'y' || $answer eq 'Y') {
    		splice(@dbInArray, @indArray[$i], 1);
    		@newDBArray = @dbInArray;
    		print "removing entry...\n";
    		&dotBibWrite;
    		&bibCompile;
    		&mainMenu;
    	} 
    	elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q' || $answer eq 'm' || $answer eq 'M') {
    		&mainMenu;
    	} else {
    		print "whoops, something weird happened in removeEntry\n";
    		&mainMenu;
    	}
    	$i++;
    }

}
1;