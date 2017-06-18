#!/bin/bash


sdt=0
edt=$sdt
while :
do
 sdt=$(cat /sys/class/net/eth0/statistics/rx_bytes)
 echo "[$(date)] Current down-link rate : $((($sdt-$edt)/60000))kB/s"
 edt=$sdt
 sleep 60
# echo
done

