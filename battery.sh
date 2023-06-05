#!/usr/bin/env bash
source ~/.config/xfce4/panel/colors.sh

#genmon script for the battery icon

readonly VOLTAGE=$(awk '{$1 = $1 / 1000000; print $1}' /sys/class/power_supply/BAT*/voltage_now)
readonly BATTERY=$(awk '{print $1}' /sys/class/power_supply/BAT*/capacity)
readonly TIME_UNTIL=$(acpi | awk '{print $5}' | awk 'NR==2')

#Set your custom low_battery level
LOW_BATTERY=25;

INFO=
if [ "${BATTERY}" -lt "${LOW_BATTERY}" ]; then                # battery is too low ; don't make me appear ; charge it before reaching this condition
  batteryIcon=$(echo "\ue0b1")
elif [ "${BATTERY}" -ge 25 ] && [ "${BATTERY}" -lt 50 ]; then # if battery is charged between 25 and 50
  batteryIcon=$(echo "\uf243")
elif [ "${BATTERY}" -ge 50 ] && [ "${BATTERY}" -lt 60 ]; then # if battery is half charged
  batteryIcon=$(echo "\uf242")
elif [ "${BATTERY}" -ge 60 ] && [ "${BATTERY}" -lt 95 ]; then # if battery is charged more than 60%
  batteryIcon=$(echo "\uf241")
else                                                          # if battery is full charged
  batteryIcon=$(echo "\uf240")
fi

if hash xfce4-power-manager-settings &> /dev/null; then
  INFO+="<txtclick>xfce4-power-manager-settings</txtclick>"     # clicking on the icon opens XFCE power manager
fi

INFO+="<txt>"
if acpi -a | grep -i "off-line" &> /dev/null; then   # if AC adapter is offline
  if [ "${BATTERY}" -lt ${LOW_BATTERY} ]; then       # if battery is less than $LOW_BATTERY
    INFO+="<span fgcolor=${COLOR_RED}>"       # make the icon bold red
  elif [ "${BATTERY}" -gt 75 ]; then
    INFO+="<span fgcolor=${COLOR_YELLOW}>"  #icon appears green if the charge is above 75
  else
    INFO+="<span fgcolor=${COLOR_WHITE_3}>" # make the icon white for normal states
  fi
else # if the battery is getting charged
  INFO+="<span fgcolor=${COLOR_GREEN}>" # icon is green while getting charged
fi
INFO+=" ${batteryIcon} "
INFO+="</span>"
INFO+="<span fgcolor=${COLOR_WHITE_3}>"
INFO+="${BATTERY}% "
INFO+="</span>"
INFO+="</txt>"


# Tooltip
MORE_INFO="<tool>"

if acpi -a | grep -i "off-line" &> /dev/null; then # if AC adapter is offline
  if [ "${BATTERY}" -eq 98 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else
    MORE_INFO+="└─ Remaining Time: ${TIME_UNTIL}"      # shows the remaining time on battery
  fi
elif acpi -a | grep -i "on-line" &> /dev/null; then # if AC adapter is online
  if [ "${BATTERY}" -eq 98 ]; then # if battery is fully charged
    MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
  else 
    MORE_INFO+="└─ Time to fully charge: ${TIME_UNTIL}"    # shows remaining time to charge
  fi
else # if battery is in unknown state (no battery at all, throttling, etc.)
  MORE_INFO+="└─ Voltage: ${VOLTAGE} V"
fi
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"
