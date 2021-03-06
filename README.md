# docker-minecraft
A docker wrapper for running a minecraft server with automated backups. It includes a feature in which you can write commands to a file and they will be run in the server console.

# How to use it:
1. clone this repo
2. run the docker container as follows (or use the included `docker-compose.yml` file):

`docker run -d -p 25565:25565 -v <your minecraft data dir>:/etc/minecraft/data -v <your minecraft backups dir>:/etc/minecraft/backups minecraft:<server version>`

3. Minecraft generates a file called `eula.txt` in the data directory.  You must edit this file from "false" to "true" to indicate that you accept the eula.  Then stop and restart the docker image.

*Note:* if you run this with docker-compose (see the included docker-compose.yml file), the "restart: always" command causes the server to automatically restart when/if it crashes or if you stop it by writing "stop" in the cmdfile.

## Configure backups
By default the backups run at 05:30.  To change this, include the environment variable CUSTOM_BACKUP_TIME and set it to a four-character string of the desired hours and minutes, eg. 0530.

## Commands in the console
To run a command in the minecraft server console, just navigate to your minecraft data directory and replace the file `cmdfile` with one containing your command, like this:

`echo "time set day" > cmdfile`

The file will be truncated and the command will be run.
