#!/bin/bash

# Файл для создания cron задач по расписанию, при помощи скрипта

#########################
# Variables
#########################

source configure_cron 2> /dev/null # импорт внешнего файла configure_cron, при этом импортируются все переменные и другие параметры

echo LOCATION=$LOCATION >> $HOME/.bashrc # считывается переменная $LOCATION из файла configure_backup и экспортируется в файл .bashrc
                                         # для того, чтобы она постоянно присутствовала в системе, это необходимо для выполнения cron-задач
source $HOME/.bashrc                     # импорт внешнего файла .bashrc

#########################
# Cron Schedule Setup
#########################

# Создание задания полного резервного копирования для cron

(crontab -l 2> /dev/null; echo "$FULL_BACKUP_SCHEDULE" "$LOCATION"/cron/./"full-backup.job 2>/dev/null") | crontab

# Создание задания инкрментного резервного копирования для cron

(crontab -l 2> /dev/null; echo "$DIFF_BACKUP_SCHEDULE" "$LOCATION"/cron/./"diff-backup.job 2>/dev/null") | crontab
