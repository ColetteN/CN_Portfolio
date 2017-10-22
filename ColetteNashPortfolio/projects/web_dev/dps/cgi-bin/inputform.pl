#!/usr/bin/perl
use strict;
use CGI::Carp qw(fatalsToBrowser); # Will print out error liness to browser
use CGI; # Tell perl about the CGI module
CGI::ReadParse(); # Tell the module to 'parse' the form
print "Content-type: text/html\n\n"; # This tells the Web Server what type of data it's dealing with
# Tidy up the variables received.
our (%in);	# Shared variables for use on more than one program
my ($selectedValue, $radioValue, $user, $pass);	# List variables

$selectedValue=$in{select};
$radioValue=$in{myradio};
$user=$in{username};
$pass=$in{password};

print "<html><body>
<h1>You entered:</h1>
<p>Username: $user</p>
<p>Password: $pass</p>
<p>From select: $selectedValue</p>
<p>From radio: $radioValue</p>
</body></html>";
# End of script 
