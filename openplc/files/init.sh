#!/bin/sh /etc/rc.common
# Copyright (C) 2015 OpenWrt.org

START=99

stop() {
	logger -t openplc "Stop Service"
	killall python3 >/dev/null 2>&1
	killall openplc >/dev/null 2>&1
	sleep 2
	killall -9 python3 >/dev/null 2>&1
	killall -9 openplc >/dev/null 2>&1
}

start() {
	if ! [ -f /usr/libexec/openplc/core/openplc ] ; then
		logger -t openplc "Compile blank_program.st"
		echo "blank_program.st" > /usr/libexec/openplc/active_program
		cd /usr/libexec/openplc/scripts
		./compile_program.sh blank_program.st
	fi
	logger -t openplc "Start Service"
	cd /usr/libexec/openplc
	python3 webserver.py >/dev/null 2>&1 &
}
