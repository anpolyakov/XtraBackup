#!/bin/bash

#########################
# Variables
#########################

source configure_cron 2> /dev/null

echo LOCATION=$LOCATION >> $HOME/.bashrc
source $HOME/.bashrc

#########################
# Cron Schedule Setup
#########################

# Создание задания полного резервного копирования для cron

(crontab -l 2> /dev/null; echo "$FULL_BACKUP_SCHEDULE" "$LOCATION"/cron/./"full-backup.job 2>/dev/null") | crontab

# Создание задания инкрментного резервного копирования для cron

(crontab -l 2> /dev/null; echo "$DIFF_BACKUP_SCHEDULE" "$LOCATION"/cron/./"diff-backup.job 2>/dev/null") | crontab
