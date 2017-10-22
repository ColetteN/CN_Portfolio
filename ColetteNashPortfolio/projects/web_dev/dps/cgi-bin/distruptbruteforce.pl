#!/usr/bin/perl
use strict;
#
# PROGRAM: 	play audio if login is correct
# AUTHOR: 	Colette Nash
# DATE: 	2014-11
# PURPOSE:	Show use of web-app structure
#
# I want meaningful error messages
use CGI::Carp qw(fatalsToBrowser); # Will print out error lines to browser
use CGI; # Tell perl about the CGI module

use constant checkCredentials => '7';
my $checkCredentials=checkCredentials;
use constant expectedUser => 'user';
use constant expectedPass => 'pass';
my $startCounter=10;

our (%in); # Declare the shared variable
my ($action, $username, $password, $counter); 

CGI::ReadParse(); # Tell the module to 'parse' the form
#
print "Content-type: text/html\n\n"; # This tells the Web Server what type of data it's dealing with

$action = $in{action};
if ($action == checkCredentials) {
# Check that input received is expected
  $username=$in{username};
  $password=$in{password};
  $counter=$in{counter};
  if (($username eq expectedUser) && ($password eq expectedPass) && ($counter > 0)) {
    # login has succeeded, print audio code
    print <<____audioCode;
    <!DOCTYPE html>
    <html>
    <head>
    <title>Playing audio</title>
    </head>
    <body>
    <h1>Audio should now be playing</h1>
    <embed src="/~it.coletten/Exhilarate.mp3"
    height="60"
    width="145"
    autostart="true"
    loop="true"
    width="0"
    height="0">
    </embed>
    </body>
    </html>
____audioCode
  }
   else {
     # login has failed
     $counter--;
     print <<_____loginFail;
     <!DOCTYPE html>
     <html>
     <head>
     <title>Login Failed</title>
     </head>
     <body>
     Credentials not recognised.Try again.
     <form action="distruptbruteforce.pl" method="POST">
     <h1>Please login</h1>
     Username: <input type="text" name="username"><br>
     Password: <input type="password" name="password"></br>
     <input type="submit" value="I am necessary too!">
     <input type="hidden" name="action" value="$checkCredentials">
     <input type="hidden" name="counter" value="$counter">
     </form>
     </head>
     </html>
_____loginFail
  }
}
 # this is commented out, as this app doesnt have more options
 #elsif () {
 # }
 else {
  # Here we do the default action
  print <<__loginForm;
  <!DOCTYPE html>
  <html>
  <head>
  <title>Get Login Credentials</title>
  </head>
  <body>
  <form action="distruptbruteforce.pl" method="POST">
  <h1>Please login</h1>
  Username: <input type="text" name="username"><br>
  Password: <input type="password" name="password"></br>
  <input type="submit" value="I am necessary too!">
  <input type="hidden" name="action" value="$checkCredentials">
  <input type="hidden" name="counter" value="$startCounter">
  </form>
  </body>
  </html>
__loginForm
}
  
  

