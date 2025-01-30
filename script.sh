#!/bin/bash
echo " shell script to automate Disk cleanup"
temp_files="/tmp"

old_files="/var/log"

unused_p="autoremove"

log="cleanup.log"

echo "clean started at $(date)" > "$log"

echo "remove temp files"

find $temp_files  -name "*.tmp" -type f -mtime +30 -exec rm {} \; >> "$log"

echo " remove old files"

find $old_files -type f -mtime +30  -exec rm {} \; >> "$log"

echo "remove unused packages"
sudo apt autoremove $unused_p >> "$log"

echo "Cleanup finished at $(date)" >> "$log"

echo " calculating free space" | tee -a "$log"

initial_space=$(df "-h --total | grep 'total' | awk '{print $3}')
current_space=$(df -h --total | grep 'total' | awk '{print $4}')

echo "Initial used space: $initial_space" | tee -a "$log"
echo "Current available space: $current_space" | tee -a "$log"

echo "disk is cleaned successfully"
