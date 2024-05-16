#!/bin/sh
# Copyright (C) 2015 OpenWrt.org

restart=0
if pidof openplc ; then
	/etc/init.d/openplc stop
	restart=1
	sleep 1
fi
Name="Blank Program"
Description="PID Program"
File="blank_program.st"
Date_upload=$(date +%s)
sqlite3 /usr/libexec/openplc/openplc.db "insert into Programs (Name,Description,File,Date_upload) \
	values (\"$Name\",\"$Description\",\"$File\",\"$Date_upload\");"
cp /usr/libexec/openplc/core/blank_program /usr/libexec/openplc/core/openplc
echo blank_program.st > /usr/libexec/openplc/active_program 

if [ restart = 1 ] ; then
	/etc/init.d/openplc start
fi

exit 0
