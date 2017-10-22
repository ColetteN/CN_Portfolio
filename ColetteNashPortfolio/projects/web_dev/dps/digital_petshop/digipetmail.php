<!DOCTYPE html>
<html>
  <head>
    <link type="text/css" rel="stylesheet" href="style.css"/>
    <!--Title of site-->
    <title> Digipets: Contact Us</title>
    <link rel="shortcut icon" href="images/logopinkpaw.png"/>
  </head>
  <body>
  <?php
$name = $_POST['name'];
$email = $_POST['email'];
$priority = $_POST['priority'];
$type = $_POST['type'];
$message = $_POST['message'];
$formcontent=" From: $name \n Message: $message";
$recipient = "it.coletten@treebeard.ie";
$subject = "Digital Pet Shop Contact Form";
$mailheader = "From: $email \r\n";
mail($recipient, $subject, $formcontent, $mailheader) or die("Error!");
echo "Thank You! <br>We will reply to your request shortly." . " " . "
<a href='index.html' style='style.css;'>Click here to Return to the Home Page</a>";
?>
  </body>
</html>
