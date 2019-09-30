# docker-minecraft
A docker wrapper for running a minecraft server with automated backups. It includes a feature in which you can write commands to a file and they will be run in the server console.

# How to use it:
1. clone this repo
2. run updateServer.py to fetch the latest minecraft server and build the docker container.
3. run the docker container as follows:

`docker run -d -p 25565:25565 -v <your minecraft data dir>:/etc/minecraft/data -v <your minecraft backups dir>:/etc/minecraft/backups minecraft:<server version>`

*Note: the <server version> is found in the name of the server file that is downloaded by updateServer.py*

4. Minecraft generates a file called `eula.txt` in the data directory.  You must edit this file from "false" to "true" to indicate that you accept the eula.  Then stop and restart the docker image.
5. If your server version becomes outdated, run the script again to build a new image with the latest version.
  
By default the backups run at 05:30.  To change this, include the environment variable CUSTOM_BACKUP_TIME and set it to a four-character string of the desired hours and minutes, eg. 0530.
