#
# Minecraft server with custom commands and backups
#

FROM debian:10

RUN apt-get update && apt-get install -y default-jdk && apt-get install -y rsync

COPY minecraft_server.jar /usr/local/bin/
COPY launchserver.sh /usr/local/bin/
COPY copyMinecraftData.sh /usr/local/bin/
COPY commandReader.sh /usr/local/bin/
COPY masterMinecraftStarter.sh /usr/local/bin/
COPY minecraft_version /usr/local/bin/minecraft_version

# Expose the port for the server to listen on
EXPOSE 25565

# Expose the data directory
VOLUME /etc/minecraft/data

# Expose the backups directory
VOLUME /etc/minecraft/backups

CMD ["masterMinecraftStarter.sh"]


