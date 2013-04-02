sub entriesFoundDecide {

    $grepCount = @grepArray; # this construct gives the length of the array
    
    if ($ind == 0){
        print "\n";
        print "No entries found\n";
        if ($searchFlag == 1) {
            &lookup;
        }
        elsif ($removeFlag == 1) {
            &remove;
        }
        elsif ($editFlag == 1) {
            &edit;
        } else {
            print "something went wrong in entriesFoundDecide";
        }
    } else {
    
        if ($searchFlag == 1) {
            &printSearchResults;
        }
        elsif ($removeFlag == 1) {
            &removeEntry;
        }
        elsif ($editFlag == 1) {
            &editEntry;
        } else {
            print "something went wrong in entriesFoundDecide";
        }
    }

}
1;

# vim: expandtab shiftwidth=4:
