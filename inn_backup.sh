#!/bin/bash
date=`date +%F`
del=`date -d '7 days ago' +%F`
innobackupex --defaults-file=/etc/my.cnf --socket=/tmp/mysql.sock -uroot -pumessage --stream=xbstream --compress /home/backup >/home/backup/1243306backup_$date.xbstream
if (( $?==0 ))
then 
	/bin/rm -f /home/backup/1243306backup_$del.xbstream

	a=`ls -l /home/backup/1243306backup_$date.xbstream|awk '{print $5}'`
	if [[ $a -gt 1000000000 ]]
	then
        	echo 'success'
	else 
        	python /home/backup/judge_backup.py
	fi

else 
	python /home/backup/judge_backup.py
fi

