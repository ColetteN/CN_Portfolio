#!/usr/bin/perl
use strict;
# Program:  validate reservations 2012 (waterfront hotel)
# Object:  Ensure booking details valid before saving to disk
# Author: faROE
# Date: 2012
# Notes:

# we'll need some external modules
use CGI;
use Business::CreditCard;
use Date::Calc qw(check_date);

# program starts here
&open_html;
CGI::ReadParse();

my $the_date=localtime(time);
print "Sample script by <b>Fachtna Roe</b>.\n";
print "<br>Today's Date: $the_date\n<hr>\n";
my ($sec,$min,$hour,$day,$month,$year,$wday,$yday,$isdst)=localtime(time);

# 'Constants'
my $year_offset = 1900; # Number of years to bump the $year by to bring it into the 'real' range
my $this_year = $year + $year_offset;
my $next_year = $this_year + 1;

$month++; # Add 1 to move month into range 1..12

my $MaxPeople=100; # This was used as a constant in 2007, 2009.
my $MinPeople=1; # A booking should be for no less than one person
my $MinRooms=1; # At least 1 room should be booked
my $MaxMonths=6; # Reservations cannot be made for more than 6 months in advance
my $room_fee=75.00; # 
my $permitted = 3; # ratio of children to one adult

# sc = Separator Character used between fields in database records. EOL used between records
my $sc="##";
my $database_file="/home/public/hotelreservations-2012.dat";
my $valid_card_type="VISA card";

our (%in); # %in is used by the CGI object to hold input vals
# Personal details from the input form
my $cname=$in{_cname};
my $cemail=$in{_cemail};
# Reservation details from the form
my $rdate=$in{_rdate};
my $rdays=$in{_rdays};
my $nrooms=$in{_nrooms};
my $adults=$in{_nadult};
my $kids=$in{_nchild};
# VISA details from input form
my $vholder=$in{_visaholder};
my $vnumber=$in{_visanumber};
my $vexpiry=$in{_visaexpiry};

&trim ($cname);
if (($cname eq "" )|| (($cname =~ tr/ //) < 1) ) {
  print "<p><font color=\"#ff0000\">Missing or invalid contact name.</font>";
  &back;
}
else {
  print "<p><b>Reservation details</b>\n";
  print "<p>Name: $cname\n";
}
##########################################################

# Make sure there is an email address with an '@' symbol and at least one '.'

&trim ($cemail);
if ( ($cemail eq "") || (($cemail =~ tr/@//) != 1) || (($cemail =~ tr/.//) < 1) || (($cemail =~ tr/ //) > 0) ) {
  print "<br>\n<font color=\"#ff0000\">Error in email address</font>";
  &back;
}
else {
  print "<br>\neMail: $cemail\n";
}

#####################DATES################################
# check the reservation dates (from rdate field)
my ($rday,$rmonth,$ryear) = split('/',$rdate);
if (!check_date ($ryear, $rmonth, $rday)) {
  print "<br>\n<font color=\"#ff00000\">Invalid reservation date entered.</font>";
  &back;
}

if (($ryear < $this_year) || ($ryear > $next_year)) {
  print "<br>\n<font color=\"#ff00000\">Invalid reservation year.</font>";
  &back;
}
if (($ryear == $this_year) && ($rmonth < $month)) {
  print "<br>\n<font color=\"#ff00000\">Invalid reservation month.</font>";
  &back;
}
if (($ryear == $this_year) && ($rmonth == $month) && ($rday < $day) ) {
  print "<br>\n<font color=\"#ff00000\">Invalid reservation day.</font>";
  &back;
}
if ($ryear == $next_year) {
  $rmonth = $rmonth+12;
}
my $difference=$rmonth - $month;
if ($difference > $MaxMonths) {
  print "<br>\n<font color=\"#ff00000\">You may not make a reservation more than $MaxMonths months in advance.</font>";
  &back;
}
else {
  print "<br>\nReservation date: $rdate\n";
}
##########################################################
# enforce booking restrictions
if (($rdays <=0) || ($rdays >= 15)) {
  print "<br>\n<font color=\"#ff00000\">Days reserved must be in the range 1-14 (up to 2 weeks).</font>";
  &back;
}
else {
  print "<br>\nReserved days: $rdays\n";
}
##########################################################
# enforce booking restrictions
if (($nrooms eq "") || ($nrooms < $MinRooms)) {
  print "<br>\n<font color=\"#ff00000\">At least $MinRooms room must be reserved.</font>";
  &back;
}
else {
  print "<br>\nReserved rooms: $nrooms\n";
}
##########################################################
# enforce booking restrictions
my $total=($adults+$kids);
if ( $total < $MinPeople ) {
  print "<br>\n<font color=\"#ff0000\">An invalid number of people are listed on the form.</font>";
  &back;
}
else {
  # Check if there are kids only being booked
  my $ratio = $kids / $adults; #print "[$ratio]";
  if ( ($kids > 0) && ($adults <=0) ) {
    print "<br>\n<font color=\"#ff0000\">A visit of unattended children is not permitted.</font>";
    &back;
  }
  elsif ($total > $MaxPeople) {
    print "<br>\n<font color=\"#ff0000\">No more than $MaxPeople people may be pre-booked.</font>";
    &back;
  }
  elsif ($ratio>$permitted){
    print "<br>\n<font color=\"#ff0000\">For insurance purposes a least 1 adult is required for every 3 children.</font>";
    &back;
  }
  else {
     print "<br>\nTotal visitors: $total<p><hr>";
     my $total_fee = $room_fee * $rdays * $nrooms;
     my $daily_rate = $room_fee * $nrooms;
     if ($kids==0) {
       $kids = "0";
     }
     print "<br>\nYou have booked $adults adult(s) and $kids children. ";
     print "The daily charge will be &euro;$daily_rate.<p><hr>\n";
  }
}
##########################################################
# check the credit card details
# Ensure a first and last name (minimum) are given - check for a space
&trim($vholder);
if (($vholder eq "") || (($vholder =~ tr/ //) < 1)) {
  print "<br>\n<font color=\"#ff0000\">A full (First+Last) name must be given for the cardholder.</font>";
  &back;
}
else {
  print "<p><b>Payment details</b>\n";
  print "<p>Card holder: $vholder\n";
}
&trim($vnumber);
if ( (validate($vnumber) != 1) || (cardtype($vnumber) ne $valid_card_type) ) {
  print "<br>\n<font color=\"#ff0000\">You have not provided a valid <b>VISA</b> card number.</font>";
  &back;
}
else {
  print "<br />VISA card number: $vnumber\n";
}
##########################################################
# test expiry dates
my ($exp_month,$exp_year) = split('/',$vexpiry);
if ( ($exp_year < $this_year) || (($exp_year == $this_year) && ($exp_month < $month)) ) {
  print "<br>\n<font color=\"#ff0000\">Invalid VISA expiry date.</font>";
  &back;
}
else {
  print "<br />Expiry date: $exp_month/$exp_year.\n";
  print "<br /><br/>We look forward to your visit. Please print a copy of these details for safe keeping.<br/>";
  print "\n<form method=\"post\">\n<input type=\"button\" value=\"Print\" onclick=\"window.print()\">\n</form>\n<hr>";
}

&save_and_post;
##########################################################
# subroutines
sub save_and_post {
     &close_html;
     # All is in order, save the booking.
     my $booking="DEMOSCRIPT-FR".$sc.$cname.$sc.$cemail.$sc.$rdate.$sc.$rdays.$sc.$nrooms.$sc.$adults.$sc.$kids.$sc.$vholder.$sc.$vnumber.$sc.$vexpiry;
     open (DATABASE, ">> $database_file");
     print (DATABASE "$booking\n");
     close (DATABASE);
     &post ($booking);
}

sub back {
  # convenient 'back' link
  print "\n<form>\n<input type=\"button\" value=\"Back\" onclick=\"history.back()\">\n</form>\n";
  &close_html;
  # Sanity semaphore should be redundant with this 'die' subroutine
  # $sane=0;
  die ();
}

sub open_html {
  # standardise header...
  print "Content-type: text/html\n\n";
  print "<html>\n<head>\n<title>2011 Reservation Form Output</title>\n</head>\n<body>\n";
}

sub close_html {
  # ///and footer
  print "\n</body>\n</html>";
}
    
sub post {
  # open a pipe to sendmail to allow printing of an email
  open (MESSAGE,"| /usr/sbin/sendmail -t");
  # print necessary headers 
  print MESSAGE "To: fachtna\@fachtnaroe.com\n";
  print MESSAGE "From: fachtna\@fachtnaroe.com\n";
  print MESSAGE "Reply-To: fachtna\@fachtnaroe.com\n";
  print MESSAGE "Subject: Waterfront Hotel Booking\n\n";
  # now print the data - this could be made look nicer!
  print MESSAGE "\n\nDATA ENTERED [@_]\n\n";
  print MESSAGE ".\n";
  close (MESSAGE);
}

sub trim($) {
  # Remove leading and trailing spaces
  $_[0] =~ s/^\s+//;
  $_[0] =~ s/^\s+$//;
}
