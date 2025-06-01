#!/bin/bash

# Staging with deny.pl perl script to merge purge sort IP addresses to block
# Change paths and filenames to your own preferences  
/home/username/deny/deny.pl > /home/username/deny/host-deny-ips.txt
cp /home/username/deny/host-deny-ips.txt /etc/hosts.deny


# Backup hosts.deny file
now=`date +"%Y-%m-%d"`
now="backup-hosts-deny-${now}"
cp /home/username/deny/host-deny-ips.txt /home/username/deny/${now}
