sub printToEdit {

    print("\nediting the following entry...\n");
    &printAllFields;
    print("\nwhich field do you wish to edit?\n");
    print("(enter the number beside the field you wish to edit) ");
    chop($fieldAns = <>);

}
1;

# vim: expandtab shiftwidth=4:
