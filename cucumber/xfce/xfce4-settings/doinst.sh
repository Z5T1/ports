#!/bin/bash

# Installs the configuration file specified by $1 ($1 should be the filename
# WITHOUT the .new extension). The behavior of this function can be controlled
# by setting the NEW_FILE_ACTION variable in the environment to one of the
# following:
#
# OVERWRITE: blindly overwrites any existing files.
# KEEP (DEFAULT): keep the old files in place, leaving the new files as .new.
# REPLACE: replace any existing files, but save a copy of the old files as .old.
install_new_file () {
	# Check if the files are identical, and remove the new one if they are.
	diff -q $1.new $1 && rm $1.new

	if [ -z "$NEW_FILE_ACTION" -o "$NEW_FILE_ACTION" == "KEEP" ]; then
		if [ ! -e $1 ]; then
			mv $1.new $1
		fi
	elif [ "$NEW_FILE_ACTION" == "OVERWRITE" ]; then
		mv $1.new $1
	elif [ "$NEW_FILE_ACTION" == "REPLACE" ]; then
		if [ -e $1 ]; then
			mv $1 $1.old
		fi
		mv $1.new $1
	fi
}

install_new_file etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml
