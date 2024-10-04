<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<style type="text/css">
.dataRow{
	text-align: center;
}
</style>
</head>
<body>
<div class="container">
	<h2>포인트 리스트</h2>
	<table class="table">
		<thead>
			<tr align="center">
				<th>번호</th>
				<th>발급/사용 처</th>
				<th>포인트</th>
				<th>날짜</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${pointList }" var="vo">
				<tr class="dataRow">
					<td>${vo.pointlist_no }</td>
					<td>${vo.point_entity }</td>
					<c:if test="${vo.point_delta < 0}">
						<td style="color:red">${vo.point_delta  }</td>
					</c:if>
					<c:if test="${vo.point_delta == 0}">
						<td >${vo.point_delta  }</td>
					</c:if>
					<c:if test="${vo.point_delta > 0}">
						<td>+${vo.point_delta }</td>
					</c:if>
					<td>${vo.redeemed_date }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
		<pageNav:pageNav listURI="pointList.do" pageObject="${pageObject }"></pageNav:pageNav>
</div>
</body>
</html>