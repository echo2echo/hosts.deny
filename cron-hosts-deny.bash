#!/bin/bash

# Staging with deny.pl perl script to merge purge & sort IP addresses to be blocked
# Change paths and filenames to your own preferences 
# Backups too, below.

/home/username/subfolder/deny.pl > /home/username/subfolder/host-deny-ips.txt
cp /home/username/subfolder/host-deny-ips.txt /etc/hosts.deny

# Backup hosts.deny 
now=`date +"%Y-%m-%d"`
now="backup-hosts-deny-${now}"
cp /etc/hosts.deny /home/username/subfolder/${now}

# Backup hosts.allow
now=`date +"%Y-%m-%d"`
now="backup-hosts-allow-${now}"
cp /etc/hosts.allow /home/username/subfolder/${now}
