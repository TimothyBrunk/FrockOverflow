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
					<li><input type="hidden" name="user" value="${user.id}"></input>
					</li>
				</ul>
			</form>
			<!--**********************************************USER INFORMATION************************************-->
			<ul class="logged">
				<li class="logged">You are currently logged in as: <strong>${user.displayName}</strong></li>
			</ul>
		</div>
		<!-- /.navbar-collapse -->
	</div>
	<!-- /.container --> </nav>

		<!-- ******************************POST A QUESTION FORM DIV********************************************-->
		<br>
		<br>
		<br>
		<br>
		<button id="postquestion"
			onclick="document.getElementById('questionFormDiv').style.display='block'">
			Try Your Luck, Sucka (Post a Question)</button>
		<div id="questionFormDiv" style="display: none">
			<span onclick="this.parentElement.style.display='none'"
				class="w3-closebtn">&times;</span>
			<form action="createQuestion.do" method="GET">
				<textarea cols="100" rows="10" name="body"></textarea>
				<input type="submit" name="post">
			</form>
		</div>

		<!-- *******************************************QUESTION LIST*******************************************-->
		<c:if test="${! empty message}">
			<h4 id="questionBlock">${message}</h4>
		</c:if>
		<c:if test="${! empty updatedQuestionList}">
			<!-- UPDATED QUESTIONS LIST -->
			<ul id="question">
			<li><h2 id="Question">Questions:</h2></li>
			</ul>
			<ul id="questionBlock" >
				<c:forEach var="question" items="${updatedQuestionList}">
					<li>
						<div id="questionBlock">
							<h4 id="questionBlock">Q: ${question.body}</h4>
						
							Posted By: ${question.user.displayName} ${question.timestamp}<br>
							Status: ${question.status}<br> 

							<c:if
								test="${question.status=='Resolved' or question.status=='Answered'}">
								<form action="getAnswers.do" method="GET">
									<input type="hidden" name="id" value="${question.id}">
									<input id="viewanswers" type="submit" name="view answers" value="View Answers">
								</form>
							</c:if>
						</div> <c:if test="${user.type != 0}">
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
				<h3 id="questionBlock">Q: ${answeredQuestion.body} </h3>
				<p id="questionBlock">Asked by: ${answeredQuestion.user.displayName} On or About:
				${answeredQuestion.timestamp} </p> <br>

				<ul id="question">
					<c:forEach var="answer" items="${answersByQ}">
						<li id="answerBlock">

							<h4>A: ${answer.body} </h4> 

							Answered by:
							${answer.user.displayName} On or About: ${answer.timestamp} 
							<form action="voteUp.do" method="POST"> <input type="submit" value="Vote Up"></input></form>							
							<form action="voteDown.do" method="POST"> <input type="submit" value="Vote Down"></input></form>
							<br> <c:if
								test="${answer.status != 'Accepted' && answer.question.user.id == sessionScope.user.id}">
								<form action="acceptAnswer.do" method="GET">
									<input type="hidden" name="answer_id" value="${answer.id}">
									<input type="submit" name="Accept Answer" value="Accept Answer">
								</form>
							</c:if>
			
			</li>
			</c:forEach>
			</ul>
	</div>
	</c:if>
</body>
</html>