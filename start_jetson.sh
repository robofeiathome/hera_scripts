#!/bin/bash

IP_JETSON="10.42.0.167"

sshpass -p 123456 ssh robofei@IP_JETSON

./start_jetson.bash
