#!/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Full Backup
#########################

mkdir -p $BACKUP_DIR
mkdir -p $FULL_DST/$TIMESTAMP

xtrabackup --backup --databases $DATABASE --target-dir=$FULL_DST/$TIMESTAMP
xtrabackup --prepare --target-dir=$FULL_DST/$TIMESTAMP

chown -R mysql:mysql $FULL_DST/$TIMESTAMP

find $FULL_DST -mtime +14 -exec rm -rf {} \;
