# grml-quickonfig module
# print the heading
LINE='print_line "Welcome to grml-quickconfig";
print_line "Press a highlighted key to perform an action, or press";
print_line "/Return/ or ^q to go back to the shell, or ^r to refresh.";
print_delim;
'

display_entry() {
    return 0
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
