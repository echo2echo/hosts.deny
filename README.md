# hosts.deny

The deny.pl script creates a list of IP Addresses to block questionable ssh & ftp connections (and others) based on log entries, with IPs entered in the /etc/hosts.deny file in Ubuntu and Debian based Linux distributions.
Google AI says Fedora, Mint and Arch Linux should also work having journalctl included in their OS and their use of TCP Wrappers.
 
The requirements to run this script are a Linux distribution, Perl installed & journalctl, a log monitoring app.

This script uses the /etc/hosts.deny file to block IP addresses.  An /etc/hosts.allow entry overrides /etc/hosts.deny and allows web traffic.
### Before running scripts make sure you put your home & work public IP addresses in the /etc/hosts.allow file to allow you access to ssh on your server
It is very possible to get locked out of your server if your own IP addresses are not in the /etc/hosts.allow file.  Mobile phone IPs are blocked if an /etc/hosts.allow entry is not posted. 

See line 93 of deny.pl and change the IP Address to your home & work addresses
Add the following additional line near bottom of deny.pl script to skip over adding your personal & work IPs to /etc/hosts.deny file.
Below references IP address 120.121.123.124 (ficticious example ip)... "Backslash dot" used within IP address. 
 
      if ( $_ =~ m/120\.121\.123\.124/ ) { next; }
 
Enter cron entries as root as follows to update /etc/hosts.deny file every 30 seconds. This bash script needs to run as root. sudo is required by journalctl.

    * * * * * /home/username/cron-hosts-deny.bash
    * * * * * sleep 30; /home/username/cron-hosts-deny.bash 

To see the number of unique IPs blocked check occasionally with...

      $ wc -l /etc/hosts.deny

That's it.  No need to restart network as /etc/hosts.deny and /etc/hosts.allow file are active on being populated.
This script is useful in combination with firewalls and give more control over ssh traffic, though not httpd and smtpd services for example.
It is recommended to use firewalls in combnation with /etc/hosts.deny & /etc/hosts.allow files. 
