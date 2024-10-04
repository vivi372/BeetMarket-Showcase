<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container">
	<!-- 추첨된 ID 표시 -->
	    <div class="result">
	        <h2>당첨된 ID 목록:</h2>
	        <ul>
	            <c:forEach var="vo" items="${winners}">
	                <li>${vo.id}</li> <!-- ID 출력 -->
	            </c:forEach>
	        </ul>
	    </div>	
</div>
</body>
</html>