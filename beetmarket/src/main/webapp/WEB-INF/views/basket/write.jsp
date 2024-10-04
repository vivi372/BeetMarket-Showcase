<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	

<!-- 스타일 정의 -->
<style type="text/css">
/*수량 입력 태그 중앙 정렬*/
.amount {
	text-align: center;
}
</style>

<link rel="stylesheet" href="/css/basket.css">

<!-- JavaScript 및 CSS 파일 포함 -->
<script type="text/javascript" src="/js/basket/opt.js"></script>
<script type="text/javascript" src="/js/priceUtils.js"></script>
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>

<!-- JavaScript 코드 -->
<script type="text/javascript">	
	let goodsNo = "${param.goodsNo}";
	$(function() {
		// 장바구니 담기 완료 후 확인
		//컨트롤러에서 장바구니 등록 후 session에 basketWriteComplete 저장
		//저장이 된 상태면 장바구니가 등록된 상태이므로 confirm 출력
		if(${!empty basketWriteComplete && basketWriteComplete}){
			
			if(confirm("장바구니에 상품이 담겼습니다. 장바구니로 가시겠습니까?")) {
				location = "/basket/list.do";
			}			
		}
		
		// 옵션 리스트 로드
		$(".selDiv").load("/opt/list.do?goodsNo=${param.goodsNo }", function() {
			//현재 상품의 가격을 goodsPrice에 저장
			let goodsPrice = ${vo.goodsPrice};
			//클래스가 optPrice 태그에 data-basicprice='goodsPrice' 추가
			$(".optPrice").attr("data-basicprice", goodsPrice);
		});		
		
		// 구매하기 버튼 클릭 이벤트 처리
		$("#orderBtn").click(function() {
			//무결성 체크
			if(optLengthCheck("#obWriteForm")) return false;
			//form의 action을 주문 쓰기 폼으로 변경
			$("#obWriteForm").attr("action", "/order/writeForm.do");
			//옵션과 수량을 포함한 전체 가격을 form의 orderPrice 태그에 넣기
			
			$("#obWriteForm").submit();				
			
		});
		
		// 장바구니 버튼 클릭 이벤트 처리
		$("#basketBtn").click(function() {
			//무결성 체크
			if(optLengthCheck("#obWriteForm")) return false;
			//form의 action을 장바구니 쓰기 으로 변경
			$("#obWriteForm").attr("action", "/basket/write.do");
			//옵션과 수량을 포함한 전체 가격을 form의 orderPrice 태그에 넣기
			
			$("#obWriteForm").submit();
			
		});		
		
		// 제거 버튼 클릭 이벤트 처리
		$("#optCard").on("click", ".remove", function() {
			//해당 listItem 삭제
			$(this).closest(".list-group-item").remove();
			//옵션이 변화 된 상태이므로 전체 가격 다시 계산
			totalPrice();
		});
		
		// 옵션 선택 시 태그 생성
		$(".selDiv").on("change", ".optSelect", function(){		
			if($(this).find("option[value='"+$(this).val()+"']").hasClass("optList")){
				createTag($(this).val(), 1,jsonList);
				$(".optSelect").val("");
				$("#optSelect1").nextAll(".optSelect").hide();
			}
		});
	});
	
	
</script>

<!-- 상품 주문/장바구니 담기 폼 -->
<form method="post" id="obWriteForm">
	
	<!-- 옵션 선택 영역 -->
	<div class="selDiv"></div>
	<!-- 히든 입력 영역 -->
	<input type="hidden" id="obWriteFormGoodsNo" value="${param.goodsNo }">				
	<input name="page" value="${param.page }" type="hidden">
	<input name="perPageNum" value="${param.perPageNum }" type="hidden">
	<input name="key" value="${param.key }" type="hidden">
	<input name="word" value="${param.word }" type="hidden">
	<!-- 옵션 listItem 생성 되는 곳 -->	
	<ul class="list-group my-2" id="optCard"></ul>

	<hr>
	
	<!-- 총 주문 금액 및 수량 표시 -->
	<div class="mb-2">
		<div class="float-right">
			<!-- 총 수량 표시 -->
			<span>총 수량 <span id="totalAmount">0</span>개</span>
			<!-- 총 금액 표시 -->
			<span style="border-left: 1px solid #ccc; font-size: 24px;" class="pl-2 text-dark font-weight-bold"><span id="totalPrice">0</span>원</span>
		</div>
		<div>
			<b>총 상품 금액</b>(배송비는 포함되어 있지 않습니다.)
		</div>
	</div>
	<br>
	
	<!-- 상품 상태에 따른 버튼 표시 -->
	<c:if test="${vo.goodsStatusName== '판매중' }">
		<div class="row">
			<div class="col">
				<button type="button" class="btn btn-primary btn-block" id="orderBtn">구매하기</button>				
			</div>
			<div class="col">
				<button type="button" class="btn btn-outline-dark btn-block" id="basketBtn">장바구니</button>		
			</div>	
		</div>
	</c:if>
	<c:if test="${vo.goodsStatusName != '판매중' }">
		<div class="alert alert-dark">
    		<strong>판매 종료된 상품입니다.</strong>    		    		
  		</div>
	</c:if>
</form>
