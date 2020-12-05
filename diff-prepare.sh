#/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Diff Restore
#########################

xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP
xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$LAST_DIFF_BACKUP

for value in ${array_next[@]}
do
        xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$value
done
