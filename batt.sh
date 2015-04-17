#!/bin/sh

# /\ charching \/ discharging
# \/ 81%; 1:24 
# /\ 80%; 0:50

acpi -b | mawk '/Discharging/{printf "\\/ "}; /Charging/{printf "/\\ "}; {gsub(/,/, ""); print $4 " " $5};';
