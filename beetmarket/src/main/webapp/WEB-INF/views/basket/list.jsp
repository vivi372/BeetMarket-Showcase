<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<!-- 부트스트랩과 제이쿼리를 사용하기 위한 라이브러리 가져오기 -->

<style>
.custom-control-label:hover{
	cursor: pointer;
}
.custom-checkbox .custom-control-input:checked~.custom-control-label::before{
 	background-color: #02c75b;
    border-color: #02c75b;   
}
.dataRow {
	cursor: pointer;
}
.basketListItem img {
    width: 150px; /* 원하는 최대 너비 설정 */
    height: 150px;     /* 비율에 맞게 높이 조정 */
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격 */
    object-fit:cover;
}
/* 드롭다운 옆의 세모 제거 */
#dropdown::after {
    font-size: 20px;    
}
#priceDetail {
	width: 400px;
	
}
</style>
<link rel="stylesheet" href="/css/basket.css">

<script type="text/javascript" src="/js/priceUtils.js"></script>
<!-- 옵션 리스트 관련 js 파일 -->
<script type="text/javascript" src="/js/basket/opt.js"></script>
<!-- 옵션 변경 관련 js 파일 -->
<script type="text/javascript" src="/js/basket/optUpdate.js"></script>
<!-- 체크박스 관련 js 파일 -->
<script type="text/javascript" src="/js/basket/listCheckBox.js"></script>

<!-- 데이터 무결성 검사를 위한 js 파일 -->
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>

<!-- 장바구니 주문 기본 css -->
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(function() {	
	//주문 금액,배송비 계산
	$(".basketListItem").each(function() {
		let orderPrice = 0; 
		$(this).find(".optionItem").each(function() {
			let optionPrice = $(this).data("optionprice");
			let amount = $(this).data("amount");
			orderPrice += optionPrice*amount;
		});
		$(this).find(".orderPrice").text(numWithComma(orderPrice));
		$(this).find("input[name='orderPrice']").val(orderPrice);
		
		let freedelivery = numWithoutComma($(this).closest(".sellerUl").find(".freedelivery").text());
		
		if(freedelivery<orderPrice)
			$(this).find(".dlvyCharge").text(0);
	
	});	
	
	//상품 사진,상품 이름 클릭 시 이벤트
	$(".dataRow").click(function() {
		let listItem = $(this).closest(".basketListItem");
		//해당 상품에 해당하는 상세보기로 이동시킨다.
		let goodsNo = listItem.data("goodsno");			
		location = "/goods/view.do?goodsNo="+goodsNo+"&inc=0";			
	});
	
	
});

</script>

</head>
<body>
<!-- 컨테이너 div -->
<div class="container">
	<nav class="navbar navbar-expand-sm navbar-dark fixed-bottom" style="background-color: black; height: 80px;">
		<div class="container text-white">
			<span class="ml-2">총 <b><span id="totalCheckAmount">0</span>건</b> 주문금액 &nbsp;<b style="font-size: 24px;"> <span class="totalCheckPrice">0</span>원</b></span>
			<div class="dropup ml-2">
				<span class="dropdown-toggle" id="dropdown" data-toggle="dropdown"></span>
				<div class="dropdown-menu" id="priceDetail">			    
			    	<div class="dropdown-item-text">
						<span class="float-right"><span class="printCommaNum totalGoodsPrice">0</span><span class="won">원</span></span>   						
						<span>총 선택상품금액:</span>   						
   					</div>	
   					<div class="dropdown-item-text">
						<span class="float-right">+<span class="printCommaNum totalDlvyPrice">0</span><span class="won">원</span></span>   						
						<span>총 배송비:</span>   						
   					</div>
   					<div class="dropdown-item-text">
						<span class="float-right"><b><span class="printCommaNum totalCheckPrice text-primary">0</span><span class="won">원</span></b></span>   						
						<span><b>총 주문 금액:</b></span>   						
   					</div>		
	    		</div>
    		</div>
			<button class="btn btn-light ml-auto" id="checkedOrderWriteBtn"><b>주문 하기</b></button>
		</div>
	</nav>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<h3><b>장바구니</b></h3>
		<hr>
		<c:if test="${ !empty list }">
			<div class="row my-3">			
				<div class="custom-control custom-checkbox ml-3 col pt-2">
					<input type="checkbox" class="custom-control-input" id="allCheck">    
					<label class="custom-control-label" for="allCheck"><b>전체 선택</b></label>							
		 		</div>
		 		<div class="text-right col mr-3">
					<button class="btn btn-primary ml-auto" id="checkedDeleteBtn">선택 삭제</button>	
				</div>		
			</div>
		</c:if>
		<!-- 데이터를 칸을 나누어 보여주기 위해 부트스트랩에 리스트 그룹 사용 -->
		<form action="/order/writeForm.do" method="post" id="orderWriteFromBasketForm">
			<input type="hidden" id="totalCheckPriceInput" name="totalCheckPrice"> 
			<ul class="list-group sellerUl">
				<c:if test="${!empty list }">
					<c:forEach items="${list }" var="vo" varStatus="vs">
						<c:if test="${vs.index == 0 }">
							<c:set var="isFirst" value="true"/>
						</c:if>

						<c:if test="${vs.index != 0 && vo.store_name != list[vs.index-1].store_name }">
							${"</ul>"}
							${"<ul class='list-group mt-3 sellerUl'>"}
							<c:set var="isFirst" value="true"/>
						</c:if>
				  		<li class="list-group-item basketListItem" data-goodsNo="${vo.goodsNo }" data-basketno="${vo.basketNo }">
				  						
				  					
				  			<!-- 이미지와 상품 정보칸 옵션칸을 나누기 위해 그리드 시스템 사용 -->
				  			<c:if test="${ isFirst == 'true'}">
				  				<div class="custom-control custom-checkbox float-left">
		    						<input type="checkbox" class="custom-control-input sellerCheckBox" id="sellerCheckBox${vs.index }">    
		    						<label class="custom-control-label" for="sellerCheckBox${vs.index }"></label>							
			 					</div>
				  				<h5 class="mt-1"><b>${vo.store_name } <i class="fa fa-home"></i></b>				  				
									&nbsp;&nbsp;<i style="font-size: 15px;"><span class="freedelivery"><fmt:formatNumber value="${vo.free_ship_limit }"/></span>원 이상 구매시 배송비 무료	</i>							
				  				</h5>
				  				<hr>
				  				<c:set var="isFirst" value="false"/>
				  			</c:if>
				  			<div class="row">
				  				<div class="col-md-1 d-flex flex-column justify-content-center">
					  				<div class="custom-control custom-checkbox">
			    						<input type="checkbox" class="custom-control-input basketCheckBox" name="basketNo" value="${vo.basketNo }" id="${vo.basketNo }">    
			    						<label class="custom-control-label" for="${vo.basketNo }"></label>							
			 						 </div>
		 						 </div>
				  				<div class="col-md-2 dataRow">
				  					<!-- 상품 이미지 -->
			  						<img class="rounded goodsImage" src="${vo.goodsMainImage }" data-goodsiamge="${vo.goodsMainImage }" alt="상품이미지">
			  					</div>
				  				<div class="col-md-4">	 
				  					<button type="button" class="close basketRemove">&times;</button><br><br>  		
				    				<!-- 상품 이름 -->
				    				<h5><b class="goodsTitle dataRow mt-2">${vo.goodsName }</b></h5>
				    				<!-- 결제 금액 배송비 -->
				    				<h5><b class="orderPrice"></b> <small class="dlvyCharge"><fmt:formatNumber value="${vo.merchant_delivery }" /></small></h5>	  
				    				<br>	    				
			  					</div>  					
			  					<div class="col-md-5 d-flex flex-column" style="border-left: 1px solid #ccc;">
			  						<c:forEach items="${optList }" var="opt">
			  							<c:if test="${vo.basketNo == opt.basketNo }">		  			
			  								<div class="optionItem" data-optno="${opt.optNo }" data-optionprice=${opt.optionPrice } data-amount="${opt.amount }">				
				  								<c:if test="${!empty opt.optName }">
							  						<!-- 상품 옵션 -->
							  						<h5><span class="badge badge-pill badge-secondary">
							  							옵션</span> ${opt.optName }
							  						</h5>
						  						</c:if>
						  						
					  							<input type="hidden" value="${vo.goodsNo }" name="goodsNo" class="orderData"> 
						  						<input type="hidden" value="${(empty opt.optNo)?0:opt.optNo }" name="optNo" class="orderData optNo">
						  						<input type="hidden" value="${opt.amount }" name="amount" class="orderData amount">
						  						<!-- 수량 -->
						  						<h5><span class="badge badge-pill badge-secondary">수량</span> ${opt.amount }</h5>
						  						<br>	
					  						</div>				  						
				  						</c:if>
			  						</c:forEach>
			  						<!-- 옵션 변경을 위한 버튼 -->
			  						<button type="button" class="btn btn-primary optUpdateBtn w-25 mt-auto" data-toggle="modal" data-target="#optUpdateModal">
			    						옵션 변경
			  						</button>
			  					</div>
							</div>
							<hr>
							<div class="text-center">
								<!-- 주문을 위한 버튼 -->
								<button type="button" class="btn btn-outline-primary mr-1 w-25 orderWriteBtn">주문 하기</button>								
							</div>							
				  		</li>
						<c:if test="${vo.store_name != list[vs.index+1].store_name }">

							<li class="list-group-item sellerItem">
								
								<div class="row">
								    <div class="col-md-6">
								        <div class="row">
								            <div class="col-md-2"></div>
								            <div class="col-md-4 text-right d-flex align-items-center justify-content-end">
								                <b>선택 상품 금액<br>
								                    <span class="sellerGoodsPrice">0</span>원											
								                </b>											
								            </div>
								            <div class="col-md-2 text-center d-flex align-items-center justify-content-center">
								                <i class="fa fa-plus"></i>
								            </div>
								            <div class="col-md-4 text-left d-flex align-items-center">
								                <b>배송비<br>
								                    <span class="sellerDlvyPrice">0</span>원											
								                </b>					
								            </div>
								        </div>
								    </div>
								    <div class="col-md-6" style="border-left: 1px solid #bbb;">
								        <h5 class="ml-4 d-flex align-items-center" style="height: 100%;"><b>주문 금액 <span class="text-primary sellerOrderPrice">0</span>원</b></h5>
								    </div>
								</div>
							</li>
						</c:if>
			  		</c:forEach>
		  		</c:if>
		  		<c:if test="${ empty list }">
	  			<div class="alert alert-dark">
    				 <strong>아직 장바구니에 담긴 상품이 없습니다.</strong> 쇼핑을 시작하고 마음에 드는 상품을 추가해보세요. 
  				</div>
	  		</c:if>
			</ul>
	  	</form>
		
	</div>  	
</div>
<jsp:include page="updateForm.jsp"></jsp:include>
</body>
</html>