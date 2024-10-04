<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세</title>
<style type="text/css">
.dataRow, .backBtn {
	cursor: pointer;
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
<link href="/css/basketOrder/basic.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	
	
	//모달 관련 이벤트
	//배송지 변경 버튼 클릭시 이벤트
	$("#dlvyBtn").click(function() {
		//console.log("클릭");
		$("#dlvySelModal").modal("show");
		$("#dlvyList").load("/dlvy/list.do");	
	});	
	//상품 이미지,상품 이름 클릭 이벤트
	$(".dataRow").click(function() {
		let listItem = $(this).closest(".orderListItem");
		//해당 상품에 해당하는 상세보기로 이동시킨다.
		let goodsNo = listItem.data("goodsno");		
		location = "/goods/view.do?goodsNo="+goodsNo+"&inc=0";		
	});
	//주문 취소 요청 버튼 클릭 이벤트
	$(".orderCancleBtn").click(function() {		
		let orderNo = $("#orderNo").text();
		let orderState = $(this).text();
		//주문 번호 모달 입력 태그에 입력
		$("#modalOrderNo").val(orderNo);
		$("#modalOrderState").val(orderState);
		$("#cancleReason").val("");
		$("#cancleModal").modal("show");
	});
	//구매확정 버튼 클릭
	$(".orderConfirmBtn").click(function() {
		let orderNo = $("#orderNo").text();	
		//현재 페이지의 uri,'구매 확인' 상태,주문 번호가 입력 되어있는 form 생성
		let formTag = `
			 	<form action="stateUpdate.do?${pageObject.pageQuery}&${searchVO.query}" method="post" id="clickForm">
			 		<input type="hidden" name="before" value="view.do?orderNo=\${orderNo}&${pageObject.pageQuery}&${searchVO.query}">
        			<input type="hidden" name="orderState" value="구매확정">
        			<input type="hidden" name="orderNos" value="\${orderNo}">
        		</form>
			`
		$(".container").append(formTag);	
		//그 후 submit
		$("#clickForm").submit();
		
	});
	
	//뒤로 가기 버튼 클릭 이벤트
	$(".backBtn").click(function() {
		location = "/order/list.do?${pageObject.pageQuery}&${searchVO.query}";
	});
	
	
});

	//배송지 선택 버튼 이벤트
	$(document).on("click", ".dlvySelBtn" , function() {
		//클릭한 버튼이 있는 dlvyListItem에서 dlvyaddrno를 얻은 후 변수에 저장
		let $dlvyListItem = $(this).closest(".dlvyListItem")
		let recipient = $dlvyListItem.find(".recipientModal").text();
		let dlvyName = $dlvyListItem.find(".dlvyNameModal").text();
		let tel = $dlvyListItem.find(".telModal").text();
		let addr = $dlvyListItem.find(".addrModal").text();
		let addrDetail = $dlvyListItem.find(".addrDetailModal").text();
		let postNo = $dlvyListItem.find(".postNoModal").text();
		//주문 번호,배송지 번호,페이지 정보가 입력된 폼 생성
		let confirmForm = `
			 	<form action="dlvyUpdate.do" method="post" id="confirmForm">
        			<input type="hidden" name="orderNo" value="${param.orderNo}">
        			<input type="hidden" name="dlvyName" value="\${dlvyName}">
        			<input type="hidden" name="recipient" value="\${recipient}">
        			<input type="hidden" name="tel" value="\${tel}">
        			<input type="hidden" name="addr" value="\${addr}">
        			<input type="hidden" name="addrDetail" value="\${addrDetail}">
        			<input type="hidden" name="postNo" value="\${postNo}">
        			<input type="hidden" name="page" value="${param.page}">
        			<input type="hidden" name="searchWord" value="${searchVO.searchWord}">
        			<input type="hidden" name="minDate" value="${searchVO.minDate}">
        			<input type="hidden" name="maxDate" value="${searchVO.maxDate}">
        			<input type="hidden" name="orderState" value="${searchVO.orderStateSearch}">
        			<input type="hidden" name="detailSearchExist" value="${searchVO.detailSearchExist}">

        		</form>
			`
		$(".container").append(confirmForm);	
		//그 후 submit
		$("#confirmForm").submit();
		
	});	
	//배송지 신규입력 버튼 클릭 이벤트
	$(document).on("click", "#dlvyWriteBtn",function() {
		$("#dlvyList").load("/dlvy/writeForm.do");
		
	});		
	//배송지 입력 폼에서 등록 버튼 클릭
	$(document).on("click","#dlvyWriteFormBtn" , function() {
		let formData = $("#dlvyWriteForm").serializeArray();
		let form = {};		
		$.each(formData, function() {
			form[this.name] = this.value;
		});	
		$("#dlvyList").load("/dlvy/write.do", form);
	});
	//배송지 수정 버튼 클릭 이벤트
	$(document).on("click", ".dlvyUpdateFormBtn",function() {
		let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");
		$("#dlvyList").load("/dlvy/updateForm.do?dlvyAddrNo="+dlvyAddrNo);		
	});
	//배송지 수정 폼에서 수정 버튼 클릭
	$(document).on("click","#dlvyUpdateBtn" , function() {
		let formData = $("#dlvyUpdateForm").serializeArray();
		let form = {};		
		$.each(formData, function() {
			form[this.name] = this.value;
		});	
		$("#dlvyList").load("/dlvy/update.do", form);
	});
	$(document).on("click",".dlvyDeleteBtn", function() {		
		if($(this).closest(".list-group-item").find(".basicAddr").length == 1) {
			alert("다른 배송지를 기본 배송지로 변경하고 삭제해주세요.");
		} else {
			let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");			
			$("#dlvyList").load("/dlvy/delete.do?dlvyAddrNo="+dlvyAddrNo);
		}
	});

</script>


</head>
<body class="bg-light">
<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm"> <!-- 주문 날짜와 주문 번호를 보여주는 div -->
		<i class="material-icons float-right backBtn" style="font-size:36px">arrow_back</i>
		<h3><b>주문 상세</b></h3>
		<hr>		
		<span class="mb-2">
		<fmt:formatDate value="${vo.orderDate }" pattern="yyyy-MM-dd hh:mm"/>			  					 
		 결제</span>	
		 <br>
		<!-- 주문 번호 -->
		<b>주문 번호</b> <span id="orderNo">${vo.orderNo }</span>
	</div>	
	<br>
	
	<h4 class="text-primary"><b>주문상품</b></h4>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm orderListItem orderNo" data-goodsNo="${vo.goodsNo }" data-orderno="${vo.orderNo }"> <!-- 주문 상품의 정보를 보여주는 div -->
		<div class="d-flex justify-content-between align-items-center">
			<h5 class="pt-2"><b>${vo.store_name } <i class="fa fa-home"></i></b></h5>
			<button class="btn btn-outline-primary" onclick="location='/chatbot/addroom.do?partner=${vo.id}'">문의하기</button>
		</div>
		<hr>
		<!-- 주문 상태 -->
		<c:if test="${vo.orderState == '취소요청' || vo.orderState == '반품요청' || vo.orderState == '요청처리'}">
			<h6><b class="text-warning">${vo.orderState}</b></h6>
		</c:if>
			<c:if test="${vo.orderState!='취소요청' && vo.orderState!='반품요청' && vo.orderState!='요청처리'}">		  			
				<h6><b>${vo.orderState}</b>
					<c:if test="${vo.orderState == '구매확정'}">
						<small><fmt:formatDate value="${vo.confirmDate }" pattern="yyyy-MM-dd hh:mm"/></small>
					</c:if>				
				</h6>
			</c:if>
		<!-- 이미지와 상품 정보칸 나누기 위해 그리드 시스템 사용 -->
		<div class="row mt-2">
			<div class="col-2">
				<!-- 상품 이미지 -->
				<img class="rounded dataRow" src="${vo.goodsMainImage }" alt="상품이미지">
			</div>
			<div class="col-10">
 				<!-- 상품 이름 -->
 				<h5><b class="dataRow">${vo.goodsName }</b></h5>		
 					<c:if test="${!empty vo.optNo }">	
		 				<!-- 상품 옵션 -->
						<h5><span class="badge badge-pill badge-secondary">옵션</span> ${vo.optName }</h5>			
					</c:if>		
					<!-- 수량 -->
					<h5><span class="badge badge-pill badge-secondary">수량</span> ${vo.amount }개</h5>
  				 				
  				<!-- 결제 금액 배송비 -->
  				<h5><b><span class="printCommaNum"><fmt:formatNumber value="${vo.orderPrice }"/></span><span class="won">원</span></b> <small><span class="printCommaNum"><fmt:formatNumber value="${vo.dlvyCharge }"/></span><span class="won">원</span></small></h5>	   
			</div>		
		</div>
		<hr>
		<div class="text-center">
			<c:if test="${vo.orderState == '결제완료' || vo.orderState == '배송준비'}">	
				<button type="button" class="btn btn-outline-primary orderConfirmBtn">구매확정</button>
				<button type="button" class="btn btn-outline-secondary orderCancleBtn">취소요청</button>
			</c:if>
			<c:if test="${vo.orderState == '배송중' || vo.orderState == '배송완료'}">	
				<button type="button" class="btn btn-outline-primary orderConfirmBtn">구매확정</button>
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
	</div>
	<br>
	
	<h4 class="text-primary"><b>배송지</b></h4>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm"> <!-- 배송지를 보여주는 div -->
		<c:if test="${vo.orderState == '결제완료' }">
			<!-- 배송지 입력을 위한 모달을 나타내는 버튼 -->
			<button class="btn btn-outline-primary btn-md float-right" id="dlvyBtn" type="button">변경</button>
		</c:if>
		<!-- 받는 사람 -->
		<h5><b>${vo.recipient }(${vo.dlvyName })</b></h5>	
		<!-- 연락처 -회색 글씨로 작게 -->
		<small class="text-secondary">${vo.tel }</small><br>
		<!-- 주소 -->
		${vo.addr } (${vo.postNo })
		<br>
		<!-- 배송 메모 -->
		<i class="material-icons align-middle">library_books</i> ${vo.dlvyMemo }
	</div>
	<br>
	
	<h4 class="text-primary"><b>결제 정보</b></h4>
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm"> <!-- 결제 정보를 보여주는 div -->
		<!-- 글부분과 숫자부분을 나누기위해 그리드 사용 -->
		<!-- 결제 금액 출력 -->
		<div class="row">
			<div class="col-6"> <!-- 글부분(설명) -->
				<h5><b class="text-dark">주문금액</b></h5>
				<div style="border-left: 5px solid #aaa;"> <!-- 앞에 수직으로 선을 만들기 위해 div의 style 사용 -->
					<div class="ml-2 mt-1">상품 금액</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
					<div class="ml-2 mt-1">할인 금액</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
					
					<div class="ml-2 mt-1">배송비</div>					
				</div>
			</div>
			<div class="col-6 text-dark text-right"> <!-- 숫자부분(금액) - 텍스트를 오른쪽에 붙히기 위해 text-right 클래스 사용 -->
				<h5><b class="text-dark">총 <fmt:formatNumber value="${vo.orderPrice + vo.dlvyCharge}"/><span class="won">원</span></b></h5>				
				<div class="ml-2 mt-1"><fmt:formatNumber value="${vo.orderPrice }"/><span class="won">원</span></div>
				<div class="ml-2 mt-1"><fmt:formatNumber value="${(vo.discount==0)?0:- vo.discount }"/><span class="won">원</span></div>
				<div class="ml-2 mt-1">
					<c:if test="${vo.dlvyCharge != 0 }">
						<fmt:formatNumber value="${vo.dlvyCharge }"/><span class="won">원</span>					
					</c:if>
					<c:if test="${vo.dlvyCharge == 0 }">
						무료			
					</c:if>
				</div>							
			</div>
		</div>
		<hr class="my-3">
		<!-- 글부분과 숫자부분을 나누기위해 그리드 사용 -->
		<!-- 결제 세부 정보 출력 -->
		<div class="row">
			<div class="col-8"> <!-- 글부분(설명) -->
				<h5><b>${vo.payWay }</b></h5>
				<div style="border-left: 5px solid #aaa;"> <!-- 앞에 수직으로 선을 만들기 위해 div의 style 사용 -->
					<!-- 카드 정보 출력 -->
					<div class="ml-2 mt-1" id="payDetail">${vo.payDetail }</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->										
				</div>
			</div>
			<div class="col-4 text-right"> <!-- 숫자부분(금액) - 텍스트를 오른쪽에 붙히기 위해 text-right 클래스 사용 -->
				<!-- 결제 금액 -->
				<h5><b><fmt:formatNumber value="${vo.orderPrice + vo.dlvyCharge}"/>원</b></h5>											
			</div>
		</div>		
	</div>
	
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">	
		<!-- 글부분만 숫자 부분을 나누기 위해 그리드 사용 -->
			<div class="row">
				<div class="col-6"> <!-- 글부분(설명) -->
					<h5><b class="text-dark">구매 적립</b></h5>
					<div style="border-left: 5px solid #aaa;"> <!-- 앞에 수직으로 선을 만들기 위해 div의 style 사용 -->
						<div class="ml-2 mt-1">기본적립</div> <!-- 왼쪽의 마진을 주기위해 span 태그안에 데이터를 넣은 후 ml 클래스로 마진을 준다. -->
						<div class="ml-2 mt-1">등급 추가 적립(${login.shipName })</div>					
					</div>
				</div>				
				<div class="col-6 text-right"> <!-- 숫자부분(금액) - 텍스트를 오른쪽에 붙히기 위해 text-right 클래스 사용 -->
					<!-- 금액을 출력한다 -->
					<h5><b class="text-dark">총 <fmt:formatNumber value="${vo.orderPrice*(vo.goodsSaveRate+vo.sale_rate)/100 - ((vo.orderPrice*(vo.goodsSaveRate+vo.sale_rate)/100)%1)}"/><span class="won">원</span></b></h5>								
					<div class="ml-2 mt-1"><fmt:formatNumber value="${vo.orderPrice*(vo.goodsSaveRate)/100 - ((vo.orderPrice*(vo.goodsSaveRate)/100)%1)}"/><span class="won">원</span></div>
					<div class="ml-2 mt-1"><fmt:formatNumber value="${vo.orderPrice*(vo.sale_rate)/100 - ((vo.orderPrice*(vo.sale_rate)/100)%1)}"/><span class="won">원</span></div>						
								
				</div>
			</div>	
		</div>			
	
</div>

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
		        	<input type="hidden" name="before" id="modalBeforeUri" value="view.do?orderNo=${vo.orderNo}&${pageObject.pageQuery}&${searchVO.query}">
		        	<input type="hidden" id="modalOrderState" name="orderState" value="취소 요청">
		        	<input type="hidden" id="modalOrderNo" name="orderNos">
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

<!-- 배송지 모달 -->
<jsp:include page="dlvyModal.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/review/writeForm.jsp"></jsp:include>
</body>
