#!/bin/bash


JBL1='B8:69:C2:70:F3:FF'
JBL2='B8:69:C2:71:7F:D1'

bluetoothctl disconnect

bluetoothctl pair $JBL1
bluetoothctl connect $JBL1
sink=$(pactl list short sinks | grep "bluez_sink.$JBL1" | awk '{print $2}')
if [ -n "$sink" ]; then
    pactl set-default-sink "$sink"
    echo "Set $sink as the default sink"
fi
bluetoothctl pair $JBL2
bluetoothctl connect $JBL2
sink=$(pactl list short sinks | grep "bluez_sink.$JBL2" | awk '{print $2}')
if [ -n "$sink" ]; then
    pactl set-default-sink "$sink"
    echo "Set $sink as the default sink"
fi
