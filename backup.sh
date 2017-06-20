#!/bin/bash
date=`date +%F`
del=`date -d '10 days ago' +%F`
mysqldump -S /data/mysqld/mysql3307/data/mysql3307.sock --single-transaction --master-data=2 --events --routines -uroot -p --databases activity huimin_pos mpos newdb report supermarket >/data/mysqld/backup/backup_$date.sql
if (( $?==0 ))
then 
	gzip /data/mysqld/backup/backup_$date.sql
	/bin/rm -f /data/mysqld/backup/backup_$del.sql.gz
else 
	python /data/mysqld/backup/judge_backup.py
fi

a=`ls -l /data/mysqld/backup/backup_$date.sql.gz|awk '{print $5}'`
if [[ $a -gt 100000 ]]
then
 	echo $a
else 
	python /data/mysqld/backup/judge_backup.py
fi
