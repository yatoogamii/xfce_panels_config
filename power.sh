#!/usr/bin/env bash

#genmon-script for showing the power

POWER_ICON=$(echo "\uf011")

# Panel
INFO="<txt>  ${POWER_ICON}  </txt>"

INFO+="<txtclick>xfce4-session-logout</txtclick>"

# Tooltip
MORE_INFO="<tool>${NULL_VALUE}</tool>" #to hide the tooltip

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"