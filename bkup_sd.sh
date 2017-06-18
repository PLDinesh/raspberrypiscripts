#!/bin/bash

. /home/pi/sh/.config.sh

lock
if [ "$(id -u -n)" != "root" ]
then
 echo "$0:Not executed by root, insufficient access for $(id -u -n)"
else

 cd `dirname $0`

 bkp_dev=/dev/mmcblk0
 bkp_des=/media/WindowsBackup/bkp_pi3
 bkp_tdes=/media/WindowsBackup
 bkp_ofile=0-sdc-img_$(date +%Y%m%d_%H%M%S).img.gz
 bkp_tmp=$bkp_tdes/$bkp_ofile

 mkdir -pv $bkp_des $bkp_tdes

 echo $0:bkp_dev=$bkp_dev,bkp_des=$bkp_des,bkp_tdes=$bkp_tdes,bkp_ofile=$bkp_ofile,bkp_tmp=$bkp_tmp

 dd if=$bkp_dev  | gzip -c > $bkp_tmp

 op=$?

 if [ $op -eq 0 ]
 then
  echo "$0:Successful backup, previous backup files will be deleted."
  rm -v $bkp_des/0-sdc-img_*.gz
  mv -v $bkp_tmp $bkp_des/
  [ $? -eq 0 ] && echo "$0:File movment successfull" && echo "$0:RaspberryPI backup process completed for $bkp_dev! FILE: $bkp_ofile @ $bkp_des/"
 else
  echo "$0:Backup failed for $bkp_dev! Previous backup files untouched."
  rm -f $bkp_tmp
  echo "$0:RaspberryPI backup process failed for $bkp_dev!"
 fi
fi

unlock

exit $op
