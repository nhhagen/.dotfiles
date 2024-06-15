#!/bin/bash

setDefaults() {
  output_tmux=1
  good_color="green"
  middle_color="yellow"
  warn_color="red"
}

sdev=$1

setDefaults

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
# echo " ${currentservice} ${color}[${speed} Mbit/s] ${graph} #[default]"
echo "Ethernet ${color}[${speed} Mbit/s]#[default] "
