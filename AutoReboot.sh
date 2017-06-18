#!/bin/bash

cd /home/pi/sh
GoogleUP=0
BingUP=0
FaceBookUp=0
RedditUp=0

wget -q --tries=10 --timeout=20 --spider https://www.google.co.in
if [[ $? -eq 0 ]]; then
        GoogleUP=1
else
        echo "Google india Offline"
fi

wget -q --tries=10 --timeout=20 --spider https://www.bing.com
if [[ $? -eq 0 ]]; then
        BingUP=1
else
        echo "Bing Offline"
fi

wget -q --tries=10 --timeout=20 --spider https://www.facebook.com
if [[ $? -eq 0 ]]; then
        FaceBookUp=1
else
        echo "Facebook Offline"
fi

wget -q --tries=10 --timeout=20 --spider  https://www.reddit.com/
if [[ $? -eq 0 ]]; then
        RedditUp=1
else
        echo "Reddit Offline"
fi

if [[ $GoogleUP -eq 0 ]] && [[ $BingUP -eq 0 ]] && [[ $FaceBookUp -eq 0 ]] && [[ $RedditUp -eq 0 ]]
then
        echo "Internet seems down"
        #Your your Code to reboot your router goes here -
        #Sample code to reboot a router - //assumes you have sshpass installed
        { sleep 5;echo "reboot";sleep 5; }| sshpass -p "routerpassword" ssh -o StrictHostKeyChecking=no routeradmin@192.168.1.1
        #replace the routeradmin, routerpassword, 192.168.1.1 with the corresponding details of your router.
else
        echo "Internet seems to be working as expected"
fi

