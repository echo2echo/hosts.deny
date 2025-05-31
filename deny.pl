#!/usr/bin/env perl

use warnings;
use strict;
use diagnostics;

# Usage: $ sudo ./deny.pl > /etc/hosts.deny
# Or use with $ sudo ./cron-hosts-deny.bash

my @ip = `sudo journalctl -n 2999 --no-pager`;
my %uniq;
my $item;
my @array;

# log records as examples
# Mar 17 18:54:12 joelrader.net postfix/smtpd[19862]: disconnect from unknown[80.94.95.228] ehlo=1 auth=0/1 rset=1 quit=1 commands=3/4
# Mar 19 13:26:44 joelrader.net sshd[29106]: pam_unix(sshd:auth): authentication failure; logname= uid=0 euid=0 tty=ssh ruser= rhost=103.63.25.13
# Connection closed by invalid user  8.220.136.105
# Apr 19 23:38:43 debian sshd[763193]: Received disconnect from 8.213.197.49 port 58040:11: Bye Bye [preauth]
# Apr 19 23:59:59 debian sshd[764198]: Invalid user httpd from 175.206.1.60 port 46423
# Apr 19 23:03:12 debian sshd[761621]: Connection closed by 104.234.115.74 port 53734 [preauth]
# Apr 20 00:50:08 debian sshd[766483]: Disconnected from invalid user test 203.195.68.135 port 46906 [preauth]
# Apr 20 13:28:36 debian sshd[798880]: banner exchange: Connection from 20.168.7.237 port 47368: invalid format


foreach $item (@ip) {

	if ($item =~ m/Connection from (\d+\.\d+\.\d+\.\d+) .*invalid format/) { push(@array, $1); }

	if ($item =~ m/Disconnected from invalid user .* (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }

	if ($item =~ m/Connection closed by (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }

	if ($item =~ m/Invalid user .* from (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }

	if ($item =~ m/Received disconnect from (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }
	
	if ($item =~ m/Failed password.*(\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }
	
	if ($item =~ m/invalid user\s+(\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }

	if ($item =~ m/Connection reset by (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); } 	

	if ($item =~ m/unknown\[(\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); } 
	 
	if ($item =~ m/failure.*rhost=(\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); } 
	 
	if ($item =~ m/Unable to negotiate with (\d+\.\d+\.\d+\.\d+)/) { push(@array, $1); }

}

foreach my $item (@array)
{
	# Populate hash
	$uniq{$item} ++;
}


@array = keys %uniq;
@array = sort @array;

my @deny = `cat /etc/hosts.deny`;

my @deny_array;

my %deny_hash;

foreach $item (@deny) {
	
	if ($item =~ m/ALL:\s+(\d+\.\d+\.\d+\.\d+)/) {

		push(@deny_array, $1);

	}
}

push (@deny_array, @array);

foreach my $item (@deny_array)
{
	# Populate hash
	$deny_hash{$item} ++;
}


@deny_array = keys %deny_hash;
@deny_array = sort @deny_array;


foreach (@deny_array) {

	# Skip addresses so as to not get locked out.  123.123.123.123 used below
	if ( $_ =~ m/123\.123\.123\.123/ ) { next; }
 	# Add copy of previous line with IP additional address changes directly above this line to skip over adding to /etc/hosts.deny file.
	print "ALL: $_\n";	

}
