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
	if ! python3 -m pip show pymodbus >/dev/null 2>&1 ; then
		logger -t openplc "Install pymodbus"
		python3 -m pip install pymodbus==2.5.3
	fi
	logger -t openplc "Start Service"
	cd /usr/libexec/openplc/webserver
	#/usr/libexec/openplc/.venv/bin/python3 webserver.py
	python3 webserver.py >/dev/null 2>&1 &
}
