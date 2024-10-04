<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트샵 구매 내역</title>
<style type="text/css">
.rect-with-half-circle {
	padding: 10px;
  position: relative;
  width: 100%;  
  background-color: #FFFFFF;
  border-radius: 10px;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
}

/* 반구 구멍 만들기 */
.rect-with-half-circle::before {
  content: "";
  position: absolute;
  top: 50%;
  right: -10px; /* 원의 중심이 사각형 왼쪽 중앙에 위치하도록 조정 */
  transform: translateY(-50%);
  width: 25px;
  height: 25px;
  background-color: #FFFFFF; /* 구멍 내부 색상을 배경색과 맞춤 */
  border-radius: 50%; /* 원형 */
   /* 반구 안쪽 그림자 효과를 시뮬레이션 */
  box-shadow: inset 5px 0px 10px rgba(0, 0, 0, 0.1);
}

.barcodeBtn {
	cursor: pointer;
}

.rect-with-half-circle .close {
    position: absolute;
    top: 2px;
    right: 14px;
    z-index: 1; /* 다른 요소 위에 표시 */
}

</style>

<link rel="stylesheet" href="/css/pointShopOrder.css">
<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/JsBarcode.all.min.js"></script>
<script src="/js/dateUtils.js"></script>
<script type="text/javascript">
$(function() {
	$(".barcodeBtn").click(function() {		
		let barcodeDiv = $(this).closest(".pointShopOrderItem").find(".barcodeDiv");
		let display = barcodeDiv.css("display");
		if(display == 'none') {
			let stockNo = $(this).closest(".pointShopOrderItem").data("stockno");
			let barcodeImg = barcodeDiv.find(".barcodeImg");
			barcodeImg.JsBarcode(stockNo,{
				format: "CODE128",
			});	
			$(".barcodeDiv").slideUp();
			$(".barcodeBtn").removeClass("fa-angle-up").addClass("fa-angle-down");
			$(this).removeClass("fa-angle-down").addClass("fa-angle-up");
			barcodeDiv.slideDown();
		} else {
			$(this).removeClass("fa-angle-up").addClass("fa-angle-down");
			$(".barcodeDiv").slideUp();
		}		
	});
	
	//삭제 버튼 클릭 이벤트
	$(".rect-with-half-circle .close").click(function() {
		//삭제 전 확인
		if(confirm("이 상품을 삭제하면 복구하거나 포인트를 되돌려 받을 수 없습니다.")) {
			//삭제를 위한 데이터 가져오기
			let stockNo = $(this).closest(".pointShopOrderItem").data("stockno");
			
			location = "/pointShopOrder/delete.do?stockNo="+stockNo+"&${searchVO.query}";			
		}
	});
});

</script>
</head>
<body>
<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	
		<ul class="nav nav-tabs mb-3">
		    <li class="nav-item">
		      <a class="nav-link" href="/order/list.do" style="color: #02c75b;">일반 상품</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link active" onclick="return false;" href="#">포인트샵</a>
		    </li>
  		</ul>
  		
		<h4>포인트샵 구매 내역</h4>
		<jsp:include page="search.jsp"/>
	</div>
	<div class="border rounded p-4 mb-4 bg-white text-dark shadow-sm">
		<c:forEach items="${list }" var="vo">
			<div class="rect-with-half-circle m-2 pointShopOrderItem" data-stockno="${vo.stockNo }">
				<div class="row">
					<div class="col-md-1 d-flex justify-content-center align-items-center">
						<c:if test="${vo.category != '쿠폰' }">
							<b><i class="fa fa-angle-down barcodeBtn" style="font-size: 20px;"></i></b>
						</c:if>
					</div>
					<div class="col-md-3">
						<img class="rounded" src="${vo.goodsImage }" style="height: 150px; width:100%; object-fit:cover;">
					</div>
					<div class="col-md-6">
						<span>${vo.category}</span>
						<h5><b>${vo.goodsName }</b></h5>
						<div class="row mt-3">
							<div class="col">
								구매 포인트 : <fmt:formatNumber value="${ vo.orderPoint}"/>BP
							</div>
							<div class="col">
								구매일 : <fmt:formatDate value="${vo.orderDate }" pattern="yyyy-MM-dd hh:mm"/>
							</div>
						</div>
					</div>
					<div class="col-md-2 d-flex justify-content-center align-items-center" style="border-left: 2px dashed #ccc;">
						<h6><b>${vo.stockState }</b></h6>
						<button type="button" class="close" aria-label="Close">
        					<span aria-hidden="true">&times;</span>
    					</button>
					</div>
				</div>
				<c:if test="${vo.category != '쿠폰' }">
					<div class="barcodeDiv" style="display: none; text-align: center;">
						<img class="barcodeImg" style="display: inline-block;"></img>
					</div>
				</c:if>
			</div>			
		</c:forEach>	
		<!-- 페이지 네이션 -->
		<div class="pagination justify-content-center mt-4">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" query="&${searchVO.query }"></pageNav:pageNav>
		</div>
	</div>
</div>

</body>
</html>