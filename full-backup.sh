#!/bin/bash

#########################
# Variables
#########################

source configure_backup 2> /dev/null     # подключение внешего файла configure_backup, 
                                         # при подключении проиходит импорт всех переменных и других настроек из файла

#########################
# Full Backup
#########################

if [ -d "$FULL_DST/$TIMESTAMP" ]         # проверка на существование директории $FULL_DST/$TIMESTAMP, 
                                         # где $FULL_DST это путь к директории для создания полных бэкапов, а $TIMESTAMP это текущая дата 
then
        echo "Сегодня уже был создан полный бэкап"   # если директория на сегодняшний день уже существует, то полный бэкап не будет сделан  
else
    
    mkdir -p $BACKUP_DIR   # создание директории для хранения всех бэкапов
    mkdir -p $FULL_DST/$TIMESTAMP    # создание директории для полного бэкапа

    echo "Создаем полную резервную копию"     
    
    xtrabackup --backup --databases $DATABASE --target-dir=$FULL_DST/$TIMESTAMP &> /tmp/full_backup_$TIMESTAMP.log # создается полный бэкап базы $DATABASE  

    echo "Подготавливаем резервную копию для восстановления"
    
    xtrabackup --prepare --target-dir=$FULL_DST/$TIMESTAMP &> /tmp/full_prepare_backup_$TIMESTAMP.log # подготовка бэкапа для восстановления

    echo "Назначаем корректного владельца и группу для MySQL"

    chown -R mysql:mysql $FULL_DST/$TIMESTAMP # назначение корректного владельца и группы

    echo "Удаляем все резервные копии старше 14 дней"

    find $FULL_DST -mtime +14 -exec rm -rf {} \; # Удаление полных резервных копий старше 14 дней 

    echo "Задача полного резервного копирования завершена, полную резервную копию можно найти по указанному пути ниже"

    ls -ld $FULL_DST/$TIMESTAMP | cut -c 43- # вывод названия созданной директории с полным бэкапом базы данных

    echo " "

fi
