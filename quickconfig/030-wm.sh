# window manager module for grml-quickconfig
LINE='print_line "Start ${HILIGHT}x${NORMAL} (${HILIGHT_NAME}grml-x${NORMAL})"'
KEY=(x)
FUNCTION='wm_menu'

display_entry() {
    return 0
}

# variable definition {{{
typeset -A wms
typeset -A available
set -a output
# }}}

# window manager definition {{{
wms[a]=awesome
wms[d]=dwm
wms[e]=evilwm
wms[f]=fluxbox
wms[v]=fvwm
wms[2]=fvwm2
wms[c]=fvwm-crystal
wms[j]=jwm
wms[o]=openbox
wms[k]=pekwm
wms[r]=ratpoison
wms[t]=twm
wms[9]=w9wm
wms[w]=windowlab
wms[i]=wmii
wms[n]=wm-ng
# }}}

# deteremine installed window managers {{{
print_available_wm() {
  . /etc/grml/script-functions
  line=""
  LEN=0

  for key value in ${(kv)wms} ; do
    if check4progs $value >/dev/null ; then
      available[$key]=$value
      # test if word could be added to current line
      if [ $[${(c)#key} + $LEN] -lt $MAXLEN ] ; then
        LEN+=${(c)#wm}
        line+="$(hilight_char $value $key) "
      else
        LEN=0
        output+="$line"
      fi
    fi
  done
  output+="$line"
}
# }}}

# heading for wm menu {{{
wm_heading() {
 print_starting_line
 print_line "Select a window manager (unsorted list):"
 print_line "Press any other key to return to the main menu."
 print_delim
}
# }}}

# print windowm manager loop {{{
wm_menu() {
  echo
  wm_heading
  for line in $output ; do
    print_line $line
  done
  print_closing_line

  echo
  get_key INPUT
  case $INPUT in
    [${(k)available}])
    run su - grml -c "grml-x ${available[$INPUT]}"
    ;;
  esac
}
# }}}

print_available_wm

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=3
