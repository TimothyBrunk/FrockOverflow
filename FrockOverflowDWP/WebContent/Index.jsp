<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    
<body id="backgroundimage" >

<div class="top"> 
<img  src="FrockOF.png" height="200" width="900" > </div>





	<!-- ********************************Top Nav Bar**************************** -->
	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				 <a href="index.jsp">
                <img src="smallicon.png" alt="Frock Overflow" style="width:100px;height:100px;">
            	</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1 search-text">
				<ul class="nav navbar-nav">

				</ul>

			</div>
			<form action="search.do">
				<div class="collapse navbar-collapse navbar-button"
					id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav">

						<li>
						<button 
							onclick="document.getElementById('login').style.display='block'">Log
							In</button>
						<button type="button" name="submit"
								onclick="document.getElementById('user').style.display='block'">Create
								New User</button>
					</ul>
				</div>
			</form>
		</div>
		<div id="login" class="w3-container" style="display: none">
			<span id="loginspan" onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form class="getUser" action="getUser.do" method="GET">
				<input type="text" name="email" placeholder="Email"> <input
					type="password" name="password" placeholder="Password"> <input
					type="submit" name="submit">
			</form>
		</div>
		<div id="user" class="w3-container" style="display: none">
			<span id="createuserspan"
				onclick="this.parentElement.style.display='none'"
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

		<!--**********************************************USER INFORMATION************************************-->
		<div id="floatleft">
			<ul class="logged">
				<li class="logged">You are currently logged in as: <strong>${sessionScope.user.displayName}</strong></li>
				<c:if test="${!empty invalid}">${invalid}</c:if>
				<c:if test="${sessionScope.user.type != 0}">
					<a href="gotoeditprofile.do">Edit Profile   </a>
					<a href="logOut.do">   Log Out</a>
				</c:if>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>

	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<h3 id="questionandanswer" >Question and Answer Forum</h3>
	<%-- <c:if test="${sessionScope.user.type != 0}">
		<button id="postquestion"
			onclick="document.getElementById('questionFormDiv').style.display='block'">
			Try Your Luck, Sucka (Post a Question)</button>
		<div id="questionFormDiv" style="display: none">
			<span onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form action="createQuestion.do" method="GET">
				<textarea cols="100" rows="10" name="body"></textarea>
				Add keywords:<input type="text" name="keywords"> <input
					type="submit" name="post">
			</form>
		</div>
	</c:if>

	<!-- *******************************************QUESTION LIST*******************************************-->
	<c:if test="${! empty message}">
		<h4 id="questionBlock">${message}</h4>
	</c:if>
	<c:if test="${! empty updatedQuestionList}">
		<!-- UPDATED QUESTIONS LIST -->
		<ul id="question">
			<li><h2 id="Question">Questions:</h2></li>
		</ul>
		<ul id="questionBlock">
			<c:forEach var="question" items="${updatedQuestionList}">
				<li>
					<div id="questionBlock">
						<h4 id="questionBlock">Q: ${question.body}</h4>

						Posted By: ${question.user.displayName} ${question.timestamp}<br>
						Status: ${question.status}<br>


						<c:if
							test="${question.status=='Resolved' or question.status=='Answered'}">
							<form action="getAnswers.do" method="GET">
								<input type="hidden" name="id" value="${question.id}"> <input
									id="viewanswers" type="submit" name="view answers"
									value="View Answers">
							</form>
						</c:if>
						<c:if test="${sessionScope.user.type > 1}">
							<form action="removeQuestion.do" method="GET">
								<input type="hidden" name="id" value="${question.id}"> <input
									type="submit" name="removeQuestion" value="Remove Question">
							</form>
						</c:if>
					</div> <c:if test="${sessionScope.user.type != 0}">
						<button id="viewanswers"
							onclick="document.getElementById('postAnswerFor${question.id}').style.display='block'">
							Answer This Question</button>
						<div id="postAnswerFor${question.id}" style="display: none">
							<span onclick="this.parentElement.style.display='none'"
								class="w3-closebtn">&times;</span>
							<form action="postAnswer.do" method="GET">
								<textarea cols="100" rows="10" name="body"></textarea>
								<input type="hidden" name="question_id" value="${question.id}">
								<input type="submit" name="post">
							</form>
						</div>
					</c:if>
				</li>
			</c:forEach>
		</ul>
	</c:if>

	<c:if test="${! empty answersByQ}">
		<!-- LIST OF ANSWERS BY QUESTION -->
		<h2 id="Question">Here are all the Answers for that Question!</h2>
		<div class="questionBlock">
			<h3 id="questionBlock">Q: ${answeredQuestion.body}</h3>
			<p id="questionBlock">Asked by:
				${answeredQuestion.user.displayName} On or About:
				${answeredQuestion.timestamp}</p>
			<br>
			<ul id="question">
				<c:forEach var="answer" items="${answersByQ}">
					<li id="answerBlock">

						<h4 id="Question">A: ${answer.body}</h4> Answered by:
						${answer.user.displayName} On or About: ${answer.timestamp}
						Rating: ${answer.rating} <c:if
							test="${sessionScope.user.type != 0}">
							<form action="voteUp.do" method="POST">
								<input type="hidden" name="answerId" value="${answer.id}">
								<input type="submit" value="Vote Up"></input>
							</form>
							<form action="voteDown.do" method="POST">
								<input type="hidden" name="answerId" value="${answer.id}">
								<input type="submit" value="Vote Down"></input>
							</form>
						</c:if> <br> <c:if
							test="${answer.status != 'Accepted' && answer.question.user.id == sessionScope.user.id}">
							<form action="acceptAnswer.do" method="GET">
								<input type="hidden" name="answer_id" value="${answer.id}">
								<input type="submit" name="Accept Answer" value="Accept Answer">
							</form>
						</c:if> <c:if test="${sessionScope.user.type > 1}">
							<form action="removeAnswer.do" method="GET">
								<input type="hidden" name="id" value="${answer.id}"> <input
									type="submit" name="removeAnswer" value="Remove Answer">
							</form>
						</c:if>

					</li>
				</c:forEach>
			</ul>
		</div>
	</c:if>


	<!-- jQuery Version 1.11.1 -->
	<script src="js/jquery.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>
 --%>
</body>
</html>











<!-- **************************************OLD index.jsp code Don't Delete Until We're Good******* -->












<%-- <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.*" %>

<

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
    <link href="css/style.css" rel="stylesheet">
    
	href="http://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
<!-- <script type="text/javascript">
    function myfunc () {
        var frm = document.getElementById("question");
        frm.submit();
    }
    window.onload = myfunc;
</script> -->
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
					<li><button type="button" name="Home"
							onclick="window.location.href='index.jsp'">Home</button></li>
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
		<h1>
			<img src="FrockOF.png">
			<h3 id="questionandanswer">Question and Answer Forum</h3>
					<hr class="intro-divider">
		</h1>
		
		<div class="row">
			<div class="col-lg-12">
				
					<ul class="list-inline intro-social-buttons">
						<li>
							<!-- *********************************************GET QUESTION BY ID FORM********************************* -->
							<!-- 							<form action="search.do">
			<ul id="searchbuttons">
				<li><input type="submit" name="submit"
					value="View All Questions"></li>
									</li> -->
							<form action="search.do">

								<input type="submit" name="submit" value="Post New Question"
									class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
							<form action="search.do">

								<input type="submit" name="submit" value="View All Questions"
									class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form> <br>
						</li>
						<!-- 	<form action="getQuestionByID.do" method="GET">
								<input id="idtext" type="text" name="id"
									placeholder="Search By Question Id" required
									style="width: 200px; height: 40px;" /> <input type="submit"
									value="Search By Question Id" class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form> -->

						<br>
						<br>
						<li>
							<!-- *******************************************CREATE QUESTION FORM***************************************-->
							<!-- <form action="createQuestion.do" method="GET" id="inputtext">
								<textarea class="textbox" maxlength="1000" rows="15"
									form="inputtext"
									placeholder="Please Submit Your Awesome Question" id=""
									type="text" name="questionbox" cols="55" wrap="soft"> </textarea>
								<br> <input type="submit" value="Submit Question"
									class="btn btn-default btn-lg"><i
									class="fa fa-github fa-fw"></i> <span class="network-name"></span>
							</form>
						</li> -->
						
						<form id="recentQuestion" action="getMostRecentQuestion.do" method="GET" id="question" > 
						Q: ${question.body}
						</form> 
						

					</ul>
				</div>
			</div>
		</div>

	</div>
	<!-- /.container -->

	</div>

</body>

</html>
 --%>