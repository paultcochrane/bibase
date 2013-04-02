sub printAllFields {

	@paper = '';
	@paper = split('@',@grepArray[$i]);
	
	@fieldArray = ("Bibkey: ", "Kind: ", "Author: ", "Title: ", "Journal: ",
			"Year: ", "Volume: ", "Number: ,", "Month: ", "Pages: ",
			"Ref: ", "Publisher: ", "Editor: ", "Series: ", "Address: ",
			"Edition: ", "Chapter: ", "Type: ", "School: ", "Organisation: ",
			"Booktitle: ", "Crossref: ", "How published: ", "Institution: ",
			"Keywords: ");	

format STDOUT_TOP=
----------------------------------------------------------------
.
			
format STDOUT=
(@##) @<<<<<<<<<<<<<<^<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$j,$field,$fieldVal	
.
	
	for ($j=0; $j<25; $j++) {
		$fieldVal = @paper[$j];
		$field = @fieldArray[$j];
		if ($fieldVal ne '') {
			write ;
		}
	}			


}
1;

# vim: expandtab shiftwidth=4:
