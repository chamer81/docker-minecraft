
updateServer.py

docker build -t minecraft:1.14.4 minecraft

docker run -d -p 25565:25565 -v /home/chanson/workarea/svn/docker/data:/etc/minecraft/data -v /home/chanson/workarea/svn/docker/backups:/etc/minecraft/backups minecraft:1.14.4

# stop and set the eula to true

# then re-run


