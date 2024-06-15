#!/bin/bash

services=$(networksetup -listnetworkserviceorder | grep 'Hardware Port')

while read line; do
    sname=$(echo $line | awk -F  "(, )|(: )|[)]" '{print $2}')
    sdev=$(echo $line | sed -n 's/.*Device: \(.*\))$/\1/p')
    if [ -n "$sdev" ]; then
        status=$(ifconfig $sdev 2>/dev/null | grep 'status: active')
        if [[ $(echo $status | sed -e 's/.*status: active.*/active/') == 'active' ]]; then
            selfAsigned=$(ifconfig $sdev 2>/dev/null | grep 'inet' | sed -n 's/^.*inet \(169\.254\).*$/\1/p' | sed -n 's/169\.254/true/p')
            if [[ $selfAsigned != 'true' ]]; then
                currentservice="$sname"
                break
            fi
        fi

    fi
done <<< "$(echo "$services")"

if [[ $currentservice == 'Wi-Fi' ]]; then
    echo "$(wifi.sh -t)"
else
    echo "$(ethernet.sh ${sdev})"
fi
