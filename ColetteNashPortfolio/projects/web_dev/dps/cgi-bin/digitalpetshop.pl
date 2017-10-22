#!/usr/bin/perl
use strict;
#
# PROGRAM: 	Mailing List Manager
# AUTHOR: 	Colette Nash
# DATE: 	2014-11
# PURPOSE:	Show use of web-app structure
#
# I want meaningful error messages
use CGI::Carp qw(fatalsToBrowser); # Will print out error lines to browser
use CGI; # Tell perl about the CGI module

#action values
my $actionSignUp='signup';
my $actionConfirmSignUp='confirmsignup';
my $actionRemove='remove';
my $actionRequestRemoval='confirmremove';
my $actionShowList='showlist';
my $scriptName="mailman.pl";
my $scriptPath="https://treebeard.ie/~it.coletten/cgi-bin/$scriptName";
my $mailingList="/home/it.coletten/maillist.txt";
my ($action, $cgi); 
$cgi = new CGI;
# creating a common <head> section gives a more consistent look and feel
my $head=<<headEnd;
<head>
<title>Mailing List Manager</title>
<style>
* {
  font-family: Sans Serif;
}
</style>
</head>
headEnd
# This tells the Web Server what type of data it's dealing with
print "Content-type: text/html\n\n";

$action = $cgi->param('action');
if ($action eq $actionSignUp) {
  # if this a signup, generate the confirm signup process
  # generate email with clickable link
  my $email=$cgi->param('email');
  # trim whitespace
  $email =~ s/^\s|\s$//g;
  open FILE, "< $mailingList";
  my @list=<FILE>;
  close FILE;
  # now check for duplicates
  my $alreadyOnList = 0;
  foreach (@list) {
    chomp $_;
    if ($email eq $_) {
      $alreadyOnList=1;
    }
  }
  if ($alreadyOnList == 0) {
    my $sendmail = "| /usr/sbin/sendmail -t"; # -t is required
    my $subject = "Subject: Mailing List Sign-up\n";
    my $from = "From: it.coletten\@treebeard.ie\n";
    my $contenttype = "Content-Type: text/html; charset=utf-8\n";
    #compose the clickable link
    my $confirmationLink =  $scriptPath . "?action=$actionConfirmSignUp&email=$email";
    my $messagefile = "< confirmationemail.html";
    my $to;
    $to = "To: $email\n";
    open MSGFILE, $messagefile;
    my @message = <MSGFILE>;
    close MSGFILE;
    # make substitutions for placeholders
    foreach (@message) {
      $_ =~ s/CLICKABLELINK/$confirmationLink/;
    }
    # ......and print to mail program
    open MAILER, $sendmail;
    print MAILER $to;
    print MAILER $from;
    print MAILER $subject;
    print MAILER $contenttype;
    print MAILER @message;
    print MAILER "\n.\n";
    close MAILER;
    print "We have sent you an email with a confirmation link.";
  }
  else {
    print "You are <b>already</b> on our list.";
  }
}
elsif ($action eq $actionConfirmSignUp) {
  # after confirmation, add email to mailing list file here
  my $email=$cgi->param('email');
  # trim whitespace
  $email =~ s/^\s|\s$//g;
  open FILE, "< $mailingList";
  my @list=<FILE>;
  close FILE;
  # now check for duplicates
  my $alreadyOnList = 0;
  foreach (@list) {
    chomp $_;
    if ($email eq $_) {
      $alreadyOnList=1;
    }
  }
  if ($alreadyOnList == 0) {
    push @list, ($email."\n");
    open FILE, "> $mailingList";
    foreach (@list) {
      print FILE $_;
    }
    close FILE;
    print "You are now on our list.";
  }
  else {
    print "You are<b>already</b> on our list.";
  }
}
elsif ($action eq $actionRemove) {
  # user to be removed from mailing list file
  my $email=$cgi->param('email');
  # first read the existing list
  open FILE, "< $mailingList";
  my @list=<FILE>;
  close FILE;
  #
  my @list2;
  # now copy over to new list all except the removed email
  foreach (@list) {
    chomp $_;
    if ($_ ne $email) {
      push @list2, ($_ . "\n");
  }
}  
# save the new list back to file
  open FILE, "> $mailingList";
  foreach (@list2) {
    print FILE $_;
  }
  close FILE;
  print "You are now removed from our list.";
}
elsif ($action eq $actionRequestRemoval) {
  # generate email with clickable removal link
  # if this a removal, generate the confirm removal process
  # generate email with clickable link
  my $email=$cgi->param('email');
  my $sendmail = "| /usr/sbin/sendmail -t"; # -t required for this
  my $subject = "Subject: Confirm removal from mailing list\n";
  my $from = "From: it.coletten\@treebeard.ie\n";
  my $contenttype = "Content-Type: text/html; charset=utf-8\n";
  my $confirmationRemovalLink = $scriptPath . "?action=$actionRemove&email=$email";
  my $messagefile = "< confirmationremovalemail.html";
  my $to;
  $to = "To: $email\n";
  open MSGFILE, $messagefile;
  my @message = <MSGFILE>;
  close MSGFILE;
  # make substitutions for our placeholders
  foreach (@message) {
    $_ =~ s/CLICKABLELINK/$confirmationRemovalLink/;
  }
  open MAILER, $sendmail;
  print MAILER $to;
  print MAILER $from;
  print MAILER $subject;
  print MAILER $contenttype;
  print MAILER @message;
  print MAILER "\n.\n";
  close MAILER;
  print "We have sent you an email with a confirmation of removal link.";
}
elsif ($action eq $actionShowList) {
  # show whos on the list, provide utilities
  open FILE, "< $mailingList";
  my @list=<FILE>;
  close FILE;
  print <<__showlist0;
  <!DOCTYPE html>
  <html>
  $head
  <body>
  <h1>Mailing List Members</h1>
  <h3>We can add mailing list utilities to our web-app</h3>
  <hr>
  <b>List members:</b><br><br>
  <table>
__showlist0
  foreach (@list) {
    my $removal="$scriptPath" . "?action=$actionRequestRemoval&email=$_";
    print "<tr><td>$_</td><td><a href='$removal'>Request Removal</a></td></tr>";
  }
  print <<__showlist1;
  </table>
  <br><hr>
  <form action="$scriptName" method="POST">
  Mailing list removal.<br>
  <input type="text" name="email"><br>
  <input type="hidden" name="action" value="$actionRequestRemoval">
  <input type="submit" value="Remove me from the List">
  </form>
  </body>
  </html>
__showlist1
}
else {
  # default action
  print <<__defaultAction;
  <!DOCTYPE html>
  <html>
  $head
  <body>
  <form action="$scriptName" method="POST">
  Mailing list sign-up. Please give your email address.
  <input type="text" name="email">
  <input type="hidden" name="action" value="$actionSignUp">
  <input type="submit" value="Add me to the List">
  </form>
  </body>
  </html>
__defaultAction
}