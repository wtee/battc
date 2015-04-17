#!/bin/bash

# this is free and unincumbered software released into the public domain 
# under the terms of the Unlicense <http://unlicense.org>

## battc -- a color-coded battery monitor for Conky on Linux
## (v. 0.1, 2014)
# battc is a simple shell script for montitoring battery life on laptops 
# battc displays whether a battery is charging or discharging, 
# the percent of charge the battery is currently holding, and the 
# time remaining until it is fully charged or fully discharged.

# /\ charching \/ discharging
# color code: dark green 100-76%; light green 75-51%; yellow: 50-26%; 
# red: 25-0%; 

# dependencies: acpi, mawk, and ksh or bash

BATTSTAT=$(acpi -b | mawk '/Discharging/{printf "\\/ "};\
/Charging/{printf "/\\ "};\ 
{gsub(/,/, ""); print $4 " " $5};');

BATTPER=${BATTSTAT:3}
BATTPER=${BATTPER%\%*}
if [[ $BATTPER -gt 75 ]] ; then
	echo '${color #008000}' ${BATTSTAT} 
elif [[ $BATTPER -le 75 && $BATTPER -gt 50 ]] ; then
	echo '${color #7cfc00}' ${BATTSTAT} 
elif [[ $BATTPER -le 50 && $BATTPER -gt 25 ]] ; then
	echo '${color #ffff00}' ${BATTSTAT} 
elif [[ $BATTPER -le 25 ]] ; then
	echo '${color #ff0000}' ${BATTSTAT} 
fi

