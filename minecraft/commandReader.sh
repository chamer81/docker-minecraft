#!/bin/sh

STOP_CMD=stop
BACKUP_TIME=${CUSTOM_BACKUP_TIME:-0530}

# fetch/update the server jar:
/usr/local/bin/getLatestServer.py

touch cmdfile
# clear any existing commands:
truncate --size 0 cmdfile

while [ "$COMMAND" != "$STOP_CMD" ] ;
do
	COMMAND=`cat cmdfile`
        if [ -n "$COMMAND" ]; then
            truncate --size 0 cmdfile ;
            echo $COMMAND ;
       fi
       sleep 5 ;
       CURR_TIME=`date +%H%M` ;
       if [ "$CURR_TIME" = "$BACKUP_TIME" ] ; then
           # save-off makes it stop incremental writes to the filesystem
           echo save-off ;
           # save-all flushes the latest data to the filesystem
           # for a clean data directory to save
           echo save-all ;
           sleep 1 ;
           /usr/local/bin/copyMinecraftData.sh $1 $2 > save.log 2> save.err
           # check if latest server is running, otherwise stop:
           /usr/local/bin/getLatestServer.py confirm_only
           retVal=$?
           if [ $retVal -ne 0 ]; then
               echo $STOP_CMD
               COMMAND=STOP_CMD
           else
               # back to normal, continuously save world data:
               echo save-on ;
               # wait a minute to avoid saving twice:
               sleep 60 ;
           fi
        fi

        # now kill this script if minecraft crashed
        RUNNING=`ps -ef | grep minecraft_server.jar | grep -v grep`
        # maybe change command to:
        # `lsof -i -P -n | grep LISTEN | grep java | grep <portnum> | grep -v grep`
        # to check that it's not just running, but listening...
        if [ -n "$RUNNING" ]; then
          date > running.txt
        else
          COMMAND=STOP_CMD
        fi
done

truncate --size 0 cmdfile

