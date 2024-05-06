#!/bin/sh
# Copyright (C) 2015 OpenWrt.org

Name="PID Program"
Description="PID Program"
File="pid_program.st"
Date_upload=$(date +%s)
sqlite3 /usr/libexec/openplc/openplc.db "insert into Programs (Name,Description,File,Date_upload) \
	values (\"$Name\",\"$Description\",\"$File\",\"$Date_upload\");"

exit 0
