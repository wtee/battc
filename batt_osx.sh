#!/bin/sh

# /\ charching \/ discharging
# \/ 81%; 1:24 
# /\ 80%; 0:50

pmset -g batt | grep Internal | awk '/discharging/{print "\/ " $2 " " $4};!/discharging/{print "/\\ " $2 " " $4}'
