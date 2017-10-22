#!/usr/bin/perl
use strict;
use CGI::Carp qw(fatalsToBrowser); # Will print out error liness to browser
use CGI; # Tell perl about the CGI module
CGI::ReadParse(); # Tell the module to 'parse' the form
print "Content-type: text/html\n\n"; # This tells the Web Server what type of data it's dealing with
# Tidy up the variables received.
our (%in);	# Shared variables for use on more than one program
my ($num1, $num2, $num3, $final_answer);	# Use on own computer only
$num1=$in{product_price};
$num2=$in{product_quantity};
$final_answer = $num1 * $num2;
print "<html><body>The total cost is $final_answer.</body></html>";
# End of script 

