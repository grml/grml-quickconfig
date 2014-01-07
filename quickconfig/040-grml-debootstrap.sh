LINE='print_line "Install Debian to ^hard disk (/grml-debootstrap/)"'
KEY=(h)
HD_APP=grml-debootstrap
FUNCTION="run $HD_APP"

display_entry() {
    . /etc/grml/script-functions
    check4progs $HD_APP >/dev/null 2>&1
    return $?
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
