sub mainMenu{

    print("\n\n");
    print("Would you like to:\n\n");
    print("(S)earch for an entry\n");
    print("(A)dd an entry\n");
    print("(R)emove an entry\n");
    print("(E)dit an entry\n");
    print("E(x)it\n\n");

    print("Please choose an option: ");
    chop($answer = <>);

    if($answer eq 'l' || $answer eq 'L' || $answer eq 's' || $answer eq 'S')
    {
    	&lookup;
    }
    elsif($answer eq 'a' || $answer eq 'A')
    {
    	&add;
    }
    elsif($answer eq 'r' || $answer eq 'R')
    {
		&remove;
	}
    elsif($answer eq 'c' || $answer eq 'C' || $answer eq 'e' || $answer eq 'E')
    {
    	&edit;
    }
    elsif($answer eq 'x' || $answer eq 'X' || $answer eq 'q' || $answer eq 'Q')
    {
    	&sortAndCompCheck;
    	exit(0);
    }
    else{
    	print("woah, something weird must have happened\n");
    	&mainMenu;
    }
    
}
1;

# vim: expandtab shiftwidth=4:
