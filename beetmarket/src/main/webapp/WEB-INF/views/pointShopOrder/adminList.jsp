<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 관리</title>

<style>
.page-link {
  color: #444;  
  border-color: #444;
}

.page-item.active .page-link {
 z-index: 1;
 color: #ccc;
 font-weight:bold;
 background-color: #333;
  border-color: #444;
 
}

.custom-checkbox .custom-control-input:checked~.custom-control-label::before{
 	background-color: black;
    border-color: black;   
}

.custom-control-input:checked ~ .custom-control-label::before {
    background-color: #555; /* 중간 회색 */
    border-color: #555; /* 중간 회색 */
}    

.custom-control-label:hover, .detailBtn:hover, .copyBtn:hover {
	cursor: pointer;
}

.page-link:focus, .page-link:hover {
  color: #ccc;
  background-color: #222; 
  border-color: #444;
}

.link-text {
      color: #007bff; /* Bootstrap 기본 링크 색상 */
      text-decoration: underline;
      cursor: pointer;
}
.id:hover {
	cursor: pointer;
	text-decoration: underline;
}
</style>

<link rel="stylesheet" href="/css/pointShopOrder.css">
<link rel="stylesheet" href="/css/checkBax.css">
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>
<script type="text/javascript" src="/js/priceUtils.js"></script>
<script src="/js/dateUtils.js"></script>
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>
<script type="text/javascript">
	
	$(function() {	
		
		$(".refundBtn").click(function() {
			//상품 이름,상품 가격, 주문 번호 ,아이디 입력
			let orderData = $(this).closest(".orderData");
			let pointShopOrderNo = orderData.find(".pointShopOrderNo").text();
			let goodsName = orderData.find(".goodsName").text();
			let orderPoint = numWithoutComma(orderData.find(".orderPoint").text());
			let id = orderData.find(".id").text();
			location = "refund.do?pointShopOrderNo="+pointShopOrderNo+"&goodsName="+goodsName+"&orderPoint="+orderPoint+"&id="+id+
					"&page=${pageObject.page}&perPageNum=${pageObject.perPageNum}&${searchVO.query}";
		});
	
		
		
		
		
	});
</script>

</head>
<body>

	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<ul class="nav nav-tabs mb-3">
		    <li class="nav-item">
		      <a class="nav-link" href="/order/adminList.do" style="color: #03c75a;">일반 상품</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link active" onclick="return false;" href="#">포인트샵</a>
		    </li>
  		</ul>
		
		<h3>주문 관리</h3>
		<!-- 검색을 위한 폼 -->
		<jsp:include page="adminSearch.jsp"/>
		
	</div>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h5 class="m-2"><b>총 <span class="text-primary">${pageObject.totalRow }</span>건</b></h5>		
	
	<!-- 주문 정보 리스트를 보여주는 테이블 -->
	<table class="table">	
		<thead>	
			<tr>			
				<th class="text-center">주문 번호</th>
				<th>카테고리</th>
				<th>상품 코드</th>
				<th>상품 이름</th>
				<th>재고 번호</th>
				<th>결제일</th>
				<th>상품 상태</th>
				<th>아이디</th>
				<th>구매 포인트</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="vo">
				<tr class="orderData">
					<td class="pointShopOrderNo">
						${vo.pointShopOrderNo }						
		 				
					</td>					
					<td>${vo.category }</td>
					<td>${vo.goodsId}</td>
					<td class="goodsName">${vo.goodsName}</td>		
					<td>${vo.stockNo}</td>	
					<td>
						<fmt:formatDate value="${vo.orderDate }" pattern="yyyy-MM-dd hh:mm"/>  
					</td>	
					<td>${vo.stockState}</td>
					
					<td>
						<span class="id" class="dropdown-toggle" data-toggle="dropdown">${vo.id}</span>
						<!-- 아이디 클릭시 나오는 드롭다운 메뉴 -->
						<div class="dropdown-menu">
						    <a class="dropdown-item" href="/member/view.do?id=${vo.id}&admin=1">회원 정보 보기</a>
						</div>
					</td>							
					<td class="orderPoint">
						<fmt:formatNumber value="${vo.orderPoint}"/>					
					</td>					
					<td>
						<!-- 해당 상품의 카테고리가 쿠폰이고 사용전이면 환불 버튼이 생긴다. -->
						<c:if test="${vo.category=='쿠폰' && vo.stockState == '판매완료'}">
							<button class="btn btn-primary btn-sm refundBtn">환불</button>
						</c:if>
					</td>									
				</tr>

				
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination justify-content-center">
		<pageNav:pageNav listURI="adminList.do" pageObject="${pageObject }" query="&${searchVO.query }"></pageNav:pageNav>
	</div>		
</div>



</body>
</html>