<?php
$name = $_POST['name'];
$email = $_POST['email'];
$priority = $_POST['priority'];
$type = $_POST['type'];
$message = $_POST['enquiry'];
$formcontent=" From: $name \n Message: $message";
$recipient = "colettenash.webdeveloper@gmail.com";
$subject = "Portfolio Contact Form";
$mailheader = "From: $email \r\n";
mail($recipient, $subject, $formcontent, $mailheader) or die("Error!");
echo "<br>Thank you for your enquiry! <br>I will send you a reply shortly .......
<a href='../index.html' style='../style/pf_style.css;'>Return to Portfolio</a>";
?>
