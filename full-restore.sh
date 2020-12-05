#!/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Full Restore
#########################

systemctl stop mysql
rm -rf /var/lib/mysql/$DATABASE
cp -Rp $FULL_DST/$LAST_FULL_BACKUP/$DATABASE /var/lib/mysql/$DATABASE
