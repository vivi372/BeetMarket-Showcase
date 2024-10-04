<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>

<style>

.custom-control-input:checked ~ .custom-control-label::before {
    background-color: #555; /* 중간 회색 */
    border-color: #555; /* 중간 회색 */
}       

.dataRow {
	cursor: pointer;
} 
.menu-item {
    transition: background-color 0.3s;
}

.menu-item.menu-active {
    background-color: black;
    color: white;
}

.orderListItem img {
    width: 150px; /* 원하는 최대 너비 설정 */
    height: 150px;     /* 비율에 맞게 높이 조정 */
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격 */
    object-fit:cover;
}
</style>

<link rel="stylesheet" href="/css/order.css">
<script type="text/javascript" src="/js/priceUtils.js"></script>
<script type="text/javascript" src="/js/dateUtils.js"></script>
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">


$(function() {
	
	//스크롤 초기값		
	$('html, body').animate({ scrollTop: ${(empty param.scroll)?0:param.scroll} }, 'slow');
	
	//주문 취소 요청 버튼 클릭 이벤트
	$(".orderCancleBtn").click(function() {
		//해당 listItem에 존재하는 orderno 데이타를 찾아 변수에 저장한다.
		let orderNo = $(this).closest(".orderListItem").data("orderno");
		//주문 취소 요청 모달의 orderNo 입력 태그에 변수 orderNo 입력
		$("#modalOrderNo").val(orderNo);
	});
	
	//주문 취소 요청 버튼 클릭 이벤트
	$(".orderCancleBtn").click(function() {		
		//해당 listItem에 존재하는 orderno 데이타를 찾아 변수에 저장한다.
		let orderNo = $(this).closest(".orderListItem").data("orderno");
		let orderState = $(this).text();
		let scroll = $(window).scrollTop();
		//주문 번호 모달 입력 태그에 입력
		$("#modalOrderNo").val(orderNo);
		$("#modalOrderState").val(orderState);
		$("#modalScroll").val(scroll);
		$("#cancleReason").val("");
		$("#cancleModal").modal("show");
	});
	//구매확인 버튼 클릭
	$(".orderConfirmBtn").click(function() {
		//해당 listItem에 존재하는 orderno 데이타를 찾아 변수에 저장한다.
		let orderNo = $(this).closest(".orderListItem").data("orderno");
		//현재 페이지의 uri,'구매 확인' 상태,주문 번호가 입력 되어있는 form 생성
		let formTag = `
			 	<form action="stateUpdate.do?${pageObject.pageQuery}&${searchVO.query}" method="post" id="clickForm">
			 		<input type="hidden" name="before" value="list.do?${pageObject.pageQuery}&${searchVO.query}">
        			<input type="hidden" name="orderState" value="구매확정">
        			<input type="hidden" name="orderNos" value="\${orderNo}">
        		</form>
			`
		$(".container").append(formTag);	
		//그 후 submit
		$("#clickForm").submit();
		
	});
	//관리자 페이지 가기 체크박스 클릭 이벤트
	$("#adminList").click(function() {
		//주문 관리 페이지로 이동한다.
		location = "/order/adminList.do";
	});
	//상품 이미지,상품 이름 클릭 이벤트
	$(".dataRow").click(function() {
		let listItem = $(this).closest(".orderListItem");
		//해당 상품에 해당하는 상세보기로 이동시킨다.
		let goodsNo = listItem.data("goodsno");	
		
		location = "/goods/view.do?goodsNo="+goodsNo+"&inc=0";
	
	});
});



</script>

</head>
<body class="bg-light">
<!-- 컨테이너 div -->
<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
  		<ul class="nav nav-tabs mb-3">
		    <li class="nav-item">
		      <a class="nav-link active" onclick="return false;" href="#">일반 상품</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="/pointShopOrder/list.do">포인트샵</a>
		    </li>
  		</ul>
		<h3>주문 목록</h3>
		
		<jsp:include page="search.jsp"></jsp:include>
		
		<hr>
		<!-- 데이터를 칸을 나누어 보여주기 위해 부트스트랩에 리스트 그룹 사용 -->
		<ul class="list-group">
			<c:if test="${!empty list }">
				<c:forEach items="${list }" var="vo">
			  		<li class="list-group-item orderListItem" data-goodsNo="${vo.goodsNo }" data-orderNo="${vo.orderNo }">
			  			<!-- 주문 상태 -->
			  			<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청' || vo.orderState == '요청처리'}">
			  				<h6><b class="text-warning">${vo.orderState}</b></h6>
			  			</c:if>
			  			<c:if test="${vo.orderState!='취소요청' && vo.orderState!='반품요청' && vo.orderState!='요청처리'}">			  			
			  				<h6><b>${vo.orderState}</b></h6>
			  			</c:if>
			  			
			  			<!-- 이미지와 상품 정보칸 옵션칸을 나누기 위해 그리드 시스템 사용 -->
			  			<div class="row">
			  				<div class="col-2">
			  					<!-- 상품 이미지 -->
		  						<img class="rounded dataRow" src="${vo.goodsMainImage }" alt="상품 이미지">
		  					</div>
			  				<div class="col-5 d-flex flex-column">
			  					<span class="mb-2">
			  					<fmt:formatDate value="${vo.orderDate }" pattern="yyyy-MM-dd hh:mm"/>			  					 
			  					 결제</span>	   									
			    				<!-- 상품 이름 / 클릭시 상품 상세보기로 이동시키기 위해 dataRow 클래스 추가 -->
			    				<h5><b class="dataRow goodsName">${vo.goodsName }</b></h5>
			    				<!-- 결제 금액 배송비 -->
			    				<h5><b><span class="orderPrice"><fmt:formatNumber value="${vo.orderPrice }"/></span><span class="won">원</span></b> <small>
			    					<c:if test="${vo.dlvyCharge != 0}">
			    						<fmt:formatNumber value="${vo.dlvyCharge }"/><span class="won">원</span>
			    					</c:if>
			    					<c:if test="${vo.dlvyCharge == 0}">
			    						무료
			    					</c:if>
			    				</small></h5>	  
			    				<br>
			    				<!-- 버튼 클릭시 해당 주문번호에 해당하는 상세보기 페이지가 열린다. --> 				
			    				<a href="/order/view.do?orderNo=${vo.orderNo }&${pageObject.pageQuery}&${searchVO.query}" class="btn btn-primary mt-auto w-25">주문 상세</a>
		  					</div>  					
		  					<div class="col-5" style="border-left: 1px solid #ccc;">
		  						<!-- 옵션 정보 출력 -->				
	  							
	  							<c:if test="${!empty vo.optName }">
			  						<!-- 상품 옵션 -->
			  						<h5><span class="badge badge-pill badge-secondary">옵션</span> <span class="optionName">${vo.optName }</span></h5>	  							
	  							</c:if>
		  						
		  						<!-- 수량 -->
		  						<h5><span class="badge badge-pill badge-secondary">수량</span> <span class="amount">${vo.amount}</span>개</h5>
		  						<br>							
		  							  					
		  					</div>
						</div>
						<hr>
						<div class="text-center orderNo" data-orderno="${vo.orderNo }" data-goodsno="${vo.goodsNo }">								
							<c:if test="${vo.orderState == '결제완료' || vo.orderState == '배송준비'}">	
								<button type="button" class="btn btn-outline-primary orderConfirmBtn">구매확정</button>
								<button type="button" class="btn btn-outline-secondary orderCancleBtn">취소요청</button>
							</c:if>
							<c:if test="${vo.orderState == '배송중' || vo.orderState == '배송완료'}">	
								<button type="button" class="btn btn-primary orderConfirmBtn">구매확정</button>
								<button type="button" class="btn btn-outline-secondary orderCancleBtn">반품요청</button>
							</c:if>
							<!-- 리뷰 버튼 나중에 reviewEx 추가 해야함 -->
							<c:if test="${vo.orderState == '구매확정' && vo.reviewExist != 1}">			
								<button type="button" class="btn btn-outline-primary reviewBtn">리뷰쓰기</button>
							</c:if>
							<c:if test="${vo.reviewExist == 1}">			
								<b>이용해 주셔서 감사합니다.</b>
							</c:if>
							<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청'}">	
								<b>고객님의 취소 요청을 확인했습니다.</b>
							</c:if>
							<!-- 취소 요청후 취소 문구 출력 -->
							<c:if test="${vo.orderState == '요청처리'}">	
								<b>고객님의 요청을 처리했습니다.이용해 주셔서 감사합니다.</b>
							</c:if>
						</div>
			  		</li>	  	
		  		</c:forEach>	
	  		</c:if>
	  		<!-- 아직 주문하지 않았을때 문구 출력 -->
	  		<c:if test="${ empty list }">
	  			<div class="alert alert-dark">
    				 <strong>주문 내역이 없습니다. </strong> 상품을 주문하고 여기에 주문 내역을 확인하세요!
  				</div>
	  		</c:if>
		</ul>
		<!-- 페이지 네이션 -->
		<div class="pagination justify-content-center mt-4">
			<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" query="&${searchVO.query }"></pageNav:pageNav>
		</div>
	</div>  	
</div>

	<jsp:include page="/WEB-INF/views/review/writeForm.jsp"></jsp:include>
	 
	<!-- 취소 요청 모달 -->	    
	<div class="modal fade" id="cancleModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">		        
		        <div class="modal-header">
		          	<h4 class="modal-title mx-auto"><b>주문 요청</b></h4>
		          	<!-- 모달창이 사라지는 아이콘 버튼 -->
		          	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>	        
		        <form action="stateUpdate.do?${pageObject.pageQuery}&${searchVO.query}" method="post">
		        	<input type="hidden" name="before" id="modalBeforeUri" value="list.do?${pageObject.pageQuery}&${searchVO.query}">
		        	<input type="hidden" id="modalOrderState" name="orderState" value="취소 요청">
		        	<input type="hidden" id="modalOrderNo" name="orderNos">
		        	<input type="hidden" id="modalScroll" name="scroll">
			        <div class="modal-body">
			        	<!-- 배송지에 필요한 데이터를 입력받는다. -->
						<div class="form-group">
						  	<label for="cancleReason"><b>취소 사유:</b></label>
	 						<!-- 결제창에서만 사용하는 데이터이므로 name x -->
						  	<input type="text" class="form-control" id="cancleReason" name="cancleReason" maxlength="100" placeholder="취소하는 이유를 입력해주세요.">
						</div>		          	
			        </div>	        
			        
			        <div class="modal-footer">
			        	<!-- 배송지 변경을 클릭하면 모달창이 닫히고 입력된 데이터로 화면이 변한다. -->
			          	<button class="btn btn-primary">요청</button>
			          	<!-- 모달창이 사라지는 버튼 -->
			          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			        </div>
			        
			     </form>	        
	      	</div>
	 	</div>
	 </div>
</body>
</html>