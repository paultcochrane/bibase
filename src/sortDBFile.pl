sub sortDBFile {

    print("Sorting $DBFile...");

    system(
"/usr/local/bin/emacs -batch -q -l /usr/local/share/emacs/19.34/lisp/bibtex.el $DBFile -f bibtex-sort-entries -f save-buffer 2> /dev/null"
    );

    print("done\n");
}
1;

# vim: expandtab shiftwidth=4:
