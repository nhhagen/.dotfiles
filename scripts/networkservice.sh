#!/bin/bash

setDefaults() {
  output_tmux=1
  good_color="green"
  middle_color="yellow"
  warn_color="red"
}

setDefaults

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
    echo " $(wifi.sh -t)"
elif [[ $(echo $currentservice | sed -e 's/.*Ethernet.*/Ethernet/') == 'Ethernet' ]]; then
    speed=$(ifconfig $sdev 2>/dev/null | grep 'media' | sed -e 's/.*(\(.*\)base.* .*/\1/')
    if [[ $speed -ge 750 ]]; then
        if ((output_tmux)); then
            color="#[fg=$good_color]"
        else
            color=$good_color
        fi

        # Yellow
    elif [[ $speed -ge 250 ]] && [[ $speed -lt 750 ]]; then
        if ((output_tmux)); then
            color="#[fg=$middle_color]"
        else
            color=$middle_color
        fi

        # Red
    elif [[ $speed -lt 250 ]]; then
        if ((output_tmux)); then
            color="#[fg=$warn_color]"
        else
            color=$warn_color
        fi
    fi
    sparks=$(spark 0 ${speed} 1000)
    graph=${sparks:1:1}
    echo " ${currentservice} ${color}[${speed} Mbit/s] ${graph} #[default]"
else
    echo ""
fi
