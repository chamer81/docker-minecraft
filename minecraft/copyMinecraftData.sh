#!/bin/sh
# usage: 
# ./copyMinecraftData.sh <serverdir> <worldname>
# eg: ./copyMinecraftData.sh minecraft/data mountain

# keep incremental copies of minecraft data
DATA_NEW=/etc/minecraft/backups/${2}_`date +%Y%m%d`
DATA_CURRENT=/etc/minecraft/backups/${2}_current
# this uses hard links to avoid making new copies of
# chunks that did not change:
rsync -avz --link-dest=$DATA_CURRENT ${1}/${2} $DATA_NEW
# then create a symbolic link to the latest backup:
rm -f $DATA_CURRENT
ln -s $DATA_NEW $DATA_CURRENT

