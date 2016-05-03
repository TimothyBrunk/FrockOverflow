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
                <a href="index.jsp">
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
			
			<!--**********************************************USER INFORMATION************************************-->
			<div id="floatleft">
			<ul class="logged">
				<li class="logged">You are currently logged in as: <strong>${sessionScope.user.displayName}</strong></li>
			<c:if test="${!empty invalid}">${invalid}</c:if>
			<c:if test="${sessionScope.user.type != 0}"><a href = "gotoeditprofile.do"><em>Edit Profile</em></a></c:if>
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
	<br>
	<br>
	<br>
	<c:if test="${sessionScope.user.type != 0}">
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
						

						<c:if test="${question.status=='Resolved' or question.status=='Answered'}">
							<form action="getAnswers.do" method="GET">
								<input type="hidden" name="id" value="${question.id}"> <input
									id="viewanswers" type="submit" name="view answers"
									value="View Answers">
							</form>
						</c:if>
						<c:if test="${sessionScope.user.type > 1}">
							<form action="removeQuestion.do" method="GET">
								<input type="hidden" name="id" value="${question.id}"> 
								<input type="submit" name="removeQuestion" value="Remove Question">
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

						<h4 id="Question">A: ${answer.body}</h4> Answered by: ${answer.user.displayName}
						On or About: ${answer.timestamp}
						Rating: ${answer.rating}
						<c:if test="${sessionScope.user.type != 0}">
						<form action="voteUp.do" method="POST">
							<input type="hidden" name="answerId" value="${answer.id}">
							<input type="submit" value="Vote Up"></input>
						</form>
						<form action="voteDown.do" method="POST">
							<input type="hidden" name="answerId" value="${answer.id}">
							<input type="submit" value="Vote Down"></input>
						</form></c:if> <br> 
						<c:if test="${answer.status != 'Accepted' && answer.question.user.id == sessionScope.user.id}">
							<form action="acceptAnswer.do" method="GET">
								<input type="hidden" name="answer_id" value="${answer.id}">
								<input type="submit" name="Accept Answer" value="Accept Answer">
							</form>
						</c:if>
						<c:if test="${sessionScope.user.type > 1}">
							<form action="removeAnswer.do" method="GET">
								<input type="hidden" name="id" value="${answer.id}"> 
								<input type="submit" name="removeAnswer" value="Remove Answer">
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
	
</body>
</html>