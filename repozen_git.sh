#!/usr/bin/env bash
source ~/.config/xfce4/panel/colors.sh

#genmon script connected to repozen gitlab

# Panel
INFO+="<img>/home/elias/.config/xfce4/panel/repozen_x16.png</img>"
INFO+="<click>xfce4-terminal</click>"


# Tooltip
MORE_INFO="<tool>Repozen gitlab repository dashboard</tool>" #to hide the tooltip

# Panel Print
echo -e "${INFO}"

# Tooltip Print
echo -e "${MORE_INFO}"