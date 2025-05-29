#!/bin/bash
# Get all domains and their document roots
accounts=$(for user in $(cat /etc/userdomains | awk '{print $2}' | sort | uniq); do
    if [ -f "/var/cpanel/userdata/$user/main" ]; then
        domain=$(grep "^domain:" "/var/cpanel/userdata/$user/main" | awk '{print $2}')
        # Skip if either username or domain is in nonwp
        if ! grep -qE "^$user$|^$domain$" "$(dirname "$0")/nonwp"; then
            echo "$user:$(grep "^documentroot:" "/var/cpanel/userdata/$user/main" | awk '{print $2}')"
        fi
    fi
done)