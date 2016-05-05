<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>Frock Overflow</title>

<!-- Bootstrap Core CSS -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/style.css" rel="stylesheet">
<style>
body {
	padding-top: 70px;
	/* Required padding for .navbar-fixed-top. Remove if using .navbar-static-top. Change if height of navigation changes. */
}
</style>


<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- ************************************Body Tag Begin********************************** -->
<body>




	<!-- ********************************Top Nav Bar**************************** -->
	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<!--  <div class="container">  -->
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a href="index.do"> <img id="logoimage" src="smallicon.png"
				alt="Frock Overflow" style="width: 100px; height: 100px;">
			</a>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1 search-text">
			<ul id="searchbar" class="search-bar">
				<li><span style="color: white">Search by tags:</span></li>
				<form action="searchByTag.do">
					<input type="text" name="searchTags" list="tags"
						placeholder="ex... java" required>
					<datalist id="tags">
						<c:forEach var="tag" items="${sessionScope.tags}">
							<option value="${tag}"></option>
						</c:forEach>
					</datalist>
					<input type="submit" name="submit">
				</form>
			</ul>
			
		</div>
		
			<div class="collapse navbar-collapse navbar-button"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li>
					<input type="button" value="Log In"
						onclick="document.getElementById('login').style.display='block'"><form action="search.do"></form></li> 
						<li>
						<input type="button" Value="Create New User"
						onclick="document.getElementById('user').style.display='block'"><form action="search.do"></form></li> 
						<li>
						<form action="search.do">
				<input type="submit" name="submit" value="View All Questions">
			</form>
			</li>
						<li>
						 <c:if test="${sessionScope.user.type > 1}"> 					
								<form  action="getAllUsers.do" Method="GET" >
								<input  type="submit" value=" Admin Page"
								onclick="location.href='admin.jsp'">
								</form>

						</c:if>

						</li> 

				</ul>
			</div>
		
	
	
		<div id="login" class="w3-container" style="display: none">
			<span id="loginspan"
				onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form class="getUser" action="getUser.do" method="GET"
				name="loginForm" onsubmit="return validateLogin()">
				<input type="email" name="email" placeholder="Email" required>
				<input type="password" name="password" placeholder="Password"
					required> <input type="submit" name="submit">
			</form>
		</div>
		<div id="user" class="w3-container" style="display: none">
			<span id="createuserspan"
				onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form class="adduser" action="addUser.do" method=GET>
				<input type="email" name="email" placeholder="Email" required>
				<input type="password" name="password" placeholder="Password"
					required> <input type="text" name="firstName"
					placeholder="First Name" required> <input type="text"
					name="lastName" placeholder="Last Name" required> <input
					type="text" name="displayName" placeholder="Display Name" required>
				<input type="submit" name="submit" value="Create User">
			</form>

		</div>

		<!--**********************************************USER INFORMATION************************************-->
		<div id="floatleft">
			<ul class="logged">
				<li class="logged">You are currently logged in as: <strong>${sessionScope.user.displayName}</strong></li>
				<c:if test="${!empty invalid}">${invalid}</c:if>
				<c:if test="${sessionScope.user.type != 0}">
					<a href="gotoeditprofile.do">Edit Profile </a>
					<a href="logOut.do"> || Log Out</a>
				</c:if>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	
		<!-- /.container -->
	</nav>

	<br>
	<br>
	<br>
	<br>
	<br>
	<!-- ********************************************** Frock Image ********************************** -->

	<div id="backgroundimage">
	<div id="imageandquestion">
		<h3>
			<img id="frockimage" src="FrockOF.png">
		</h3>
		<h2 id="questionandanswer">Question and Answer Forum</h2>
		<h2 id="line">______________________________________________________</h2>

		<!-- ********************************** Most Recent Question******************************* -->
		<h3 id="question">
			 Most Recent Question Asked: ${question.body}  <br>
		</h3>		
		<h4 id="postedby">Posted By: ${question.user.displayName} on
			${question.timestamp}</h4>

	</div>
	<br>
	<br>
</div>
</body>

</html>
