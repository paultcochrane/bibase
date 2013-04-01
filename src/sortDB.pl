sub sortDB{

    print("Sorting $altDBFile...");

    open(dbInFile, "< $altDBFile");

    @dbInArray = '';
    $dbNumLines = 0;
    while ( <dbInFile> ){
	@dbInArray [$dbNumLines] = $_;
	$dbNumLines++;
    }

    close(dbInFile);

    @newDBArray = sort(@dbInArray);

    open(dbOutFile, "> $altDBFile");

    print(dbOutFile @newDBArray);

    close(dbOutFile);

    print("done\n");
    
    &dotBibWrite;
    
}
1;
