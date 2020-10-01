#!/bin/bash

TIMESTAMP=`date +%Y-%m-%d`

xtrabackup --backup --target-dir=/root/backup/full/$TIMESTAMP
xtrabackup --prepare --target-dir=/root/backup/full/$TIMESTAMP

find /root/backup/full/ -mtime +14 -exec rm -rf {} \;
