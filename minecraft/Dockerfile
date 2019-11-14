#
# Minecraft server with custom commands and backups
#

FROM debian:10

RUN apt-get update && apt-get install -y default-jdk rsync python3

COPY launchserver.sh /usr/local/bin/
COPY copyMinecraftData.sh /usr/local/bin/
COPY commandReader.sh /usr/local/bin/
COPY getLatestServer.py /usr/local/bin/
COPY masterMinecraftStarter.sh /usr/local/bin/

# Expose the port for the server to listen on
EXPOSE 25565

# Expose the data directory
VOLUME /etc/minecraft/data

# Expose the backups directory
VOLUME /etc/minecraft/backups

# Expose the directory for the minecraft server itself
VOLUME /etc/minecraft/bin

CMD ["masterMinecraftStarter.sh"]


