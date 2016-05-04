<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="css/style.css" rel="stylesheet">

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
    <!-- Navigation -->
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a href="index.do">
                <img src="smallicon.png" alt="Frock Overflow" style="width:100px;height:100px;">
            	</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse search-bar" id="bs-example-navbar-collapse-1 search-text">
                <ul class="search-bar">
			<li><span style= "color: white">Search by tags:</span></li>
			<form action="searchByTag.do">
				<input type="text" name="searchTags" list="tags" placeholder= "ex... java">
				<datalist id="tags"> 
				<c:forEach var="tag" items="${sessionScope.tags}">
				<option value="${tag}"></option>
				</c:forEach>
				</datalist>
					<input type="submit" name="submit">
			</form>
				</ul>
			</div>
			<form action="search.do">
			<div class="collapse navbar-collapse navbar-button" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
    
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
				</div>
			</form> 
			</div>
		</nav>	
<!--**********************************************USER INFORMATION************************************-->
<br>
<br>
<br>
<br>
<br>

<div id="admin-user">
<c:forEach var="user" items="${user.displayName }"

<!-- ***********************************NAVBAR*********************************************************-->

<form action="editprofile.do">
<ul>
<li>First Name:<input type="text" name="firstName" value="${user.firstName}">
</li>
<li>Last Name:<input type="text" name="lastName" value="${user.lastName}">
</li>
<li>Email:<input type="text" name="email" value="${user.email}">
</li>
<li>Display Name:<input type="text" name="displayName" value="${user.displayName}">
</li>
<li>Password:<input type="password" name="password" placeholder="Password">
</li>
<li><input type="hidden" name="id" value= "${user.id}"></input>
</li>
</ul>
<input type="submit" name="submit" value="Save Changes">
<form action="logOut.do">
<input type="submit" name="submit" value="Log Out">
<a href="index.jsp"></a> 
</form>
</form>
</div>
<c:forEach var="question" items="${updatedQuestionList}">
		<article id="${question.id}">
			<div class = "text-body">
			<h4>Q: ${question.body}</h4>
			<c:forEach var="tag" items="${question.tags}">
				<form action="searchByTag.do" method="GET">
					<input class="tagLink" type="submit" name="searchTags" value="${tag.body}">
				</form>
			</c:forEach>
</body>
</html>