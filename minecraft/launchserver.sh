#!/bin/sh

# Total memory
memory_kb=`awk '/MemTotal/{print $2}' /proc/meminfo`

NUM_SERVERS=${NUM_SERVERS:-1}
SERVER_FACTOR=$((200*NUM_SERVERS))

# Calculate minimum memory
memory_min=$((30*$memory_kb/$SERVER_FACTOR))
# Calculate maximum memory
memory_max=$((80*$memory_kb/$SERVER_FACTOR))

cd /etc/minecraft/data

java -jar -Xms${memory_min}K -Xmx${memory_max}K /usr/local/bin/minecraft_server.jar nogui
