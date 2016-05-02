<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon"
	href="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRopZtWL58-FuZutGY-IaFC-KRMbTIediMqw5EmyEjqCg5_5twmsA">

<title>FrockOverflow</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/landing-page.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="font-awesome/css/font-awesome.min.css" rel="stylesheet"
	type="text/css">
<link
	href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>


	<!-- Navigation -->
	<nav class="navbar navbar-default navbar-fixed-top topnav"
		role="navigation">
		<div class="container topnav">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="index.jsp">Home</a></li>
					<li>
			
						<button class="w3-btn w3-hover-blue" type="button"
							onclick="document.getElementById('login').style.display='block'">Log
							In</button>
						<button class="w3-btn w3-hover-blue" type="button"
							onclick="document.getElementById('user').style.display='block'">Create
							User</button>
					</li>
					<li>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>




	<!-- Header -->
	<a name="about"></a>
	<div class="intro-header">
		<div class="container"></div>
		<!-- ********************************LOGIN FORM********************************************************** -->
		<div id="login" class="w3-container" style="display: none">
			<span onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form class="getUser" action="getUser.do" method="GET">
				<input type="text" name="email" placeholder="Email"> <input
					type="password" name="password" placeholder="Password"> <input
					type="submit" name="submit">
			</form>
		</div>
		<div id="user" class="w3-container" style="display: none">
			<span onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form class="adduser" action="addUser.do" method=GET>
				<input type="text" name="email" placeholder="Email"> <input
					type="password" name="password" placeholder="Password"> <input
					type="text" name="firstName" placeholder="First Name"> <input
					type="text" name="lastName" placeholder="Last Name"> <input
					type="text" name="displayName" placeholder="Display Name">
				<input type="submit" name="submit" value="Create User">
			</form>

		</div>

		<div class="row">
			<div class="col-lg-12">
				<div class="intro-message">
					<h1>
						<img src="FrockOF.png">
					</h1>
					<h3>Question and Answer Forum</h3>
					<hr class="intro-divider">
					<ul class="list-inline intro-social-buttons">
						<li>
							<!-- *********************************************GET QUESTION BY ID FORM********************************* -->
			<!-- 							<form action="search.do">
			<ul id="searchbuttons">
				<li><input type="submit" name="submit"
					value="View All Questions"></li>
									</li> -->
							<form action="search.do" >
								
								 <input type="submit" name="submit"
									value="Post New Question" class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
							<form action="search.do" >
								
								 <input type="submit" name="submit"
									value="View All Questions" class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
							<br>
						</li>
							<form action="getQuestionByID.do" method="GET">
								<input id="idtext" type="text" name="id"
									placeholder="Search By Question Id" required
									style="width: 200px; height: 40px;" /> <input type="submit"
									value="Search By Question Id" class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
				
						<br>
						<br>
						<li>
							<!-- *******************************************CREATE QUESTION FORM***************************************-->
							<form action="createQuestion.do" method="GET" id="inputtext">
								<textarea class="textbox" maxlength="1000" rows="15"
									form="inputtext"
									placeholder="Please Submit Your Awesome Question" id=""
									type="text" name="questionbox" cols="55" wrap="soft"> </textarea>
								<br> <input type="submit" value="Submit Question"
									class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
						</li>

					</ul>
				</div>
			</div>
		</div>

	</div>
	<!-- /.container -->

	</div>

</body>

</html>
