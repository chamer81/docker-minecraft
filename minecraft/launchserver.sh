#!/bin/sh

# Total memory
memory_kb=`awk '/MemTotal/{print $2}' /proc/meminfo`

NUM_SERVERS=${NUM_SERVERS:-1}
SERVER_FACTOR=$((200*NUM_SERVERS))

# Calculate minimum memory
memory_min=$(($memory_kb/200*30))
# Calculate maximum memory
memory_max=$(($memory_kb/200*80))

cd /etc/minecraft/data

#java -jar -Xms${memory_min}K -Xmx${memory_max}K /etc/minecraft/bin/minecraft_server.jar nogui
java -jar -Xms512M -Xmx2048M /etc/minecraft/bin/minecraft_server.jar nogui