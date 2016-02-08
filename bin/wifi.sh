#!/bin/bash

usage() {
cat <<EOF
wifi: usage:
  general:
    -h, --help    print this message
    -t            output tmux status bar format
    -a            output ascii bar instead of spark's
  colors:
    -g <color>    good battery level      default: green or 1;32
    -m <color>    middle battery level    default: yellow or 1;33
    -w <color>    warn battery level      default: red or 0;31
EOF
}

if [[ $1 == '-h' || $1 == '--help' || $1 == '-?' ]]; then
  usage
  exit 0
fi

# For default behavior
setDefaults() {
  output_tmux=0
  ascii=0
  ascii_bar='=========='
  good_color="1;32"
  middle_color="1;33"
  warn_color="0;31"
}

setDefaults

wifi_strength() {
    dBm="`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | sed -e 's/^.*: //g'`"

    # dBm to Quality:
    if [ $dBm -le -100 ]
    then
        quality=0
    elif [ $dBm -ge -50 ]
    then
        quality=100
    else
        quality=$((2 * ($dBm + 100)))
    fi
}


# Apply the correct color to the battery status prompt
apply_colors() {
    # Green
    if [[ $quality -ge 75 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$good_color]"
        else
            COLOR=$good_color
        fi

        # Yellow
    elif [[ $quality -ge 25 ]] && [[ $quality -lt 75 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$middle_color]"
        else
            COLOR=$middle_color
        fi

        # Red
    elif [[ $quality -lt 25 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$warn_color]"
        else
            COLOR=$warn_color
        fi
    fi
}

print_status() {
# Print the battery status
    if ((BATT_CONNECTED)); then
        GRAPH="⚡"
    else
        if hash spark 2>/dev/null; then
			sparks=$(spark 0 ${quality} 100)
			GRAPH=${sparks:1:1}
        else
            ascii=1
        fi
    fi

    if ((ascii)); then
        barlength=${#ascii_bar}

        # Divides BATTTERY_STATUS by 10 to get a decimal number; i.e 7.6
        n=$(echo "scale = 1; $quality / 10" | bc)

        # Round the number to the nearest whole number
        rounded_n=$(printf "%.0f" "$n")

        # Creates the bar
        GRAPH=$(printf "[%-${barlength}s]" "${ascii_bar:0:rounded_n}")
    fi


if ((output_tmux)); then
  printf "%s%s %s%s" "$COLOR" "[$quality%]" "$GRAPH" "#[default]"
else
  printf "\e[0;%sm%s %s \e[m\n"  "$COLOR" "[$quality%]"  "$GRAPH"
fi

}

# Read args
while getopts ":g:m:w:tab:p" opt; do
  case $opt in
    g)
      good_color=$OPTARG
      ;;
    m)
      middle_color=$OPTARG
      ;;
    w)
      warn_color=$OPTARG
      ;;
    t)
      output_tmux=1
      good_color="green"
      middle_color="yellow"
      warn_color="red"
      ;;
    a)
      ascii=1
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument"
      exit 1
      ;;
  esac
done

wifi_strength
apply_colors
print_status
