#!/bin/bash

sleep 5s
modprobe option
echo 2001 7e35 > /sys/bus/usb-serial/drivers/option1/new_id

sleep 1s
logger Launching wvdial script
wvdial
