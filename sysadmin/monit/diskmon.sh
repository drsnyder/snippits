#!/bin/bash
# vim: set expandtab sw=4 ts=4 sts=4 ft=bash:
function usage() {
   echo 'Usage: $0 -t threshold -e email'
}

th=""
email=""
hostname=`hostname`
args=`getopt t:e: $*`
if test $? != 0
     then
        usage;
        exit 1;
fi

set -- $args
for param
do
  case "$param" in
        -t) shift; th=$1; shift;;
        -e) shift; email=$1; shift;;
  esac
done

if [ "$th" == "" ]; then
     usage;
     exit 1;
fi

if [ "$email" == "" ]; then
     usage;
     exit 1;
fi

percfull=`df -k | grep sda1 | cut -c23- | awk '{ perc = ($2 / $1) * 100 ; print perc; }'`
full=`echo $percfull | cut -d '.' -f1`
if [ $full -gt $th ]; then
    find /home -size +100M -fprintf /tmp/bighome.txt '%-10s %p\n' 2> /dev/null
    cat /tmp/bighome.txt | sort -n | mail -s	"$hostname WARNING disk usage > $th at $full%!" $email
fi
