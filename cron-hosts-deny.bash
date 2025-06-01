#!/bin/bash

/home/username/deny.pl > /home/username/host-deny-ips.txt

cp /home/username/host-deny-ips.txt /etc/hosts.deny

# Backup hosts.deny records
cp /home/username/host-deny-ips.txt /home/username/hosts.deny.backup.txt
