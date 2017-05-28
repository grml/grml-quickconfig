# window manager module for grml-quickconfig
LINE='print_line "Start ^x (/grml-x/)"'
KEY=(x)
FUNCTION='wm_menu'

display_entry() {
    . /etc/grml/script-functions
    check4progs grml-x >/dev/null 2>&1
    return $?
}

if [ "$(cat /proc/1/comm 2>/dev/null)" = "systemd" ] ; then
  SYSTEMD=true
else
  SYSTEMD=false
fi

# variable definition {{{
typeset -A wms
typeset -A available
set -A output
# }}}

# window manager definition {{{
wms=(
  a awesome
  d dwm
  e evilwm
  f fluxbox
  v fvwm
  2 fvwm2
  c fvwm-crystal
  3 i3
  j jwm
  o openbox
  k pekwm
  r ratpoison
  t twm
  9 w9wm
  w windowlab
  i wmii
  n wm-ng
  )
# }}}

# deteremine installed window managers {{{
print_available_wm() {
  . /etc/grml/script-functions
  LEN=0
  AVAILABLE_WM_COUNT=0
  local line

  for key value in ${(kv)wms} ; do
    if check4progs $value >/dev/null 2>&1 ; then
      available[$key]=$value
      # test if word could be added to current line
      if [ $((${(c)#value} + $LEN)) -ge $(($MAXLEN-9)) ] ; then
        LEN=0
        output+="$line"
        line=""
      fi
      line+="$(highlight_char $value $key) "
      LEN=$((${(c)#value} + $LEN))
      AVAILABLE_WM_COUNT=$(($AVAILABLE_WM_COUNT + 1))
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
  if [ $AVAILABLE_WM_COUNT == 1 ]; then
    if $SYSTEMD ; then
      chvt 7
      return
    else
      chgrp tty "$TTY"
      chmod g+rw "$TTY"
      run sudo -u grml grml-x
      return
    fi
  fi
  echo
  wm_heading
  for line in ${output} ; do
    print_line $line
  done
  print_closing_line

  echo
  get_key INPUT
  case $INPUT in
    [${(k)available}])
    if $SYSTEMD ; then
      mkdir -p /var/run/grml-x/
      echo "${available[$INPUT]}" > /var/run/grml-x/window-manager
      chvt 7
    else
      chgrp tty "$TTY"
      chmod g+rw "$TTY"
      run sudo -u grml -c "grml-x ${available[$INPUT]}"
    fi
    ;;
  esac
}
# }}}

print_available_wm

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=2
