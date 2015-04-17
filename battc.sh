#!/bin/bash

# this is free and unincumbered software released into the public domain 
# under the terms of the Unlicense <http://unlicense.org>

## battc -- a color-coded command-line battery monitor for Linux
## (v. 0.1, 2014)
# battc is a simple shell script for montitoring battery life on laptops 
# running Linux it is suitable for inclusion in a commandline prompt. 
# battc displays whether a battery is charging or discharging, 
# the percent of charge the battery is currently holding, and the 
# time remaining until it is fully charged or fully discharged.

# /\ charching \/ discharging
# color code: dark green 100-76%; light green 75-51%; yellow: 50-26%; 
# red: 25-6%; blinking red: 5-0%
# blinking may not be supported on your terminal emulator.

# dependencies: acpi, mawk, and ksh or bash

BATTSTAT=$(acpi -b | mawk '/Discharging/{printf "\\/ "};\
/Charging/{printf "/\\ "};\ 
{gsub(/,/, ""); print $4 " " $5};');

BATTPER=${BATTSTAT:3}
BATTPER=${BATTPER%\%*}
if [[ $BATTPER -gt 75 ]] ; then
	echo $'\E[0;32m' ${BATTSTAT} $'\E[0m'
elif [[ $BATTPER -le 75 && $BATTPER -gt 50 ]] ; then
	echo $'\E[1;32m' ${BATTSTAT} $'\E[0m'
elif [[ $BATTPER -le 50 && $BATTPER -gt 25 ]] ; then
	echo $'\E[33m' ${BATTSTAT} $'\E[0m'
elif [[ $BATTPER -le 25 && $BATTPER -gt 5 ]] ; then
	echo $'\E[31m' ${BATTSTAT} $'\E[0m'
elif [[ $BATTPER -le 5 ]] ; then
	echo $'\E[5;31m' ${BATTSTAT} $'\E[0m'
fi

