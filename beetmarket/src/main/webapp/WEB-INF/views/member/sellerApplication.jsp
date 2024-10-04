<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 신청 조회</title>
<script type="text/javascript">
$(function(){
	// 이벤트 처리
	$(".statusTal").click(function(){
		let id = $(this).closest(".dataRow").find(".id").text();
		console.log(id);
		location="changeSeller.do?id="+id+"&gradeNo=5&is_pending=승인";
	});
	$(".cansel").click(function(){
		let id = $(this).closest(".dataRow").find(".id").text();
		console.log(id);
		location="changeSeller.do?id="+id+"&is_pending=취소&gradeNo=1";
	});	
});
</script>
</head>
<body>
<div class="container">
	<table class="table">
		<thead>
		<tr>
			<th>배송비</th>
			<th>무료 배송 최소 금액</th>
			<th>상점이름</th>
			<th>아이디</th>
			<th>승인버튼</th>
			<th>취소버튼</th>
		</tr>
		</thead>
		<tbody>
			<c:if test="${empty sellerList }">
				<h2>판매자 승인 대기자가 없습니다!</h2>
			</c:if>
			<c:forEach items="${sellerList }" var="vo">
			<c:if test="${vo.is_pending == '취소' }">
				<tr class="dataRow" style="text-decoration-line: line-through;">
					<td>${vo.merchant_delivery }</td>
					<td>${vo.free_ship_limit }</td>
					<td>${vo.store_name }</td>
					<td class="id">${vo.id }</td>
					<td>취소된 판매자 신청입니다.</td>
				</tr>
			</c:if>
			<c:if test="${vo.is_pending == '승인' }">
				<tr class="dataRow" style="text-decoration-line: line-through;">
					<td>${vo.merchant_delivery }</td>
					<td>${vo.free_ship_limit }</td>
					<td>${vo.store_name }</td>
					<td class="id">${vo.id }</td>
					<td>승인 판매자 신청입니다.</td>
				</tr>
			</c:if>
			<c:if test="${vo.is_pending == '승인대기' }">
				<tr class="dataRow">
					<td>${vo.merchant_delivery }</td>
					<td>${vo.free_ship_limit }</td>
					<td>${vo.store_name }</td>
					<td class="id">${vo.id }</td>
					<td><button type="button" class="btn btn-danger statusTal">승인</button></td>
					<td><button type="button" class="btn btn-danger cansel">취소</button></td>
				</tr>
			</c:if>
			</c:forEach>
		</tbody>
	</table>
<pageNav:pageNav listURI="sellerApplication.do" pageObject="${pageObject }"></pageNav:pageNav>
</div>
</body>
</html>