#!/bin/bash


JBL1='B8:69:C2:70:F3:FF'
JBL2='B8:69:C2:71:7F:D1'

MIC='alsa_input.usb-C-Media_Electronics_Inc._USB_Advanced_Audio_Device-00.iec958-stereo'

bluetoothctl disconnect

JBL1connected=$(bluetoothctl connect $JBL1)
if [ -n "$JBL1connected" ]; then
    sink=$(pactl list short sinks | grep "bluez_sink.$JBL1" | awk '{print $2}')
    if [ -n "$sink" ]; then
        pactl set-default-sink "$sink"
        echo "Set $sink as the default sink"
    fi
fi

JBL2connected=$(bluetoothctl connect $JBL2)
if [ -n "$JBL2connected" ]; then
    sink=$(pactl list short sinks | grep "bluez_sink.$JBL2" | awk '{print $2}')
    if [ -n "$sink" ]; then
        pactl set-default-sink "$sink"
        echo "Set $sink as the default sink"
    fi
fi

pactl set-default-source $MIC
echo "Set $MIC as the default source"

