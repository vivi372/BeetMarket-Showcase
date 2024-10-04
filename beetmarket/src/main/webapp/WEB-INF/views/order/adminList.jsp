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
 	background-color: #02c75b;
    border-color: #02c75b;   
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

.dropOrderState:hover {
	cursor: pointer;
	text-decoration: underline;
}
/* Owl Carousel 높이 설정 */
.owl-carousel .item {
    height: 250px; /* 캐로셀의 높이 */
    display: flex;
    justify-content: center;
    align-items: center;
}
.goodsItem {
    height: 100%; /* 이미지가 캐로셀 높이의 60%만 차지 */
    cursor: pointer;
    transition: all 0.3s ease; /* 호버 시 부드러운 효과 */
}

.goodsItemActive .card-img-top {
	border: 3px solid #03c75a;
}

/* 카드에 호버 시 약간 어두워지는 효과 */
.goodsItem:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transform: translateY(-5px); /* 호버 시 살짝 위로 올라가는 효과 */
}

/* 카드 이미지가 캐로셀 높이의 60%만 차지하도록 설정 */
.card-img-top {
    height: 70%; /* 이미지가 캐로셀 높이의 60%만 차지 */
    object-fit: cover; /* 이미지 비율을 유지하며 크기 조정 */
}
/* 카드 이미지가 캐로셀 높이의 60%만 차지하도록 설정 */
.card-body {
    height: 30%; /* 이미지가 캐로셀 높이의 60%만 차지 */
}

</style>

<link rel="stylesheet" href="/css/order.css">
<link rel="stylesheet" href="/css/checkBax.css">
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>
<script type="text/javascript" src="/js/priceUtils.js"></script>
<script type="text/javascript" src="/js/dateUtils.js"></script>
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/1.7.1/clipboard.min.js"></script>
<link rel="stylesheet" href="/css/owl.carousel.css">
<link rel="stylesheet" href="/css/owl.theme.default.css">

<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script type="text/javascript">
	
	$(function() {	
		//아이디 마스킹
		$(".idMasking").each(function() {
			$(this).text(maskString($(this).text()));
		});
		
		$('.owl-carousel').owlCarousel({
		    margin:20,
		    nav:true,
		    dots:true,
		    mouseDrag:true,
		    touchDrag:true,
		    pullDrag:true,
		    responsive:{
		        0:{
		            items:1
		        },
		        600:{
		            items:5
		        },
		        1000:{
		            items:7
		        }
		    }
		});
		
		$(".goodsItem").click(function() {
			if($(this).hasClass("goodsItemActive")) {				
				$("#searchForm #goodsNoInput").val("");
				$("#searchForm").submit();
			} else {				
				$("#searchForm #goodsNoInput").val($(this).data("goodsno"));
				$("#searchForm").submit();
			}	
		});
		
		$(".goodsItem").each(function() {
			if($(this).data("goodsno") == "${searchVO.goodsNo}"){
				$(this).addClass("goodsItemActive");
				$("#searchForm #goodsNoInput").val("${searchVO.goodsNo}");
			}			
		});
		//회원 이름으로 검색
		$(".nameSearchBtn").click(function() {
			let name = $(this).closest(".orderData").find(".id").text();
			$("#searchForm #goodsNameInput").val(name);
			$("#searchForm #key").val("i");
			$("#searchForm").submit();
		});
		//스크롤 초기값		
		$('html, body').animate({ scrollTop: ${(empty param.scroll)?0:param.scroll} }, 'slow');
		
		//상태 수정 드롭다운 클릭
		$(".orderStateDropdown .dropdown-item").click(function() {
			let orderNo = $(this).closest(".orderData").find(".orderNo").text();
			let orderState = $(this).text();
			let scroll = $(window).scrollTop();
			
			let formTag = `
				<form id="clickForm" action="stateUpdate.do" method="post">
					<input type="hidden" name="orderNos" value="\${orderNo}">
					<input type="hidden" name="orderState" value="\${orderState}">
					<input type="hidden" name="scroll" value="\${scroll}">
					<input type="hidden" name="before" 
					value="adminList.do?${pageObject.pageQuery}&${searchVO.fullQuery}">
				</form>
			`;
			
			$("body").append(formTag);
			$("#clickForm").submit();
			
		});
		
		//전체 상태 수정 드롭다운 클릭
		$(".allStateUpdate .dropdown-item").click(function() {
			let orderState = $(this).text();
			let scroll = $(window).scrollTop();
			
			//체크 박스중 체크된 값만 가져온다.
			let checkedBax = $(".orderListCheckBox:checked");
			
			let formTag = `
				<form id="clickForm" action="stateUpdate.do" method="post">
					<input type="hidden" name="orderState" value="\${orderState}">
					<input type="hidden" name="scroll" value="\${scroll}">
					<input type="hidden" name="before" 
					value="adminList.do?${pageObject.pageQuery}&${searchVO.fullQuery}">				
			`;
			//체크박스 무결성 체크
			if(!checkedLength(checkedBax)) {
				checkedBax.each(function(){
					let orderState = $(this).closest(".orderData").find(".orderState").text();
					let orderNo = $(this).val();
					if(orderState!='취소요청' && orderState!='반품요청' && orderState!='요청처리' && orderState!='구매확정') 
						formTag += `<input type='hidden' name='orderNos' value='\${orderNo}'>`;
				});
				formTag += `</form>`;
				if(formTag.indexOf("orderNos")==-1) {
					alert("배송 상태 수정이 불가능한 주문만 선택되었습니다.");
				} else {
					$("body").append(formTag);
					$("#clickForm").submit();		
					
				}
			}		
			
			
		});
		
		//취소/반품 버튼 클릭 이벤트
		$(".orderCancleBtn").click(function() {
			let orderNo = $(this).closest(".orderData").find(".orderNo").text();
			let orderState = $(this).text();
			$("#modalOrderNo").val(orderNo);
			$("#modalOrderState").val(orderState);
			$("#modalScroll").val($(window).scrollTop());
			$("#cancleReason").val("");
			$("#orderCancleModal").modal("show");
		});
		//요청 처리 버튼 클릭이벤트
		$(".orderProcessBtn").click(function() {
			let orderNo = $(this).closest(".orderData").find(".orderNo").text();
			let scroll = $(window).scrollTop();
			
			let formTag = `
				<form id="clickForm" action="stateUpdate.do?${pageObject.pageQuery}&${searchVO.fullQuery}" method="post">
					<input type="hidden" name="orderNos" value="\${orderNo}">
					<input type="hidden" name="orderState" value="요청처리">
					<input type="hidden" name="scroll" value="\${scroll}">
					<input type="hidden" name="before" 
					value="adminList.do?${pageObject.pageQuery}&${searchVO.fullQuery}">
				</form>
			`;
			
			$("body").append(formTag);
			$("#clickForm").submit();
		});
		//삭제 버튼 클릭 이벤트
		$(".orderDeleteBtn").click(function() {
			let orderNo = $(this).closest(".orderData").find(".orderNo").text();
			if(confirm(orderNo+"번 주문을 정말로 삭제하시겠습니까? 삭제후 주문은 복구가 불가능합니다.")) {
				let scroll = $(window).scrollTop();
				location = `delete.do?orderNo=\${orderNo}&scroll=\${scroll}&${pageObject.pageQuery}&${searchVO.fullQuery}`;				
			}
		});
		
		//일괄 선택 버튼 클릭 이벤트
		$("#allCheck").change(function() {
			//체크 박스 전체 선택과 체크 박스 전체 해제
			if($(this).is(":checked")){			
				$(".orderListCheckBox").prop('checked',true);
			} else{					
				$(".orderListCheckBox").prop('checked',false);
			}			
		});
		
		
		
		
		//상세 정보는 처음에는 숨긴다.
		$(".detailData").hide();
		//상세 정보 보기 버튼 클릭시 상세 정보를 보이게 하고 버튼의 형태를 바꾼다.
		//또한 다른 상세 정보를 숨긴다.
		$(".detailBtn").click(function() {
			$detailData = $(this).closest(".orderData").next();
			if($detailData.css("display") == 'none'){	
				$(".detailData").slideUp();
				$(".detailBtn").attr("class","fa fa-angle-down detailBtn");
				$detailData.slideDown();
				$(this).attr("class","fa fa-angle-up detailBtn");
			} else {
				$detailData.slideUp();
				$(this).attr("class","fa fa-angle-down detailBtn");
			}
		});
		
		let clipboard = new Clipboard('.copyBtn');
	    clipboard.on('success', function(e) {
	    	$("#clipboardAlert").show();
        	setTimeout(function() {
        		$("#clipboardAlert").fadeOut();
			},1000);
	    });
	    clipboard.on('error', function(e) {
	        alert("지원하지 않는 브라우저 입니다.");
	    });
		
		
	});
	
	function maskString(str) {
        // 문자열의 첫 두 글자만 남기고 나머지는 *로 마스킹
        if (str.length > 2) {
            let masked = str.substring(0, 2); // 첫 두 글자
            masked += '*'.repeat(str.length - 2); // 나머지 부분을 *로 대체
            return masked;
        } else {
            return str; // 두 글자 이하의 문자열은 그대로 반환
        }
    }
</script>

</head>
<body>

	
	<div class="alert alert-dark alert-dismissible fade show fixed-bottom w-50 mx-auto" id="clipboardAlert" style="display: none; opacity: 75%;">	   
	    	클립보드에 복사되었습니다.
  	</div>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm content">	
	<c:if test="${!empty login && login.gradeNo==9 }">
		<ul class="nav nav-tabs mb-3">
		    <li class="nav-item">
		      <a class="nav-link active" onclick="return false;" href="#">일반 상품</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="/pointShopOrder/list.do?admin=1" style="color: #02c75b;">포인트샵</a>
		    </li>
	 	</ul>	
	</c:if>
	<h3><b>주문 관리</b></h3>
	
	<jsp:include page="adminSearch.jsp"/>
	<c:if test="${!empty goodsList }">
		<h5 class="mt-3">판매 상품 목록 <small>*상품을 클릭해 검색</small></h5>
		<div class="owl-carousel owl-theme p-2 my-3 border rounded-lg">
			<c:forEach items="${goodsList }" var="vo">
		   	 	<div class="item">
		   	 		<div class="card rounded border border-0 goodsItem" style="width:100%" data-goodsno="${vo.goodsNo }">
						<img class="card-img-top rounded" src="${vo.goodsMainImage }">
						<div class="card-body">
					    	<h5 class="text-truncate"><b>${vo.goodsName }</b></h5>			    	
					  	</div>
					</div>
		   	 	</div>		
			</c:forEach>	    
		</div>
	</c:if>
	
	
	<div class="my-2">
		<div class="dropdown allStateUpdate float-right mb-2 mr-3">
			<button type="button" class="btn btn-outline-primary dropdown-toggle" data-toggle="dropdown">
			  	배송 상태 수정
			</button>
			<div class="dropdown-menu">			
			    <a class="dropdown-item" href="#">배송준비</a>			  
			    <a class="dropdown-item" href="#">배송중</a>				
			    <a class="dropdown-item" href="#">배송완료</a>							    		
			</div>
		</div>
		<!-- 주문 체크 박스 -->
		<div class="custom-control custom-checkbox ml-3">
			<input type="checkbox" class="custom-control-input" id="allCheck">    
			<label class="custom-control-label" for="allCheck">전체 선택</label>							
		</div>	
	</div>
	
	
	<!-- 주문 정보 리스트를 보여주는 테이블 -->
	<table class="table">	
		<thead>	
			<tr>			
				<th class="text-center">선택</th>
				<th>상세</th>
				<th>주문 번호</th>
				<th>주문 상태</th>
				<th>결제일</th>
				<th>구매자/받는 사람</th>
				<th>상품 코드</th>
				<th>판매자</th>
				<th>상품 이름</th>					
				<th>주문 금액</th>
				<th>배송비</th>								
				<th>결제 방법</th>
				<th>요청</th>
				
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="vo" varStatus="vs">
				
				<tr class="orderData">
					<td>
						<!-- 주문 체크 박스 -->
						<div class="custom-control custom-checkbox d-flex flex-row justify-content-center">
    						<input type="checkbox" class="custom-control-input orderListCheckBox" id="orderListCheckBox${vo.orderNo }" value="${vo.orderNo }">    
    						<label class="custom-control-label" for="orderListCheckBox${vo.orderNo }"></label>							
		 				</div>
					</td>
					<td>
						<!-- 주문 상세 정보 보여주는 버튼 -->
						<i class="fa fa-angle-down detailBtn"></i>
					</td>
					<td class="orderNo">${vo.orderNo }</td>
					<td>
						<!-- 주문 상태 -->
			  			<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청' || vo.orderState == '요청처리'}">
			  				<span class="text-warning orderState">${vo.orderState}</span>
			  			</c:if>
			  			<c:if test="${vo.orderState!='취소요청' && vo.orderState!='반품요청' && vo.orderState!='요청처리' && vo.orderState!='구매확정'}">			  			
			  				<span class="orderState dropOrderState" data-toggle="dropdown">${vo.orderState}</span>			  				
			  				<!-- 주문 상태 클릭시 나오는 드롭다운 메뉴 -->
							<div class="dropdown-menu orderStateDropdown">
								<c:if test="${vo.orderState!='배송준비'}">
							    	<a class="dropdown-item" href="#">배송준비</a>
							    </c:if>
								<c:if test="${vo.orderState!='배송중'}">
							    	<a class="dropdown-item" href="#">배송중</a>
							    </c:if>
								<c:if test="${vo.orderState!='배송완료'}">
							    	<a class="dropdown-item" href="#">배송완료</a>
							    </c:if>									    
							</div>
			  			</c:if>				
			  			<c:if test="${ vo.orderState=='구매확정'}">
			  				<span class="orderState">${vo.orderState}</span>	
			  			</c:if>
					</td>
					<td><fmt:formatDate value="${vo.orderDate }" pattern="yyyy-MM-dd"/></td>
					<td>
						<span class="id" data-toggle="dropdown">${vo.name }</span>
						(<span class="idMasking">${vo.id}</span>)/${vo.recipient }
						<!-- 아이디 클릭시 나오는 드롭다운 메뉴 -->
						<div class="dropdown-menu">
							<c:if test="${!empty login && login.gradeNo==9 }">
						   		<a class="dropdown-item" href="/member/view.do?id=${vo.id}">회원 정보 보기</a>
						    </c:if>
						    <a class="dropdown-item" href="/chatbot/addroom.do?partner=${vo.id}">메시지 보내기</a>
						    <a class="dropdown-item nameSearchBtn" href="#">주문 조회</a>
						</div>
					</td>
					
					<td>${vo.goodsNo}</td>
					<td>${vo.store_name}</td>
					<td>${vo.goodsName}</td>					
					<td><fmt:formatNumber value="${vo.orderPrice }"/></td>
					<td><fmt:formatNumber value="${vo.dlvyCharge }"/></td>			
					<td>${vo.payWay }</td>			
					<td>
						<!-- 해당 주문의 상태가 '취소 요청'상태면 삭제 버튼이 생긴다. -->
						<c:if test="${login.gradeNo==9 && vo.orderState=='요청처리'}">
							<button class="btn btn-primary btn-sm orderDeleteBtn">삭제</button>
						</c:if>
						<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청'}">
							<button class="btn btn-outline-primary btn-sm orderProcessBtn">요청처리</button>
						</c:if>
						<c:if test="${vo.orderState == '결제완료' || vo.orderState == '배송준비'}">	
							<button class="btn btn-outline-primary btn-sm orderCancleBtn">취소요청</button>
						</c:if>
						<c:if test="${vo.orderState == '배송중' || vo.orderState == '배송완료'}">	
							<button class="btn btn-outline-primary btn-sm orderCancleBtn">반품요청</button>
						</c:if>
					</td>									
				</tr>
				<!-- 상세 정보 데이블 -->
				<tr class="detailData">
					<td colspan="13">
						<table class="table table-borderless detailTable">	
							<tr>
								<c:if test="${vo.orderState != '취소요청' && vo.orderState != '반품요청' && vo.orderState != '요청처리' }">
									<th>구매확인일</th>
									<td>${vo.confirmDate }</td>												
								</c:if>
								<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청' || vo.orderState == '요청처리' }">
									<th>취소 사유</th>
									<td>${vo.cancleReason }</td>												
								</c:if>
							</tr>											
							<tr>
								<th>판매자</th>
								<td>${vo.store_name }</td>
								<th>받는 사람 이름</th>
								<td>
									<span class="copyText">${vo.recipient }</span>
									<span><i class="material-icons copyBtn" data-clipboard-text="${vo.recipient}" style="font-size:20px">content_copy</i></span>
								</td>
							</tr>
							<tr>
								<th>결제 방법</th>
								<td>${vo.payWay }</td>								
								<th>받는 사람 연락처</th>
								<td>
									<span class="copyText">${vo.tel }</span>
									<span><i class="material-icons copyBtn" data-clipboard-text="${vo.tel}" style="font-size:20px">content_copy</i></span>
								</td>
							</tr>
							<tr>
								<th>결제 상세</th>
								<td>${vo.payDetail }</td>								
								<th>주소</th>
								<td>
									<span class="copyText">${vo.addr+=" "+=vo.addrDetail}</span>
									<span><i class="material-icons copyBtn" data-clipboard-text="${vo.addr+=' '+=vo.addrDetail}" style="font-size:20px">content_copy</i></span>
								</td>
							</tr>
							<tr>							
								<th>주문자 이름</th>
								<td>${vo.name }</td>
								<th>우편 번호</th>
								<td>${vo.postNo }</td>
							</tr>							
							<tr>								
								<th>주문자 연락처</th>
								<td>${vo.memberTel }</td>
							</tr>							
						</table>					
					</td>
				</tr>
				
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination justify-content-center">
		<pageNav:pageNav listURI="adminList.do" pageObject="${pageObject }" query="&${searchVO.query }"></pageNav:pageNav>
	</div>		
</div>


<!-- 취소 요청 모달 -->	    
	<div class="modal fade" id="orderCancleModal">
		<div class="modal-dialog modal-dialog-centered">
	    	<div class="modal-content">		        
		        <div class="modal-header">
		          	<h4 class="modal-title mx-auto"><b>주문 요청</b></h4>
		          	<!-- 모달창이 사라지는 아이콘 버튼 -->
		          	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>	        
		        <form action="stateUpdate.do?${pageObject.pageQuery}&${searchVO.fullQuery}" method="post">		        	
		        	<input type="hidden" id="modalOrderNo" name="orderNos">
		        	<input type="hidden" id="modalOrderState" name="orderState">
		        	<input type="hidden" id="modalScroll" name="scroll">
					<input type="hidden" name="before" value="adminList.do?${pageObject.pageQuery}&${searchVO.fullQuery}">							
			        <div class="modal-body">			        	
						<div class="form-group">
					  		<label for="cancleReason">취소 사유:</label>
					  		<input type="text" class="form-control" id="cancleReason" name="cancleReason">
						</div>
			        </div>	        
			        
			        <div class="modal-footer">
			        	<!-- 배송지 변경을 클릭하면 모달창이 닫히고 입력된 데이터로 화면이 변한다. -->
			          	<button class="btn btn-primary" type="submit">요청</button>
			          	<!-- 모달창이 사라지는 버튼 -->
			          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			        </div>
			        
			     </form>	        
	      	</div>
	 	</div>
	 </div>

</body>
</html>