## General Config

export USER=$(id -u -n)

l_file=/lock/$(basename $0).lock

#echo l_file=$l_file

lock () {
 find $l_file -cmin +120 -exec rm -f {} + 2>/dev/null
 if [ -e $l_file ]
 then
  echo $l_file file exists
  exit 12
 fi
 date > $l_file
}

unlock () {
 [ -e $l_file ] && rm -f $l_file 
}

genpasswd () {
        local l=$1
        if [ "$l" == "" ]
                then
                        p1=`tr -dc 0-1 < /dev/urandom |head -c1|xargs`
                        if [ "$p1" == "0" ]
                        then
                                a=10
                        else
                                a=`tr -dc 1-6 < /dev/urandom |head -c1|xargs`
                        fi
                        l=$p1$a
                fi
                tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

alias gpasswd='genpasswd'
