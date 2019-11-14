#!/bin/sh

# try to find the world name:
SERVER_PROPS_FILE=/etc/minecraft/data/server.properties
if [ -f "$SERVER_PROPS_FILE" ]; then
  LEVEL_NAME=`grep level-name "$SERVER_PROPS_FILE" | awk -F'=' '{print $2}'`
else
  # if the data has not yet been initialized, the world name will be the default:
  LEVEL_NAME=world
fi

cd /etc/minecraft/data

# pipe the output of the command reader as commands into the minecraft server terminal
/usr/local/bin/commandReader.sh /etc/minecraft/data $LEVEL_NAME | /usr/local/bin/launchserver.sh

