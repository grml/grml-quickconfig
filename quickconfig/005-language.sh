# language module for grml-quickconfig
LINE='print_line "Set keyboard layout (${HIGHLIGHT_NAME}grml-lang${NORMAL}): \
${HIGHLIGHT}d${NORMAL}e ${HIGHLIGHT}a${NORMAL}t ${HIGHLIGHT}c${NORMAL}h e${HIGHLIGHT}s${NORMAL} ${HIGHLIGHT}u${NORMAL}s"'

typeset -A lang_mapping

# map keys to language
lang_mapping=(
    d de
    a at
    c ch
    s es
    u us
)

# get all keys from assoc array
KEY=(${(k)lang_mapping})

# $INPUT is the user input
FUNCTION='run grml-lang ${lang_mapping[$INPUT]}'

# always display entry
display_entry() {
    return 0
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
