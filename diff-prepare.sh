#/bin/bash

#########################
# Variables
#########################

source configure_backup. # подключение внешнего файла configure_backup, при этом импортируются все переменные из файла и другие параметры

#########################
# Diff Restore
#########################

echo "Подготавливаем полный бэкап к восстановлению"

# подготовка полного бэкапа для восстановления

xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP &> /tmp/diff_prepare_backup_$TIMESTAMP.log

# подготовка первичного инкрементного бэкапа для восстановления

echo "Подготавливаем первичный инкрементный бэкап к восстановлению"

xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$LAST_DIFF_BACKUP &>> /tmp/diff_prepare_backup_$TIMESTAMP.log

# Подготавливает все инкрементные бэкапы на текущую дату для восстановления

for value in ${array_next[@]}
do
        xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$value \
        &>> /tmp/diff_prepare_backup_$TIMESTAMP.log
        echo "Подготавливаем следующий доступный инкрементный бэкап для восстановления"
done

echo "Применение всех доступных инкрементных бэкапов от $TIMESTAMP к полному бэкапу завершено"
