#!/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Diff Next Backup
#########################

xtrabackup --databases=$DATABASE --backup --target-dir=$DIFF_DST/$LAST_DIFF_BACKUP-$TIME --incremental-basedir=$DIFF_DST/$DIFF_BASE_DIR 

chown -R mysql:mysql $DIFF_DST/$TIMESTAMP
