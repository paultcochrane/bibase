sub add{

    local ($answer);

    print("\n\nDo you want to add:\n\n");
    print("A journal (a)rticle\n");
    print("A (b)ook\n");
    print("An (u)npublished work\n");
    print("An article in a conference (p)roceedings\n");
    print("A (t)hesis\n");
    print("A (c)onference proceedings\n");
    print("A page or chapter (i)n a book\n");
    print("A (misc)ellaneous article\n");
    print("An article in a c(o)llection\n");
    print("A (booklet)\n");
    print("A (man)ual\n");
    print("A (tech)nical report\n");
    print("The (m)ain menu\n");
    print("E(x)it\n\n");
    
    print("Choose an option: ");
    chop($answer = <>);

    # clear any variables to stop corruption of .db database file
    &cleanup;

    if($answer eq 'a'){
    &addArticle;}
    elsif($answer eq 'b'){
    &addBook;}
    elsif($answer eq 'u'){
    &addUnpublished;}
    elsif($answer eq 'p'){
    &addInProc;}
    elsif($answer eq 't'){
    &addThesis;}
    elsif($answer eq 'c'){
    &addProc;}
    elsif($answer eq 'i'){
    &addInBook;}
    elsif($answer eq 'misc'){
    &addMisc;}
    elsif($answer eq 'o'){
    &addInColl;}
    elsif($answer eq 'booklet'){
    &addBooklet;}
    elsif($answer eq 'man'){
    &addManual;}
    elsif($answer eq 'tech'){
    &addTechReport;}
    elsif($answer eq 'm'){
    &mainMenu;}
    elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q'){
    &sortAndCompCheck;
    exit(0);
    }
    else{print("woah, something weird happened\n");
     exit(1);}
    
}
1;

# vim: expandtab shiftwidth=4:
