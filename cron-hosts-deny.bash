#!/bin/bash

# Change paths to local settings
/home/username/deny/deny.pl > /home/username/deny/host-deny-ips.txt
cp /home/username/deny/host-deny-ips.txt /etc/hosts.deny


# Backup hosts.deny records
now=`date +"%Y-%m-%d"`
now="backup-hosts-deny-${now}"
cp /home/username/deny/host-deny-ips.txt /home/username/deny/${now}
