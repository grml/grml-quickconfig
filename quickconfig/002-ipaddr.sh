ROOTPWD=$(grep -Eo '\<ssh=[^ ]+' /proc/cmdline || true)

if [ "$ROOTPWD" ]; then
  ROOTPWD=${ROOTPWD#*=}

  USER=$(getent passwd 1000 | cut -d: -f1)
  [ -n "$USER" ] || USER="grml"

  LOCAL_IF=$(ip -o route show | sed -nre '/^default /s/^default .*dev ([^ ]+).*/\1/p' | head -1)
  if [ -n "$LOCAL_IF" ] ; then
    IPADDR=$(ip -o addr show $LOCAL_IF | grep ' inet ' | head -n 1 | sed -e 's/.*inet \([^ ]*\) .*/\1/' -e 's/\/.*//')
  fi

  LOCAL_IF6=$(ip -6 -o route show | sed -nre '/^default /s/^default .*dev ([^ ]+).*/\1/p' | head -1)
  if [ -n "$LOCAL_IF6" ] ; then
    IPADDR6=$(ip -6 -o addr show $LOCAL_IF6 | grep ' inet6 ' | head -n 1 | sed -e 's/.*inet6 \([^ ]*\) .*/\1/' -e 's/\/.*//')
  fi

  LINE='print_line "You can connect with SSH to: $IPADDR $IPADDR6";
print_line "The password for user root/$USER is: $ROOTPWD";
  print_delim;
'
fi

display_entry() { return 0; }

