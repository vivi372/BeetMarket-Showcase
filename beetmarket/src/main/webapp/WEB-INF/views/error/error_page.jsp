<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page session="false" import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러 페이지</title>
</head>
<body>
	<h4>${exception.message }</h4>
	
	<ul>
		<c:forEach items="${exception.stackTrace }" var="stack">
			<li>${stack }</li>
		</c:forEach>
	</ul>
</body>
</html>