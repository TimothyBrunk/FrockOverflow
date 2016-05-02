<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Question</title>
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
	<!-- ********************************Top Nav Bar**************************** -->
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
			<form action="search.do">
				<ul class="nav navbar-nav navbar-right">
					<li><button type="button" name="Home"
							onclick="window.location.href='index.jsp'">Home</button></li>
					<li><input type="submit" name="submit"
						value="View All Questions"></li>
					<li><input type="submit" name="submit"
						value="View All Posted Questions"></li>
					<li><input type="submit" name="submit"
						value="View All Answered Questions"></li>
					<li><input type="submit" name="submit"
						value="View All Resolved Questions"></li>
					<li><input type="submit" name="submit"
						value="View All My Questions"></li>
					<li><input type="hidden" name="user" value="${user.id}"></input></li>
				</ul>
			</form>
			<form action="searchByTag.do">
				<input type="text" name="searchTags" list="tags">
				<datalist id="tags"> 
				<c:forEach var="tag" items="${sessionScope.tags}">
				<option value="${tag}"></option>
				</c:forEach>
				</datalist>
				<p><em>For example;</em> java</p>
					<input type="submit" name="submit">
			</form>
<!--**********************************************USER INFORMATION************************************-->
<div>
<h2>User Information</h2>
<p>You are currently logged in as: <strong>${user.displayName}</strong></p>


<!-- ***********************************NAVBAR*********************************************************-->

<form action="editprofile.do">
<ul>
<li>First Name:<input type="text" name="first" value="${user.firstName}">
</li>
<li>Last Name:<input type="text" name="last" value="${user.lastName}">
</li>
<li>Email:<input type="text" name="email" value="${user.email}">
</li>
<li>Display Name:<input type="text" name="display" value="${user.displayName}">
</li>
<li>Password:<input type="text" name="password" placeholder="Password">
</li>
<li><input type="hidden" name="user" value= "${user.id}"></input>
</li>
</ul>
<input type="submit" name="submit" value="Save Changes">
</form>

</body>
</html>