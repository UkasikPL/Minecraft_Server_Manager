#!/bin/bash

#	AUTHOR: Kacper Łukasik
#	Project website: github.com
# 	Version: 0.1 Alpha

DW_PATH="http://getspigot.org/jenkins/job/CraftBukkit/lastSuccessfulBuild/artifact/craftbukkit-1.9.jar"

INSTALL_DIR="src"



if [ ! -e $INSTALL_DIR ]; then
	mkdir $INSTALL_DIR
fi

if [ ! -e "$INSTALL_DIR/craftbukkit-1.9.jar" ]; then
	cd $INSTALL_DIR
	wget "$DW_PATH"
	cd "../"
fi

if [ ! -e "$INSTALL_DIR/elua.txt" ]; then
	echo "eula=true" > "$INSTALL_DIR/eula.txt"
fi

if [ $# -eq 1 ]; then
	if [ -a "$INSTALL_DIR/craftbukkit-1.9.jar" ] && [ $1 = "start" ]; then
	cd $INSTALL_DIR
	java -Xmx1024M -jar craftbukkit-1.9.jar -o true
	fi
fi	
