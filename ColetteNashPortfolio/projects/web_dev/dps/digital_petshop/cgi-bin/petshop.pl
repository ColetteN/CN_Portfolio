#!/usr/bin/perl
use strict;
#
# PROGRAM: 	Digital Petshop Webapp
# AUTHOR: 	Colette Nash
# DATE: 	2015-01
# PURPOSE:	Programming assignment 02
#
# I want meaningful error messages in my browser
use CGI::Carp qw(fatalsToBrowser); # Will print out error lines to browser
use CGI; # Tell perl about the CGI module
CGI::ReadParse();
use Business::CreditCard;
use Date::Calc qw(check_date);
#
# This tells the Web Server what type of data it's dealing with
print "Content-type: text/html\n\n";
#this will hold the input values
our (%in);
#action values
my $actionCustomerDetails='customerdetails';
my $actionPaymentDetails='paymentdetails';
my $scriptName="petshop.pl";
my $scriptPath="https://treebeard.ie/~it.coletten/webauthoring/cgi-bin/$scriptName";
my $purchaseList="/home/it.coletten/cgi-bin/petshop.txt";
my ($action, $cgi); 
$cgi = new CGI;
#customer contact and delivery details from the first input form
my $name=$in{name};
my $surname=$in{surname};
my $email=$in{email};
my $address1=$in{address1};
my $address2=$in{address2};
my $address3=$in{address3};
#customer payment details for the payment input form
my $card_number=$in{card_number};
my $card_name=$in{card_name};
my $card_exp=$in{card_exp};
my $valid_card_type="VISA card";
my $product_code=$in{product_code};
my $quantity=$in{quantity};
my $total=$in{total};
#digipets product codes and prices
my $one=1;
my $two=2;
my %petPrice;
$petPrice{cat_k1}=20;
$petPrice{dog_d2}=20;
$petPrice{fish_f3}=10;
$petPrice{bird_b4}=10;
$petPrice{bunny_r5}=20;
$petPrice{snake_s6}=10;
#Date
my $the_date=localtime(time);
my ($sec,$min,$hour,$day,$month,$year,$wday,$yday,$isdst)=localtime(time);
# 'Constants'
my $year_offset = 1900; # Number of years to bump the $year by to bring it into the 'real' range
my $this_year = $year + $year_offset;
my $next_year = $this_year + 1;

#creating a common <head> section so all my webpages look the same
my $head=<<headEnd;
  <head>
    <link type="text/css" rel="stylesheet" href="style.css"/>
    <title>Digipets: Online Shop</title>
    <link rel="shortcut icon" href="images/logopinkpaw.png"/>
  </head>
  <body>
    <ul id="menu">
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/index.html">Home</a></li>
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/about.html">About</a></li>
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/purchase.html">Purchase</a></li>
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/digipets.html">Digipets</a></li>
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/terms_conditions.html">Terms</a></li>
      <li><a href="https://itcoletten.fachtnaroe.net/webauthoring/contact.html">Contact</a></li>
    </ul>
headEnd

#a second small <head> section with no menu bar, for the validation pages and the non input pages
my $headsml=<<headEnd;
  <head>
    <link type="text/css" rel="stylesheet" href="style.css"/>
    <title>Digipets: Online Shop</title>
    <link rel="shortcut icon" href="images/logopinkpaw.png"/>
  </head>
headEnd

#Trims; takes out leading and trailing spaces (subroutines)
&trim ($name)&&($surname);
&trim ($email);
&trim ($address1)&&($address2)&&($address3);
&trim ($card_number);
&trim ($card_name);
&trim ($card_exp);
&trim ($valid_card_type);
&trim ($product_code);

$action = $cgi->param('action');

#Validation of the customer payment form#
if ($action eq $actionPaymentDetails) {
#credit card validation
  if ( (validate($card_number) != 1) || (cardtype($card_number) ne $valid_card_type) ) {
    print "$headsml <br><p>The Card Number you have provided is Invalid. Please ensure all details are correct.</p>";
    &back;
  }
  if (($card_name eq "") || (($card_name =~ tr/ //) < 1)) {
    print "$headsml <br><p>Please provide the card holders full first and last name.</p>";
    &back;
  }
#testing the  expiry dates of the credit card
  my ($exp_month,$exp_year) = split('/',$card_exp);
  if ( ($exp_year < $this_year) || (($exp_year == $this_year) && ($exp_month < $month)) ) {
    print "$headsml <br><p>Invalid VISA expiry date. The expiry date should read MM/YYYY</p>";
    &back;
  }
  else {
#If all details are correct, then put all the customer and payment details into a central Database
  my %customerData;
      $customerData{FirstName}=$name;
      $customerData{LastName}=$surname;
      $customerData{Address1}=$address1;
      $customerData{Address2}=$address2;
      $customerData{Address3}=$address3;
      $customerData{eMail}=$email;
      $customerData{ccName}=$card_name;
      $customerData{ccNumber}=$card_number;
      $customerData{ccExpiry}=$card_exp;
      $customerData{Product}=$product_code;
      $customerData{Qty}=$quantity;
      $customerData{Price}=$total;
    
  my $record=saveToDatabase (\%customerData);
#For debugging purposes
#print "[$total][$customerData{Price}]\n";

#Sending a confirmation of payment email
  my $email=$cgi->param('email');
  my $sendmail = "| /usr/sbin/sendmail -t"; # -t required for this
  my $subject = "Subject: Thank you for your order\n";
  my $from = "From: it.coletten\@treebeard.ie\n";
  my $contenttype = "Content-Type: text/html; charset=utf-8\n";
  my $messagefile = "< ConfirmPetShop.html";
  my $to;
  $to = "To: $email\n";
  open MSGFILE, $messagefile;
  my @message = <MSGFILE>;
  close MSGFILE;
#make substitutions for our placeholders
  open MAILER, $sendmail;
  print MAILER $to;
  print MAILER $from;
  print MAILER $subject;
  print MAILER $contenttype;
  print MAILER @message;
  print MAILER "\n.\n";
  close MAILER;
  
#The final web page that comes up if all the fields have been filled out correctly
    print "$headsml <br><h2>Thank you for your order.</h2><br><p>You will receive a confirmation of payment email shortly.</p>";
  }
}

#Validation of the customer details form#
elsif ($action eq $actionCustomerDetails) {
  my $errors=0;
  
  if ($name eq "") {
    print "$headsml <br><p>Please provide your first name.</p>";
    &back;
    $errors=1;
  }
  if ($surname eq "") {
    print "$headsml <br><p>Please provide your surname.</p>";
    &back;
    $errors=1;
  }
  if ( ($email eq "") || (($email =~ tr/@//) != 1)  || (($email =~ tr/.//) < 1) ||
  (($email =~ tr/ //) > 0) ) {
    print "$headsml <br><p>The email you have provided is invalid.</p>";
    &back;
    $errors=1;
  }
  if ($address1 eq "") {
    print "$headsml <br><p>Please provide a complete address.</p>";
    &back;
    $errors=1;
  }
  if ($address2 eq "") {
    print "$headsml <br><p>Please provide a complete address.</p>";
    &back;
    $errors=1;
  }
  if ($address3 eq "") {
    print "$headsml <br><p>Please provide a complete address.</p>";
    &back;
    $errors=1;
  }

#Payment html form#
  if ($errors==0){
    my $product_code=$cgi->param('product');
    my $price=$cgi->param('price');
    print <<___ActionPurchase;
<!DOCTYPE html>
    $head
    <h1>Payment Details</h1>
    <p>Please fill out the form below, supplying your payment card details.</p>
    <form action="$scriptName" method="POST">
    <input type="hidden" name="action" value="$actionPaymentDetails">
    <input type="hidden" name="name" value="$name">
    <input type="hidden" name="surname" value="$surname">
    <input type="hidden" name="email" value="$email">
    <input type="hidden" name="address1" value="$address1">
    <input type="hidden" name="address2" value="$address2">
    <input type="hidden" name="address3" value="$address3">
    
    <table style="width:550px">    
    <tr>
    <td style="vertical-align:top">
    <label for="card_number">Card Number*</label>
    <td>
    <input  type="text" name="card_number" id="card_number" $card_number" maxlength="120" size="30">
    </td>
    </tr>
    
    <tr>
    <td style="vertical-align:top">
    <label for="card_name">Card Name*</label>
    <td>
    <input  type="text" name="card_name" id="card_name" $card_name" maxlength="120" size="30">
    </td>
    </tr>
    
    <tr>
    <td style="vertical-align:top">
    <label for="card_exp">Expiry Date*</label>
    <td style="vertical-align:top">
    <input  type="date" name="card_exp" id="card_exp" $card_exp" maxlength="20" size="10">
    </td>
    </tr>
    
    <tr>
    <td style="vertical-align:top">
    <label for="product_code">Product Code*</label>
    <td>
    <input  type="text" name="product_code" value="$product_code" maxlength="20" size="10">
    <input type="hidden" name="product" value="$product_code">
    <input type="hidden" id="price" name="price" value="$price">
    </td>
    </tr>
    
    <tr>
    <td style="vertical-align:top">
    <label for="quantity">Quantity</label>
    </td>
    <td>
    <script type="text/javascript">
      function recalculate(){
	var price = document.getElementById('price').value;
	var qty = document.getElementById('qtychooser').value;
	document.getElementById('total').value=	price * qty;
      }
    </script>
    <select id="qtychooser" id="qtychooser" name="quantity" value="$quantity" onchange="recalculate()">
    <option value="1">One</option>
    <option value="2">Two</option>
    </select>
    </td>
    </tr>
    
    <tr>
    <td style="vertical-align:top">
    <label for="total">Total</label>
    <td>
    <input  type="text" name="total" id="total"  value="$price" maxlength="50" size="10">
    </td>
    </tr>
    
    <tr>
    <td colspan="2" style="text-align:center">
    <input type="submit" value="Submit">
    </td>
    </tr>
    </table>
    </form>
    
    <br>
    <br>
    <ul id="contactinfo"> 
    <li><img src="images/telephone.png" alt="phone"></li>
    <li>Tel: 051-640895</li>
    <li><img src="images/email.png" alt="email"></li>
    <li>Email: info.colettesdigipetshop.ie</li>
    <li><img src="images/facebook.png" alt="facebook"></li>
    <li>Facebook</li>
    </ul>
    
    <div id="footer">
    Copyright © Colette Nash
    </div>
    </body>
    </html>

___ActionPurchase
 }
}
#Customer details html form, default action#
else {
  my $product=$cgi->param('product_code');
  my $price=$petPrice{$product};
  print <<__defaultAction;
<!DOCTYPE html>
  $head
  <h1>Delivery/Contact Details</h1>
  <p>Please fill out the form below, supplying your contact and delivery details.</p>
  <form action="$scriptName" method="POST">
  <input type="hidden" name="action" value="$actionCustomerDetails">
  <input type="hidden" name="price" value="$price">
  <input type="hidden" name="product" value="$product">
  
  <table style="width:550px"> 
  <tr>
  <td style="vertical-align:top">
  <label for="name">First Name*</label>
  <td>
  <input  type="text" name="name" id="name" value="$name" maxlength="50" size="20">
  </td>
  </tr>
  
  <tr>
  <td style="vertical-align:top">
  <label for="surname">Surname*</label>
  <td>
  <input  type="text" name="surname" id="surname" value="$surname" maxlength="50" size="20">
  </td>
  </tr>
  
  <tr>
  <td style="vertical-align:top">
  <label for="email">Email*</label>
  <td>
  <input  type="text" name="email" id="email" value="$email" maxlength="80" size="20">
  </td>
  </tr>
  
  <tr>
  <td style="vertical-align:top">
  <label for="address1">Address*</label>
  <td>
  <input  type="text" name="address1" id="address1" value="$address1" maxlength="120" size="20">
  </td>
  </tr>
  
  <tr>
  <td style="vertical-align:top">
  <label for="address2"></label>
  <td>
  <input  type="text" name="address2" id="address2" value="$address2" maxlength="120" size="20">
  </td>
  </tr>
  
  <tr>
  <td style="vertical-align:top">
  <label for="address3"></label>
  <td>
  <input  type="text" name="address3" id="address3" value="$address3" maxlength="120" size="20">
  </td>
  </tr>
  
  <tr>
  <td colspan="2" style="text-align:center">
  <input type="submit" value="Submit">
  </td>
  </tr>
  </table>
  </form>
  
  <br>
  <br>
  <ul id="contactinfo"> 
  <li><img src="images/telephone.png" alt="phone"></li>
  <li>Tel: 051-640895</li>
  <li><img src="images/email.png" alt="email"></li>
  <li>Email: info.colettesdigipetshop.ie</li>
  <li><img src="images/facebook.png" alt="facebook"></li>
  <li>Facebook</li>
  </ul>
  
  <div id="footer">
  Copyright © Colette Nash
  </div>

  </body>
  </html>
__defaultAction
}
#################################################################################################################################################################
#Subroutines
sub saveToDatabase {
  # need to use the DB interface module
  use DBI;
  # low security credentials
  my $username="student2015";
  my $password="stud2015.3p4h";
  my $db="digitalPetShop";
  my $dbhost="127.0.0.1";
  my ($query, $qh, $dbHandle, $dbconn);
  # define connection details
  $dbconn="dbi:mysql:$db;$dbhost";
  # open connection now
  $dbHandle = DBI->connect($dbconn, $username, $password);
  # get address of data being passed in
  my $dataAddress=shift;
  # cast the data as hash array
  my %data = %$dataAddress;
  my $table="digitalPetShop.studentOrders2015";
  # prepare the query
  # NOTE indentation is used for this only for ease of reading. It wouldn't normally be used.
  $query="INSERT INTO $table (
    FirstName,
    LastName,
    Address1,
    Address2,
    Address3,
    eMail,
    ccName,
    ccNumber,
    ccExpiry,
    Product,
    Qty,
    Price
  ) 
  VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
  # prepare to execute, check syntax
  $qh=$dbHandle->prepare($query);
  # execute (insert) now, keeping return code in $result
  my $result=$qh->execute(
    $data{FirstName},
    $data{LastName},
    $data{Address1},
    $data{Address2},
    $data{Address3},
    $data{eMail},
    $data{ccName},
    $data{ccNumber},
    $data{ccExpiry},
    $data{Product},
    $data{Qty},
    $data{Price},
  );
  # pass the return code back to calling routine
  if ($result == 1) {
    # inserted ok, get record ID num
    $result=$dbHandle->{mysql_insertid}
  }
  # do it
  return $result;
}

#the back link on the validations pages
sub back {
  print "\n<form>\n<input type=\"button\" value=\"Back\"
  onclick=\"history.back()\">\n</form>\n";
}

#this will remove leading and trailing spaces
sub trim($) {
  $_[0] =~ s/^\s+//;
  $_[0] =~ s/^\s+$//;
}