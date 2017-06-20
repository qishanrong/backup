#!/bin/bash

increment_backup(){
        cd /data/mysqld/backup
        [ -f inc_backup.txt ]||touch inc_backup.txt
        a=`cat degree.txt`
        if ((a==1))
        then
                d_full=`cat full.txt`
                innobackupex --defaults-file=/data/mysqld/mysql3307/tmp/my.cnf --socket=/data/mysqld/mysql3307/data/mysql3307.sock --usr=root --password=rootroot --incremental /data/mysqld/backup --incremental-basedir=/data/mysqld/backup/${d_full}
                if (($?==0))
                then
                        echo "success1"
                        inc=`ls -lt|head -2|tail -1|awk '{print $9}'`
			echo $inc  >>inc_backup.txt
			echo $inc  >>del_backup.txt
                        a=$(($a+1))
                        echo $a >degree.txt
                else
                        echo "failure"
                fi
        else
                d_full=`cat inc_backup.txt|tail -1`
                innobackupex --defaults-file=/data/mysqld/mysql3307/tmp/my.cnf --socket=/data/mysqld/mysql3307/data/mysql3307.sock --usr=root --password=rootroot --incremental /data/mysqld/backup --incremental-basedir=/data/mysqld/backup/${d_full}
                if (($?==0))
                then
                        echo "success2"
                        inc=`ls -lt|head -2|tail -1|awk '{print $9}'`
                        echo $inc  >>inc_backup.txt
			echo $inc  >>del_backup.txt
                        a=$(($a+1))
                        echo $a >degree.txt
                else
                        echo "failure"
                fi
        fi
}
increment_backup
