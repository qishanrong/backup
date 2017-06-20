#!/bin/bash


killrinetd(){
	idd=`netstat -lnutp|grep rinetd|head -1|awk '{print $7}'|awk -F / '{print $1}'`
	kill -9 $idd
}

startrinetd(){
	cd /home/develop/rinetd/rinetd && ./rinetd
}


judgeredis(){
a=`redis-cli -h 118.190.100.212 -a bc0bf69a940a4ada:zWRwEPgdyEB89uXI <<eof
ping
eof`

	if [ "PONG" = "$a" ] 
	then
		echo `date +%Y-%m-%d_%H:%M:%S` $a
	else
		killrinetd
		startrinetd
		echo `date +%Y-%m-%d_%H:%M:%S` restart >>/home/develop/rinetd/rinetd.log
	fi
}

checkrinetd(){
	count=`ps -ef |grep rinetd |grep -v "grep"|wc -l`
	if [ 0 -lt $count ]
	then
		judgeredis
	else 
		startrinetd
		echo `date +%Y-%m-%d_%H:%M:%S` start >>/home/develop/rinetd/rinetd.log
	fi
	
}
checkrinetd
	

