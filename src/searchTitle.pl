sub searchTitle {

	print "Searching in title field\n";
	print "What do you wish to search for? ";
	chop($answer = <>);
	print "\n";
	if ($answer eq '') {
		print "Please enter a search item\n";
		&searchTitle(@titleArray);
	}

	@grepArray = '';	
	@indArray = '';
	$ind = 0;
	for ($i=0; $i<$dbNumLines; $i++) {
		$matchFlag = grep(/$answer/i, @titleArray[$i]);
		if ($matchFlag != 0) {
			@grepArray[$ind] = @dbInArray[$i];
			@indArray[$ind] = $i;
			$ind++;
		}
	}
	
	&entriesFoundDecide;	
	
}
1;