#!/bin/bash 
 
THRESHOLD=90 
EMAIL="admin@example.com" 
 
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " 
" $1 }' | while read output; do 
  usage=$(echo $output | awk '{ print $1}' | sed 's/%//g')   partition=$(echo $output | awk '{ print $2 }')   if [ $usage -ge $THRESHOLD ]; then 
    echo "Running out of space \"$partition ($usage%)\"" | mail -s "Disk Space Alert: $partition ($usage%)" $EMAIL   fi done 
 
