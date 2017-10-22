#!/usr/bin/perl
use strict;

# CODE:		save to central database for digital petshop
# USAGE:	saveToDatabase (\%customerData);
# EXPECTS:	hash array passed by reference (the address of the data)
# RETURNS:	SQL insertion result code

my %sampleData;
$sampleData{FirstName}="Billy";
$sampleData{LastName}="Budd";
$sampleData{Address1}="1 Main Street";
$sampleData{Address2}="Littleton";
$sampleData{Address3}="";
$sampleData{eMail}="me\@here.ie";
$sampleData{ccName}="William Budd";
$sampleData{ccNumber}="4111111111111111";
$sampleData{ccExpiry}="02/2018";
$sampleData{Product}="Laser-guided Love Puppy";
$sampleData{Qty}=1;
$sampleData{Price}=299.99;
    
my $record=saveToDatabase (\%sampleData);
print "Inserted as record #$record\n";

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