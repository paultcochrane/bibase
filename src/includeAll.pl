#!perl

open(outFile, "> bibaseBig.pl");

open(inFile, "< bibase.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< mainMenu.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< lookup.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< add.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addThesis.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addUnpublished.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addBook.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addArticle.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addInProc.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addMisc.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addProc.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addInBook.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addInColl.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addManual.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addTechReport.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< addBooklet.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< sortDB.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< cleanup.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< bibCompile.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< sortAndCompCheck.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< startup.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< bibkeyMake.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< titleCheck.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< dotBibWrite.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchAll.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchAuthor.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchBibkey.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchEntry.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchJournal.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchKeywords.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchTitle.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< searchYear.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< printSearchResults.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< prettyPrintSearchResults.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< remove.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< removeEntry.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< edit.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< editEntry.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< printAllFields.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< printToEdit.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< editField.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< entriesFoundDecide.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);
open(inFile, "< editingEntry.pl"); while ( <inFile> ){print(outFile "$_");} print(outFile "\n"); close(inFile);

close(outFile);