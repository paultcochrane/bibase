sub editEntry {

    print("\n$grepCount entries found\n\n");
    
    $i = 0;
    $answer = '';
    while ($answer eq 'n' || $answer eq 'N' || $answer eq '' || $i < $grepCount) {
		$num = $i + 1;
    	print("printing entry $num of $grepCount\n");
    	&prettyPrintSearchResults;
    	print("\nedit this entry? (y/n/x) ");
    	chop($answer = <>);
    	if ($answer eq 'n' || $answer eq 'N' || $answer eq '') {
    	}
    	elsif($answer eq 'y' || $answer eq 'Y') {
			&editingEntry;    			
    	} 
    	elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q' || $answer eq 'm' || $answer eq 'M') {
    		&mainMenu;
    	} else {
    		print "whoops, something weird happened in editEntry\n";
    		&mainMenu;
    	}
    	$i++;
    }

}
1;

# vim: expandtab shiftwidth=4:
