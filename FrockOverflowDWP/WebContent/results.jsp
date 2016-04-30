<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="css/bootstrap.css" type="text/css" rel="stylesheet">
<title>Question</title>
</head>
<body>
<!--**********************************************USER INFORMATION************************************-->
<div>
<h2>User Information</h2>
<p>You are currently logged in as: <strong>${user.displayName}</strong></p>
<c:if test="${! empty userQuestions}">
<h2>Questions asked by ${user.displayName}</h2>
<ul>
<c:forEach var="question" items="${userQuestions}">
<li>
${question.body}
</li>
</c:forEach>
</ul>
</c:if>
</div>

<!-- ***********************************NAVBAR*********************************************************-->
<form action="search.do">
<ul>
<li><input type="submit" name="submit" value="View All Questions">
</li>
<li><input type="submit" name="submit" value="View All Posted Questions">
</li>
<li><input type="submit" name="submit" value="View All Answered Questions">
</li>
<li><input type="submit" name="submit" value="View All Resolved Questions">
</li>
</ul>
</form>

<!-- ******************************POST A QUESTION FORM DIV********************************************-->
<button onclick="document.getElementById('questionFormDiv').style.display='block'">
Try Your Luck, Sucka (Post a Question)</button>
<div id="questionFormDiv" style="display:none">
<span onclick="this.parentElement.style.display='none'"
class="w3-closebtn">&times;</span>
<form action="createQuestion.do" method="GET">
<textarea cols="100" rows="10" name="body"></textarea>	
<input type="submit" name="post">
</form>
</div>

<!-- *******************************************QUESTION LIST*******************************************-->
<c:if test="${! empty message}">
<h4>${message}</h4>
</c:if>
<c:if test="${! empty updatedQuestionList}"> <!-- UPDATED QUESTIONS LIST -->
<h2>Questions</h2>
<ul>
<c:forEach var="question" items="${updatedQuestionList}">
<li>
<div class="questionBlock">
${question.user.displayName} ${question.timestamp}<br>
Status: ${question.status}<br>
${question.body}

<c:if test="${question.status=='Resolved' or question.status=='Answered'}">
<form action="getAnswers.do" method="GET">
<input type="hidden" name="id" value="${question.id}">
<input type="submit" name="view answers" value="view answers">
</form>
</c:if>
</div>

<c:if test="${user.type != 0}">
<button onclick="document.getElementById('postAnswerFor${question.id}').style.display='block'">
Answer This Question</button>
<div id="postAnswerFor${question.id}" style="display:none">
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

<c:if test="${! empty answersByQ}"> <!-- LIST OF ANSWERS BY QUESTION -->
<h2>Here are all the Answers for that Question!</h2>
<div class="fullQuestionBlock">
<h3>Q: ${answeredQuestion.body}</h3>
Asked by: ${answeredQuestion.user.displayName}        On or About: ${answeredQuestion.timestamp}
<ul>
<c:forEach var="answer" items="${answersByQ}">
<li>
<div class="questionBlock">
Answered by: ${answer.user.displayName}             On or About: ${answer.timestamp}<br>
A: ${answer.body}

<c:if test="${answer.status != 'Accepted' && answer.question.user.id == sessionScope.user.id}">
<form action="acceptAnswer.do" method="GET">
<input type="hidden" name="answer_id" value="${answer.id}">
<input type="submit" name="Accept Answer" value="Accept Answer">
</form>
</c:if>

</div>
</li>
</c:forEach>
</ul>
</div>
</c:if>

</body>
</html>