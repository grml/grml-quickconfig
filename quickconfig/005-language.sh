# language module for grml-quickconfig
LINE='print_line "Set keyboard layout (${HILIGHT_NAME}grml-lang${NORMAL}): \
${HILIGHT}d${NORMAL}e ${HILIGHT}a${NORMAL}t ${HILIGHT}c${NORMAL}h e${HILIGHT}s${NORMAL} ${HILIGHT}u${NORMAL}s"'

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
