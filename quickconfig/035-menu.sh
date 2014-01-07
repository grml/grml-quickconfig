# application menu module for grml-quickconfig

LINE='print_line "Show an application ^menu (/pdmenu/)"'
KEY=(m)
MENU_PROGNAME=pdmenu
FUNCTION="run $MENU_PROGNAME"

display_entry() {
    . /etc/grml/script-functions
    check4progs $MENU_PROGNAME >/dev/null 2>&1
    return $?
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
