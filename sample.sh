#/bin/bash

source configure_backup 2>/dev/null

#echo "LAST_DIFF_NEXT_BACKUP:" $LAST_DIFF_NEXT_BACKUP

echo "FULL_DSTLAST_FULL_BACKUP:" $FULL_DST$LAST_FULL_BACKUP

echo "DIFF_DST/LAST_DIFF_BACKUP:" $DIFF_DST/$LAST_DIFF_BACKUP

echo "array_next:" ${array_next[@]}
