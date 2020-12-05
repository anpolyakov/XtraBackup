#/bin/bash

#########################
# Variables
#########################

source configure_backup

#########################
# Diff Restore
#########################

echo "Подготавливаем полный бэкап к восстановлению"

xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP &> /tmp/diff_prepare_backup_$TIMESTAMP.log

echo "Подготавливаем первичный инкрементный бэкап к восстановлению"

xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$LAST_DIFF_BACKUP \

&>> /tmp/diff_prepare_backup_$TIMESTAMP.log

for value in ${array_next[@]}
do
        xtrabackup --prepare --apply-log-only --target-dir=$FULL_DST$LAST_FULL_BACKUP --incremental-dir=$DIFF_DST/$value \
        &>> /tmp/diff_prepare_backup_$TIMESTAMP.log
        echo "Подготавливаем следующий доступный инкрементный бэкап для восстановления"
done

echo "Применение всех доступных инкрементных бэкапов от $TIMESTAMP к полному бэкапу завершено"
