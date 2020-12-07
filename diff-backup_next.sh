#!/bin/bash

#########################
# Variables
#########################

source configure_backup 2> /dev/null # подключение внешнего файла configure_backup, при этом импортируются перменные и другие параметры

#########################
# Diff Next Backup
#########################

echo "Первичная инкрментная резервная копия уже была создана сегодня"

echo "Создаем дополнительную инкрементную резервную копию"

# создание дополнительного инкрементного бэкапа, он создается после первичного инкрементного бэкапа

xtrabackup --databases=$DATABASE --backup --target-dir=$DIFF_DST/$LAST_DIFF_BACKUP-$TIME --incremental-basedir=$DIFF_DST/$DIFF_BASE_DIR &> /tmp/diff_next_backup_$TIMESTAMP.log 

echo "Назначаем корректного владельца и группу MySQL"

chown -R mysql:mysql $DIFF_DST/$TIMESTAMP # назначаем корректного владельца и группу

echo "Удаляем резервные копии старше 14 дней"

find $DIFF_DST -mtime +14 -exec rm -rf {} \; # удаляются инкрементные резервные копии страше 14 дней

echo "Создание дополнительной инкрементной резервной копии завершено"

echo ""
