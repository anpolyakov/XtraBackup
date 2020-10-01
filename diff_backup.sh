#!/bin/bash

TIMESTAMP=`date +%Y-%m-%d`

FULL_DST=/root/backup/full
DIFF_DST=/root/backup/diff

array=( $(find $FULL_DST -maxdepth 1 -type d -name '20*' | cut -c 19- | sort) )
LAST_FULL_BACKUP=`echo ${array[-1]}`

xtrabackup --backup --target-dir=$DIFF_DST/$TIMESTAMP --incremental-basedir=$FULL_DST/$LAST_FULL_BACKUP
