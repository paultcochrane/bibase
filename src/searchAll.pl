sub searchAll {

	print "Searching in all fields\n";
	print "What do you wish to search for? ";
	chop($answer = <>);
	print "\n";
	if ($answer eq '') {
		print "Please enter a search item\n";
		&searchAll;
	}
	
	@grepArray = '';
	@indArray = '';
	$ind = 0;
	for ($i=0; $i<$dbNumLines; $i++) {
		$matchFlag = grep(/$answer/i, @dbInArray[$i]);
		if ($matchFlag != 0) {
			@grepArray[$ind] = @dbInArray[$i];
			@indArray[$ind] = $i;
			$ind++;
		}
	}
	
	
	&entriesFoundDecide;	

}
1;

# vim: expandtab shiftwidth=4:
