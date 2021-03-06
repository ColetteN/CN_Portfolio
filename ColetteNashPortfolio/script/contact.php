<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Colette Nash Portfolio</title>
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="../style/pf_style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<!--Meta data used for Search Engine Optimisation-->
<meta name="keywords" content="Colette Nash, Web Developer, Year 3 Creative Multimedia">
<meta name="description" content="Colette Nash, Web Developer, Websites, Web Design">
<!--Logo image in the browser tab-->
<link rel="icon" href="../images/sample_logo1.png">
<script src="../script/pf_script.js" type="text/javascript"></script>
</head>
<body>
  <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
      <div class="container-fluid">

          <div class="navbar-header">
          <!--The button menu for mobile devices-->
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                  <span class="sr-only">Toggle navigation</span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
                  <span class="icon-bar"></span>
              </button>
              <!--Branding with space for a logo image-->
              <a class="navbar-brand" href="index.html">
                <img src="../images/sample_logo1.png" alt="Colette Nash" style="margin-top:-12px; margin-right:80%" width="80px" height="80px"></a>
                  <ul class="nav navbar-nav navbar-left">
                    <li><h1 style="font-size:22px; color:white; margin-top:15px; margin-right:25%;">Colette Nash Portfolio</h1></li>
                      <li><a class="btn btn-social-icon btn-twitter"><span class="fa fa-twitter"></span></a></li>
                    		<li><a class="btn btn-social-icon btn-google"><span class="fa fa-google"></span></a></li>
                          <li><a class="btn btn-social-icon btn-github"><span class="fa fa-github"></span></a></li>
                            <li><a class="btn btn-social-icon btn-linkedin"><span class="fa fa-linkedin"></span></a></li>
                  </ul>
          </div><!--Close the navbar header left-->
  			<!--Menu nav on RHS-->
          	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              	<ul class="nav navbar-nav navbar-right">
                  <li class="dropdown">
                      <a class="dropdown-toggle" data-toggle="dropdown" href="../index.html">Portfolio<span class="caret"></span></a>
                          <ul class="dropdown-menu">
                            <li><a href="../index.html#web">Web Development</a></li>
                              <li><a href="../index.html#code">Programming</a></li>
                                <li><a href="../index.html#visual">Visual Design</a></li>
                           </ul>
                      </li>
  					        <li><a href="../about.html">About</a></li>
  						        <li><a href="../contact.html">Contact</a></li>

              	</ul>
          	</div><!--Close the navbar collapse-->

      	</div><!--Close the container-->
  </nav><!--Close the navbar navbar-default navbar-fixed-top-->

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
echo "<br/><br/><br/><br/> <p id="narrow">Thank you for your message! <br> I will be in touch shortly
<br/><br/><a href="../index.html" class="btn btn-default" role="button">Back to Portfolio</a></p>
<br/><br/><br/><br/><br/><br/><br/><br/>

<!--Footer--><hr>
<div class="container">
	<div class="row">
    	<footer class="col-sm-12">
        <a class="btn btn-social-icon btn-twitter"><span class="fa fa-twitter"></span></a>
          <a class="btn btn-social-icon btn-google"><span class="fa fa-google"></span></a>
            <a class="btn btn-social-icon btn-github"><span class="fa fa-github"></span></a>
              <a class="btn btn-social-icon btn-linkedin"><span class="fa fa-linkedin"></span></a>
                <p>Copyright © Colette Nash</p>
                  <img src="../images/logo1.png" alt="Colette Nash" width="50px" height="50px">
        </footer>
    </div>
</div>
<br>
</body>
</html>
