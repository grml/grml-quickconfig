# application menu module for grml-quickconfig

LINE='print_line "Show an application ${HIGHLIGHT}m${NORMAL}enu (${HIGHLIGHT_NAME}pdmenu${NORMAL})"'
KEY=(m)
MENU_PROGNAME=pdmenu
FUNCTION="run $MENU_PROGNAME"

display_entry() {
    . /etc/grml/script-functions
    check4progs $MENU_PROGNAME >/dev/null
    return $?
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
