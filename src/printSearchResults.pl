sub printSearchResults {

    print("\n$grepCount entries found\n");
    print("showing results...\n\n");
    
    for ($i=0; $i<$grepCount; $i++) {
    	&prettyPrintSearchResults;
    	if ($i != $grepCount-1) {
    		
    		print("\nshow next entry? (y/n) ");
    		chop($answer = <>);
    		if ($answer eq 'n' || $answer eq 'N') {
    			&mainMenu;
    		}
    		elsif($answer eq 'y' || $answer eq 'Y' || $answer eq '') {
    		} else {
    			print "whoops, something weird happened in printSearchResults\n";
    			&mainMenu;
    		}
    	}
	}
}
1;

# vim: expandtab shiftwidth=4:
