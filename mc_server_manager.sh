#!/bin/bash

#	AUTHOR: Kacper Łukasik
#	Project website: https://github.com/UkasikPL/Minecraft_Server_Manager/
# 	Version: 0.3 Alpha

DW_PATH="http://getspigot.org/jenkins/job/CraftBukkit/lastSuccessfulBuild/artifact/craftbukkit-1.9.jar"

INSTALL_DIR="src"

MAX_RAM="1024"
A="-Xmx"
B="M"

function createdir {
	if [ ! -e $INSTALL_DIR ]; then
		mkdir $INSTALL_DIR
	fi
}

function downloadjar {
	if [ ! -e "$INSTALL_DIR/craftbukkit-1.9.jar" ]; then
		cd $INSTALL_DIR
		wget "$DW_PATH"
		cd "../"
	fi
}

function addeula 
{
	if [ ! -e "$INSTALL_DIR/elua.txt" ]; then
		echo "eula=true" > "$INSTALL_DIR/eula.txt"
	fi
}

function reinstall {
	rm -r $INSTALL_DIR
	createdir
	downloadjar
	addeula
	echo -e "\e[92mReinstall successful !\e[0m"
}

function uninstall {
	if [ -e $INSTALL_DIR ]; then
		rm -r $INSTALL_DIR
		echo -e "\e[92mUninstall successful !\e[0m"
	fi
}

function startserver {
	echo "====================================="
	read -p "Set the amount of RAM [MB]: " MAX_RAM
	echo "====================================="
	cd $INSTALL_DIR
	java "$A$MAX_RAM$B" -jar craftbukkit-1.9.jar -o true
}

createdir
downloadjar
addeula

#Start server
if [ $# -eq 1 ] || [ $# -eq 2 ]; then
	if [ -e "$INSTALL_DIR/craftbukkit-1.9.jar" ] && [ $1 = "start" ]; then
		startserver
	else if [ $1 = "reinstall" ]; then
		reinstall
	else if [ $1 = "uninstall" ]; then
		uninstall
	fi
	fi
	fi
fi	

