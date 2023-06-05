#!/usr/bin/env bash
source ~/.config/xfce4/panel/colors.sh

#genmon script for package manager is updated or not
PACKAGE_MANAGER_ICON=""
PAMAC_UPDATE=$(pamac checkupdates)

# Panel
INFO="<txt> "

if [ "$PAMAC_UPDATE" = "Your system is up to date." ]; then 
    INFO+="<span>"
else
    INFO+="<span fgcolor=${COLOR_YELLOW}>"
fi

INFO+="${PACKAGE_MANAGER_ICON=""}"
INFO+="</span>"
INFO+=" </txt>"


INFO+="<txtclick>pamac-manager --updates</txtclick>"

# Tooltip
MORE_INFO="<tool>"
MORE_INFO+="${PAMAC_UPDATE}"
MORE_INFO+="</tool>"

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"