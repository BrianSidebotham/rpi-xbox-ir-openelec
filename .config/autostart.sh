#!/bin/sh
modprobe lirc_xbox
killall -9 lircd
ir-keytable -p lirc
lircd -d /dev/lirc0 /storage/.config/lircd.conf
