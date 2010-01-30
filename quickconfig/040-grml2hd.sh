LINE='print_line "Install grml to ${HILIGHT}h${NORMAL}ard disk (${HILIGHT_NAME}grml2hd${NORMAL}"'
KEY=(m)
HD_APP=grml2hd
FUNCTION="run $HD_APP"

display_entry() {
    . /etc/grml/script-functions
    check4progs $HD_APP >/dev/null
    return $?
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
