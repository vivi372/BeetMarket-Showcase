<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
    /* 사용자 정의 CSS */
    .custom-checkbox {
        display: flex;
        flex-wrap: wrap;
    }
    .custom-checkbox button {
        margin: 5px;
    }
</style>


<script type="text/javascript">
$(function() {
	//상세 검색 버튼 클릭 이벤트
	$("#detailSearchBtn").click(function() {		
		let detailSearch = $(this).closest("#searchForm").find("#detailSearch");
		let display = detailSearch.css("display");
		if(display == 'none') {			
			$("#detailSearchExist").val("true");
			$(this).children().removeClass("fa-angle-down").addClass("fa-angle-up");			
			detailSearch.slideDown();
		} else {
			$("#detailSearchExist").val("false");
			detailSearch.slideUp();
			$(this).children().removeClass("fa-angle-up").addClass("fa-angle-down");			
		}		
	});

	//주문 상태 버튼 클릭 이벤트
	$(".menu-item").click(function() {
		if($(this).hasClass("btn-primary")) {
			
			$("#searchForm #orderStateInput").val("");
			$("#searchForm").submit();
		} else {				
			$("#searchForm #orderStateInput").val($(this).text());
			$("#searchForm").submit();
		}	
	});
	//카테고리 버튼 클릭 이벤트
	$(".pay-item").click(function() {
		if($(this).hasClass("btn-primary")) {			
			$("#searchForm #payWayInput").val("");
			$("#searchForm").submit();
		} else {				
			$("#searchForm #payWayInput").val($(this).text());
			$("#searchForm").submit();
		}	
	});
	
	//검색 값 세팅
	$("#searchForm #minDate").val("${searchVO.minDate}");
	$("#searchForm #perPageNum").val("${pageObject.perPageNum}");
	$("#searchForm #key").val("${(empty searchVO.searchKey)?'n':searchVO.searchKey}");
	$("#searchForm #maxDate").val("${searchVO.maxDate}");
	$("#searchForm #goodsNameInput").val("${searchVO.searchWord}");
	$("#searchForm .menu-item").each(function() {
		if($(this).text() == "${searchVO.orderStateSearch}"){
			$(this).removeClass("btn-light");
			$(this).addClass("btn-primary");
			$("#searchForm #orderStateInput").val("${searchVO.orderStateSearch}");
		}			
	});
	$("#searchForm .pay-item").each(function() {
		if($(this).text() == "${searchVO.payWay}"){
			$(this).removeClass("btn-light");
			$(this).addClass("btn-primary");
			$("#searchForm #payWayInput").val("${searchVO.payWay}");
		}			
	});
	if(${searchVO.detailSearchExist}){
		$("#detailSearchExist").val("true");
		$(this).children().removeClass("fa-angle-down").addClass("fa-angle-up");			
		$("#detailSearch").show();
	}
	//기간 선택 버튼 클릭 이벤트
	$(".periodBtn").click(function() {
		$("#maxDate").val(dateToString(new Date()));
		$("#minDate").val(subtractDate($("#maxDate").val(),$(this).data("period")));
		$("#searchForm").submit();
	});
	$("#minDate, #maxDate").change(function() {
		$("#searchForm").submit();
	});
	//페이지당 글수 선택시 이벤트
	$("#searchForm #perPageNum").change(function() {
		$("#searchForm").submit();
	});
	
});
</script>

	<form action="adminList.do" id="searchForm">
		<input name="goodsNo" id="goodsNoInput" type="hidden">
		<div class="alert alert-success alert-dismissible">
  			<button type="button" class="close" data-dismiss="alert">&times;</button>
  			<b>검색시 키를 "구매자/상품 이름"으로 선택하고 검색어의 형식을 "OOO/OOO" 구매자와 상품 이름으로 동시 검색이 가능합니다.</b>
		</div>
    	<div class="input-group mb-3">
    		<input name="page" value="1" type="hidden">    		   		
    		<div class="input-group-prepend">
    			<button class="btn btn-primary" id="detailSearchBtn" type="button"><i class="fa fa-angle-down"></i></button>
    		</div>
    		<div class="input-group-prepend">
				<!-- 검색 키 전달 -->				
				<select name="searchKey" id="key" class="form-control">	   							
					<option value="i">구매자</option>   							
					<option value="n">상품 이름</option>					
					<option value="in">구매자/상품 이름</option>	   							
				</select>    					
			</div>		
	       	<!-- 검색 word 입력 -->
	 		<input type="text" class="form-control" placeholder="상품 이름 검색" id="goodsNameInput" name="searchWord">
	 		<div class="input-group-append">
				<button class="btn btn-primary searchBtn" type="submit"><i class="fa fa-search"></i></button>
			</div>
			<div class="input-group-prepend ml-5" style="width: 20%">
 				<span class="input-group-text text-white" style="background-color: #03c75a;">Rows/Page</span>
				<select name="perPageNum" id="perPageNum" class="form-control">
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
					<option value="25">25</option>   							
				</select>
			</div>
		</div>
		<div id="detailSearch" style="display: none;">
			<input type="hidden" name="detailSearchExist" id="detailSearchExist" value="false">
			 <!-- 버튼 그룹 -->
	         구매 기간
	         <div class="custom-checkbox my-2">
	             <button type="button" class="btn btn-outline-primary periodBtn" data-period="5y">5년</button>
	             <button type="button" class="btn btn-outline-primary periodBtn" data-period="6m">6개월</button>
	             <button type="button" class="btn btn-outline-primary periodBtn" data-period="3m">3개월</button>
	             <button type="button" class="btn btn-outline-primary periodBtn" data-period="1m">1개월</button>             
	         </div>
			
	        <div class="tab-content" id="pills-tabContent">
	            <div class="tab-pane fade show active" id="pills-5y" role="tabpanel" aria-labelledby="pills-5y-tab">
	                <!-- 날짜 선택기 -->
	                <div class="form-row">
	                    <div class="form-group col-md-5">
	                        <input type="date" id="minDate" name="minDate" class="form-control" value="2019-08-31">
	                    </div>
	                   <div class="form-group col-md-2 text-center">
	                        <b style="font-size: 20px;">~</b>
	                    </div>
	                    <div class="form-group col-md-5">
	                        <input type="date" id="maxDate" name="maxDate" class="form-control" value="2024-08-31">
	                    </div>
	                </div>
	                 <!-- 버튼 그룹 -->
	                 주문 상태
	                <div class="custom-checkbox">
	                    <button type="button" class="btn btn-light menu-item">결제완료</button>
	                    <button type="button" class="btn btn-light menu-item">배송준비</button>
	                    <button type="button" class="btn btn-light menu-item">배송중</button>
	                    <button type="button" class="btn btn-light menu-item">배송완료</button>
	                    <button type="button" class="btn btn-light menu-item">구매확정</button>
	                    <button type="button" class="btn btn-light menu-item">취소요청</button>
	                    <button type="button" class="btn btn-light menu-item">반품요청</button>
	                    <button type="button" class="btn btn-light menu-item">요청처리</button>
	                </div>
	                <input type="hidden" name="orderStateSearch" id="orderStateInput">	    
	                    
	                 <!-- 버튼 그룹 -->
	                 결제 방법
	                <div class="custom-checkbox my-2">
	                    <button type="button" class="btn btn-light pay-item">카드간편결제</button>
	                    <button type="button" class="btn btn-light pay-item">카드</button>
	                    <button type="button" class="btn btn-light pay-item">계좌이체</button>
	                    <button type="button" class="btn btn-light pay-item">간편결제</button>
	                    <button type="button" class="btn btn-light pay-item">가상계좌</button>
	                    <button type="button" class="btn btn-light pay-item">문화상품권</button>
	                    <button type="button" class="btn btn-light pay-item">휴대폰</button>
	                </div>       
	                <input type="hidden" name="payWay" id="payWayInput">	     
               </div>
              
            </div>
        </div>
    </form>

    