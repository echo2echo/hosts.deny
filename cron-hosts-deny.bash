#!/bin/bash

/home/name/deny.pl > /home/name/host-deny-ips.txt

cp /home/name/host-deny-ips.txt /etc/hosts.deny
