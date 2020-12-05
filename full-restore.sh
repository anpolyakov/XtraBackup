#!/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Full Restore
#########################

echo "Останавливаем MySQL"

systemctl stop mysql

echo "Удаляем исходную базу данных"

rm -rf /var/lib/mysql/$DATABASE

echo "Восстанавливаем полный бэкап"

cp -Rp $FULL_DST/$LAST_FULL_BACKUP/$DATABASE /var/lib/mysql/$DATABASE

echo "Задаем корректного владельца и группу для восстановленной базы"

chown -R mysql:mysql /var/lib/mysql/$DATABASE

echo "Запускаем MySQL"

systemctl start mysql
