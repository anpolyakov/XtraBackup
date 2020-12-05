#!/bin/bash

#########################
# Variables
#########################

source configure_backup 2>/dev/null

#########################
# Diff Backup
#########################

echo "Проверяем был ли сегодня уже создан первичный инкрементный бэкап"

if [ ! -d "$DIFF_DST/$TIMESTAMP" ] 
then
  
  echo "Первчиный инкрементный бэкап не был создан сегодня, начинаем создание"
  
  echo "Создаем директорию для резервного копирования с текущей датой"

  mkdir -p $DIFF_DST/$TIMESTAMP

  echo "Создаем первчиный инкрементный бэкап"

  xtrabackup --backup --databases=$DATABASE --target-dir=$DIFF_DST/$TIMESTAMP --incremental-basedir=$FULL_DST$LAST_FULL_BACKUP \
  &> /tmp/diff_$TIMESTAMP_$TIME.log

  echo "Назначаем корректного владельца и группу для MySQL"

  chown -R mysql:mysql $DIFF_DST/$TIMESTAMP

  echo "Удаляем резервные копии, которые старше 14 дней"

  find $DIFF_DST -mtime +14 -exec rm -rf {} \;

  echo "Выполнение задачи по созданию инкрементной резервной копии завершено"

  echo "Копию можно найти по следующему адресу ниже"
   
  ls -ld $DIFF_DST/$TIMESTAMP | cut -c 43-                       
   
  echo ""

else
  echo "Сегодня уже был создан первичный инкрементный бэкап, создаем дополнительный" 
  ./diff-backup_next.sh
fi
