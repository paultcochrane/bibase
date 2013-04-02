sub editField {

	print("\nEditing @fieldArray[$fieldAns] field...\n");
    print("Enter new value for field:\n");
    print("@fieldArray[$fieldAns]");  # this acts as a prompt
    chop($newEditVal = <>);
    @paper[$fieldAns] = $newEditVal;
    print("\n@fieldArray[$fieldAns] @paper[$fieldAns] (y/n) ");
    chop($checkAns = <>);

}
1;

# vim: expandtab shiftwidth=4:
