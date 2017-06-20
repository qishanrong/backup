#!/bin/bash

full_backup(){
[ -d /data/mysqld/backup ]||mkdir /ctu/data/backup -p
cd /data/mysqld/backup
[ -f full.txt ]||touch full.txt
rm -rf inc_backup.txt
innobackupex --defaults-file=/data/mysqld/mysql3307/tmp/my.cnf --socket=/data/mysqld/mysql3307/data/mysql3307.sock --usr=root --password=rootroot /data/mysqld/backup/
if (($?==0))
then
        echo "success"
        full=`ls -lt|head -2|tail -1|awk '{print $9}'`
        echo $full >full.txt
	echo $full >>del_backup.txt
else
        echo "failure"
fi
echo 1 >degree.txt
}

full_backup
