sub editingEntry {

    &printToEdit;
	&editField;
	if ($checkAns eq 'y' || $checkAns eq 'Y' || $checkAns eq '') {
		print("\nDo you wish to edit another field? (y/n) ");
		chop($newFieldAns = <>);
		if ($newFieldAns eq 'y' || $newFieldAns eq 'Y') {
			&editingEntry;
		}
		elsif ($newFieldAns eq 'n' || $newFieldAns eq 'N') {
			@addedArray = '';
			for ($j=0; $j<25; $j++) {
				@addedArray = join('',@addedArray,@paper[$j],"\@");
			}
			@addedArray = join('',@addedArray,"\n");
			push(@dbInArray,@addedArray);
			splice(@dbInArray,@indArray[$i],1);
			@newDBArray = sort(@dbInArray);
			&dotBibWrite;
			&bibCompile;
			&mainMenu;
		} else {
			print "woah, something weird happened in editingEntry\n";
			&editEntry;
		}
	}
	
	elsif ($checkAns eq 'n' || $checkAns eq 'N') {
		&editField;
	} else {
		print("woah, something strange happened in editingEntry\n");
		&editEntry;
	}

}
1;

# vim: expandtab shiftwidth=4:
