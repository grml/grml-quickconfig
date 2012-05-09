# grml-info module for grml-quickconfig
if [ -n "$distri" ] ; then
  LINE='print_line "Show ^information about $distri (/grml-info/)"'
else
  LINE='print_line "Show ^information about Grml (/grml-info/)"'
fi

KEY=(i)
FUNCTION="run grml-info"

display_entry() {
  if [ -n "$distri" ] ; then
    page="/usr/share/doc/${distri}-docs/index.html"
  else
    page="/usr/share/doc/grml-docs/startpage.html"
  fi

  if [ -r "$page" ] ; then
    return 0
  else
    return 1
  fi
}

## END OF FILE #################################################################
# vim:foldmethod=marker expandtab ai ft=zsh shiftwidth=2
