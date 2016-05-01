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
<li>Password:<input type="text" name="password" value="*********">
</li>
<li><input type="hidden" name="user" value= "${user.id}"></input>
</li>
</ul>
</form>

</body>
</html>