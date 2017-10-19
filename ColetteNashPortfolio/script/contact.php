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
echo "Thank you! <br>I will reply to your enquiry shortly." . " " . "
<a href='../index.html' style='../pf_style.css;'>Return to Portfolio</a>";
?>
