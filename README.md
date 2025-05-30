# hosts.deny

The deny.pl script creates a list of IP Addresses to be used in the /etc/hosts.deny file in the Ubuntu and Debian based Linux distributions.

The requirements to run this script are a linux distribution. Perl installed & journalctl, a log monitoring app.

This script uses the /etc/hosts.deny file to block IP addresses.  
### Make sure you put your home/work IP addresses in the /etc/hosts.allow file to allow you access to ssh on your server
It is possible to get locked out of your server if your IP is not in the hosuts.allow file.  
