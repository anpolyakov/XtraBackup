#!/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Diff Backup
#########################

mkdir -p $DIFF_DST/$TIMESTAMP

xtrabackup --backup --databases=$DATABASE --target-dir=$DIFF_DST/$TIMESTAMP --incremental-basedir=$FULL_DST$LAST_FULL_BACKUP

chown -R mysql:mysql $DIFF_DST/$TIMESTAMP
