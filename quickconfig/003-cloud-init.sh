# cloud-init not installed/present
if ! [ -x "$(which cloud-init)" ] ; then
  return 0
fi

# cloud-init service not running
if ! cloud-init status 2>/dev/null | grep -q 'status: running' ; then
  return 0
fi

LINE+="print_line 'Cloud-init information:';"

if cloud-init query -l 2>/dev/null | grep -q userdata ; then
  userdata=$(mktemp)
  cloud-init query userdata > "${userdata}" 2>/dev/null

  hostname=$(awk '/^hostname/ {print $2}' "${userdata}")
  if [ -n "${hostname}" ] ; then
    LINE+="print_line '-> Hostname:    ${hostname}';"
    unset hostname
  fi

  rm -f "${userdata}"
  unset userdata
fi

instance_id=$(cloud-init query instance_id 2>/dev/null)
if [ -n "${instance_id}" ] ; then
  LINE+="print_line '-> Instance ID: ${instance_id}';"
fi

LINE+='print_delim;'

display_entry() { return 0; }
