# always try to gather network information
LOCAL_IF=$(ip -o route show | sed -nre '/^default /s/^default .*dev ([^ ]+).*/\1/p' | head -1)
if [ -n "${LOCAL_IF}" ] ; then
  IPADDR=$(ip -o addr show "${LOCAL_IF}" | grep ' inet ' | head -n 1 | sed -e 's/.*inet \([^ ]*\) .*/\1/' -e 's/\/.*//')
fi

LOCAL_IF6=$(ip -6 -o route show | sed -nre '/^default /s/^default .*dev ([^ ]+).*/\1/p' | head -1)
if [ -n "${LOCAL_IF6}" ] ; then
  IPADDR6=$(ip -6 -o addr show "${LOCAL_IF6}" | grep ' inet6 ' | head -n 1 | sed -e 's/.*inet6 \([^ ]*\) .*/\1/' -e 's/\/.*//')
fi

# ssh / password information
SSHD_PID=$(pgrep sshd || true)
SSH_OPTION=$(grep -Eo '\<ssh=[^ ]+' /proc/cmdline || true)
PWD_OPTION=$(grep -Eo '\<passwd=[^ ]+' /proc/cmdline || true)

if [ -n "${SSHD_PID:-}" ] ; then
  LINE+="print_line 'You can connect with SSH to the IP addresses listed below.';"
fi

USER=$(getent passwd 1000 | cut -d: -f1)
[ -n "${USER:-}" ] || USER="grml"
if [ -n "${PWD_OPTION:-}" ] ; then
  PWD_OPTION=${PWD_OPTION#*=}
  LINE+="print_line 'The password for user root/${USER} is: ${PWD_OPTION:-}';"
elif [ -n "${SSH_OPTION:-}" ] ; then
  SSH_OPTION=${SSH_OPTION#*=}
  LINE+="print_line 'The password for user root/${USER} is: ${SSH_OPTION:-}';"
fi

LINE+="print_line 'Network information:';"

NETINFO_PRESENT=false

# zeroconf information
AVAHI_PID=$(pgrep avahi-daemon || true)
if [ -n "${AVAHI_PID:-}" ] && [ -x "$(which avahi-resolve-address)" ] && [ -n "${IPADDR:-}" ] ; then
  AVAHI_INFO="$(avahi-resolve-address "${IPADDR}" 2>/dev/null | awk '{print $2}')"
  if [ -n "${AVAHI_INFO:-}" ] ; then
    LINE+="print_line '-> Hostname:   ${AVAHI_INFO}';"
    NETINFO_PRESENT=true
  fi
fi

# list all non-localhost IP addresses
declare -a IP_LIST
for ip in $(
  {
    ip -4 -o addr show | grep ' inet '  | sed -e 's/.*inet \([^ ]*\) .*/\1/'  -e 's/\/.*//'
    ip -6 -o addr show | grep ' inet6 ' | sed -e 's/.*inet6 \([^ ]*\) .*/\1/' -e 's/\/.*//'
  } | sort -u) ; do
  case "${ip}" in
    127.0.0.*)
      continue
      ;;
    ::1)
      continue
      ;;
    fe80::*)
      continue
      ;;
    *)
      LINE+="print_line '-> IP address: $ip';"
      NETINFO_PRESENT=true
      ;;
  esac
done

if [ "${NETINFO_PRESENT}" = "false" ] ; then
  LINE+="print_line '-> network seems to be unconfigured (yet)';"
fi

LINE+='print_delim;'

display_entry() { return 0; }
