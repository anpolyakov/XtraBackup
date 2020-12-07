#!/bin/bash

#########################
# Variables
#########################

source configure_backup  # подключение внешнего файла configure_backup, при этом импортируются все переменные из файла и другие параметры

#########################
# Full Restore
#########################

echo "Останавливаем MySQL"

systemctl stop mysql # Останавливаем MySQL

echo "Удаляем исходную базу данных"

rm -rf /var/lib/mysql/$DATABASE # Удаляем исходную базу данных, вместо которой будет добавлена восстановленная

echo "Восстанавливаем полный бэкап"

cp -Rp $FULL_DST/$LAST_FULL_BACKUP/$DATABASE /var/lib/mysql/$DATABASE # Восстановление последнего полного бэкапа

echo "Задаем корректного владельца и группу для восстановленной базы"

chown -R mysql:mysql /var/lib/mysql/$DATABASE # Задаем корректного владельца и группу для восстановленной базы

echo "Запускаем MySQL"

systemctl start mysql # Запускаем MySQL
