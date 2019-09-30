#!/bin/sh

STOP_CMD=stop
BACKUP_TIME=${CUSTOM_BACKUP_TIME:-0530}
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
           echo save-off ;
           echo save-all ;
           sleep 1 ;
           /usr/local/copyMinecraftData.sh $1 $2 > save.log
           echo save-on ;
           # wait a minute to avoid saving twice:
           sleep 60 ;
       fi

done

truncate --size 0 cmdfile

