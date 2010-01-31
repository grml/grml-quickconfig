# netcardconfig module for grml-quickconfig
LINE='print_line "-> Configure ${HIGHLIGHT}e${NORMAL}thernet card directly (${HIGHLIGHT_NAME}netcardconfig${NORMAL})"'
KEY=(n)
FUNCTION='run netcardconfig'

display_entry() {
    return 0
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
