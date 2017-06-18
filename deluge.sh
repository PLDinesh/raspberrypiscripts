#!/bin/bash

. ~/sh/.config.sh

lock

cd `dirname $0`

[ "-$1-" != "--" ] && /home/pi/sh/hhmm.sh '00:01' > /dev/null

date > nohup.out
[ $(ps -ef|grep -v grep|grep -wc 'deluged') -eq 0 ]    && echo Starting deluged            && nohup deluged              2>&1 |logger &
[ $(ps -ef|grep -v grep|grep -wc 'deluge-web') -eq 0 ] && echo Starting deluge-web |logger && nohup deluge-web           2>&1 > /log/deluge-web.log &
[ $(ps -ef|grep 'speed.sh'|grep -vwc grep) -eq 0 ]     && echo Starting speed stat logger  && nohup /home/pi/sh/speed.sh 2>&1 |logger &
#echo "@$0:$(date)"

unlock

[ "-$1-" != "--" ] && pkill deluge.sh

#exit
