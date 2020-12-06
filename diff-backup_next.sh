#!/bin/bash

#########################
# Variables
#########################

source configure_backup 2> /dev/null

#########################
# Diff Next Backup
#########################

echo "Первичная инкрментная резервная копия уже была создана сегодня"

echo "Создаем дополнительную инкрементную резервную копию"

xtrabackup --databases=$DATABASE --backup --target-dir=$DIFF_DST/$LAST_DIFF_BACKUP-$TIME --incremental-basedir=$DIFF_DST/$DIFF_BASE_DIR &> /tmp/diff_next_backup_$TIMESTAMP.log 

echo "Назначаем корректного владельца и группу MySQL"

chown -R mysql:mysql $DIFF_DST/$TIMESTAMP

echo "Удаляем резервные копии старше 14 дней"

find $DIFF_DST -mtime +14 -exec rm -rf {} \;

echo "Создание дополнительной инкрементной резервной копии завершено"

echo ""
