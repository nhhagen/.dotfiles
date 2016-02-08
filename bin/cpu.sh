#!/bin/bash

usage() {
cat <<EOF
cpu: usage:
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

cpu_usage() {
    CPU_PCT="`ps -A -o %cpu | awk '{s+=$1} END {print s}'`"
    LC_ALL=C printf -v CPU_PCT "%.0f" "$CPU_PCT"
}


# Apply the correct color to the battery status prompt
apply_colors() {
    # Green
    if [[ $CPU_PCT -ge 75 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$warn_color]"
        else
            COLOR=$warn_color
        fi

        # Yellow
    elif [[ $CPU_PCT -ge 25 ]] && [[ $CPU_PCT -lt 75 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$middle_color]"
        else
            COLOR=$middle_color
        fi

        # Red
    elif [[ $CPU_PCT -lt 25 ]]; then
        if ((output_tmux)); then
            COLOR="#[fg=$good_color]"
        else
            COLOR=$good_color
        fi
    fi
}

print_status() {
# Print the battery status
    if ((BATT_CONNECTED)); then
        GRAPH="⚡"
    else
        if hash spark 2>/dev/null; then
			sparks=$(spark 0 ${CPU_PCT} 100)
			GRAPH=${sparks:1:1}
        else
            ascii=1
        fi
    fi

    if ((ascii)); then
        barlength=${#ascii_bar}

        # Divides BATTTERY_STATUS by 10 to get a decimal number; i.e 7.6
        n=$(echo "scale = 1; $CPU_PCT / 10" | bc)

        # Round the number to the nearest whole number
        rounded_n=$(printf "%.0f" "$n")

        # Creates the bar
        GRAPH=$(printf "[%-${barlength}s]" "${ascii_bar:0:rounded_n}")
    fi


if ((output_tmux)); then
  printf "%s%s %s%s" "$COLOR" "[$CPU_PCT%]" "$GRAPH" "#[default]"
else
  printf "\e[0;%sm%s %s \e[m\n"  "$COLOR" "[$CPU_PCT%]"  "$GRAPH"
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

cpu_usage
apply_colors
print_status
