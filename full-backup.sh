#!/bin/bash

#########################
# Variables
#########################

source configure_backup 2> /dev/null

#########################
# Full Backup
#########################

if [ -d "$FULL_DST/$TIMESTAMP" ]
then
        echo "Сегодня уже был создан полный бэкап"
else
    
    mkdir -p $BACKUP_DIR
    mkdir -p $FULL_DST/$TIMESTAMP

    echo "Создаем полную резервную копию"
    
    xtrabackup --backup --databases $DATABASE --target-dir=$FULL_DST/$TIMESTAMP &> /tmp/full_backup_$TIMESTAMP.log

    echo "Подготавливаем резервную копию для восстановления"
    
    xtrabackup --prepare --target-dir=$FULL_DST/$TIMESTAMP &> /tmp/full_prepare_backup_$TIMESTAMP.log

    echo "Назначаем корректного владельца и группу для MySQL"

    chown -R mysql:mysql $FULL_DST/$TIMESTAMP

    echo "Удаляем все резервные копии старше 14 дней"

    find $FULL_DST -mtime +14 -exec rm -rf {} \;

    echo "Задача полного резервного копирования завершена, полную резервную копию можно найти по указанному пути ниже"

    ls -ld $FULL_DST/$TIMESTAMP | cut -c 43-

    echo " "

fi
