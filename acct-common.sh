#!/bin/bash
# Get all domains and their document roots
accounts=$(for user in $(cat /etc/userdomains | awk '{print $2}' | sort | uniq); do
    if [ -f "/var/cpanel/userdata/$user/main" ]; then
        echo "$user:$(grep "^documentroot:" "/var/cpanel/userdata/$user/main" | awk '{print $2}')"
    fi
done | grep -vE "($(cat "$(dirname "$0")"/nonwp | tr '\n' '|' | sed 's/|$//'))")