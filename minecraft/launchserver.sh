#!/bin/sh

# Total memory
memory_kb=`awk '/MemTotal/{print $2}' /proc/meminfo`

# Calculate minimum memory
memory_min=$(($memory_kb/200*30))
# Calculate maximum memory
memory_max=$(($memory_kb/200*80))

cd /etc/minecraft/data

java -jar -Xms${memory_min}K -Xmx${memory_max}K /usr/local/bin/minecraft_server.jar nogui
