# hosts.deny

The deny.pl script creates a ulist of IP Address records  to block questionable ssh & ftp connections ( among others ) based on log entries. IP blocking is activated upon entry of a record into the /etc/hosts.deny file.
The deny.pl perl script is used to merge, purge & sort IP addresses to be blocked.

Ubuntu and Debian based Linux distributions are supported.
The requirements to run this script are a Linux distribution with tcp wrapper, perl installed & journalctl, a log monitoring app.

This script employs the /etc/hosts.deny file to block IP addresses.  An /etc/hosts.allow entry overrides /etc/hosts.deny and allows web traffic.
IPs are harvested from journalctl log entries on Linux... 

### Before running these scripts make sure you put your home, work & any other needed public IP addresses in the /etc/hosts.allow file to allow you access to ssh and bypass hosts.deny on your server.
It is very possible to get locked out of your server if your own IP addresses are not in the /etc/hosts.allow file.  Mobile phone IPs can be blocked on one failed attempt to login if an /etc/hosts.allow entry is not posted. Only one failed password attempt is allowed 
before an IP is entered in the hosts.deny file.  Yes, this script is unforgiving.  Maybe change cron entries to a longer period of time than is suggested below.  My suggested cron interval is 30 seconds to update hosts.deny. You could change the update interval to 5 minutes or more to potentially give yourself a little more time to enter a hosts.allow record. 

Use the following example's syntax to enter your own /etc/hosts.allow & /etc/hosts.deny records one at a time...

    ALL: 123.123.123.123

See line 93 of deny.pl and change the IP Address to your home & work addresses.
Add the following additional line near bottom of deny.pl script to skip over adding your personal & work IPs to /etc/hosts.deny file.
The code below references IP address 120.121.123.124 ( ficticious example IP )... "Backslash dot" is used within IP address. 

     if ( $_ =~ m/120\.121\.123\.124/ ) { next; }
 

The cron-hosts-deny.bash file is used for staging /etc/hosts.deny additions and creates a backup of hosts.deny & hosts.allow for securing your IP address assetts.
Enter cron entries as root as follows to update /etc/hosts.deny file every 30 seconds. This bash script needs to run crontab as root. sudo is required by journalctl and copy command.
Make changes to path and filenames to suit. 
 
    * * * * * /home/username/deny/cron-hosts-deny.bash
    * * * * * sleep 30; /home/username/deny/cron-hosts-deny.bash 

To see the number of unique IPs blocked check occasionally with...

      $ wc -l /etc/hosts.deny

That's it.  No need to restart network as /etc/hosts.deny and /etc/hosts.allow file are active on being populated.
This script is useful in combination with firewalls and gives more control over ssh traffic, though not httpd and smtpd services for example as they do not use TCP Wrappers.
It is recommended to use firewalls in combination with /etc/hosts.deny & /etc/hosts.allow files. 



Be careful out there!






The systemd project (which includes journalctl) is licensed under the GNU Lesser General Public License version 2.1 (LGPLv2.1)

Linux is a trademark of Linus Torvalds.

Perl is a Copyright of Larry Wall and may be copied only under the terms of either the Artistic License or the GNU General Public License, which may be found in the Perl 5 source kit.

The Perl script deny.pl, by echo2echo on GitHub.com, is Open Source Software, Copyleft.
