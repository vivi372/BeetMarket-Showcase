<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 리스트</title>
</head>
<body>
<div class="container">
	<table class="table">
		<thead>
			<tr align="center">
			<th>이미지</th>
			<th>쿠폰 명</th>
			<th>할인 율</th>
			<th>수량</th>
			</tr>
		</thead>
		<tbody align="center">
		<c:if test="${ !empty couponList}">
		    <c:forEach items="${couponList}" var="coupon">
		        <tr class="dataRow">
		        <td> <img src="${coupon.goodsImage }" style="width: 55px; height: 55px;"> </td>
		            <td>${coupon.goodsName }</td>
		            <td>+${coupon.discountRate }</td>
		            <td>${coupon.goodsStock }</td>
		        </tr>
		    </c:forEach>
		</c:if>
		<c:if test="${empty couponList}">
			<tr>
				<td><h2>보유중인 쿠폰이 없습니다!</h2></td>
			</tr>
		</c:if>
		</tbody>

	</table>
</div>
</body>
</html>