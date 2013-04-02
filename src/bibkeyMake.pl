sub bibkeyMake {

	local ($dummy, $dummyOld, $NumLines, @InArray, $count);

	$dummy = $author;
    $dummy =~ s/\sand[\w\W]*//;  # deletes everything after first 'and'
    $dummyOld = zzzzzzzz;
    while ( $dummyOld ne $dummy ){
    	$dummyOld = $dummy;
    	$dummy =~ s/[^\s]\S*\s//; # deletes all characters in front of first surname
    }
    
	$NumLines = 0;
	while ( <bibInFile> ){
		@InArray [$NumLines] = $_;
		$NumLines++;
	}
	
    $count = grep(/\{$dummy:$year/i, @InArray);
    $count++;
    
    $bibkey = join(":",$dummy,$year,$count);

}
1;

# vim: expandtab shiftwidth=4:
