# hosts.deny

The deny.pl script creates a list of IP Addresses to block questionable ssh connections, using the /etc/hosts.deny file in Ubuntu and Debian based Linux distributions.

The requirements to run this script are a Linux distribution, Perl installed & journalctl, a log monitoring app.

This script uses the /etc/hosts.deny file to block IP addresses.  
### Make sure you put your home & work IP addresses in the /etc/hosts.allow file to allow you access to ssh on your server
It is possible to get locked out of your server if your own IP addresses are not in the hosts.allow file.  Mobile phone IPs are blocked if an /etc/hosts.allow entry is not posted. 

See line 94 of deny.pl and change the IP Address to your home & work addresses

Enter cron entries as root as follows to update /etc/hosts.deny file every 30 seconds

    * * * * * /home/user/cron-hosts-deny.bash
    * * * * * sleep 30; /home/name/cron-hosts-deny.bash 
        
To see the number of IPs blocked check occasionally with...

      $ wc -l /etc/hosts.deny
