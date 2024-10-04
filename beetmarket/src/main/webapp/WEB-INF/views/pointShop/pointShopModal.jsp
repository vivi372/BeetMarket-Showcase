<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>


/* 모달 크기 설정 */
#pointShopModal .modal-dialog {
  width: 80vw; /* 너비: 화면 너비의 80% */
  height: 60vh; /* 높이: 화면 높이의 70% */
  max-width: none; /* Bootstrap의 기본 최대 너비 제한 해제 */
  overflow: hidden; /* 모달 전체에 스크롤 막기 */
}

#pointShopModal .modal-content {	
	display: flex;
	flex-direction: column; /* 세로로 레이아웃 설정 */
	height: 100%; /* 모달 크기에 맞춤 */
}

/* 사이드바와 메인 콘텐츠를 flex로 나눔 */
#pointShopModal .modal-body-content {
  display: flex;
  flex: 1; /* 남은 공간 모두 차지 */
  height: 100%;
}

/* 사이드바 설정 */
#pointShopModal .modal-sidebar {
  width: 20%; /* 모달 너비의 20% 차지 */
  background-color: white; /* 사이드바 배경색 */  
  padding: 20px;
  display: flex;
  flex-direction: column;  
  
}

/* 메인 콘텐츠 */
#pointShopModal .modal-main {
  width: 80%; /* 모달 너비의 80% 차지 */
  
  padding: 20px;
  overflow-y: auto; /* 세로 스크롤 추가 */
	/* 스크롤바 전체 스타일 */
	&::-webkit-scrollbar {
	  width: 10px; /* 스크롤바 너비 */
	  height: 8px; /* 스크롤바 높이 */
	}
	
	/* 스크롤바 트랙 */
	&::-webkit-scrollbar-track {
	  background: white; /* 트랙 배경색 */
	  border-radius: 10px; /* 트랙 모서리 둥글게 */
	}
	
	/* 스크롤바 썸 */
	&::-webkit-scrollbar-thumb {
	  background: #03c75a; /* 썸 배경색 */
	  border-radius: 10px; /* 썸 모서리 둥글게 */
	}
}

/* 사이드바 설정 */
#pointShopModal .modal-right-sidebar {	
	width: 0; /* 모달 너비의 20% 차지 */
	
	
	
	overflow: hidden;
	background-color: white; /* 사이드바 배경색 */  
	padding: 0;
	display: flex;
	flex-direction: column;  
	box-shadow: -4px 0 5px rgba(0, 0, 0, 0.1); /* 왼쪽에 그림자 */
	overflow-y: auto; /* 세로 스크롤 추가 */
	
	/* 스크롤바 전체 스타일 */
	&::-webkit-scrollbar {
	  width: 10px; /* 스크롤바 너비 */
	  height: 8px; /* 스크롤바 높이 */
	}
	
	/* 스크롤바 트랙 */
	&::-webkit-scrollbar-track {
	  background: white; /* 트랙 배경색 */
	  border-radius: 10px; /* 트랙 모서리 둥글게 */
	  height: 95%;
	}
	
	/* 스크롤바 썸 */
	&::-webkit-scrollbar-thumb {
	  background: #03c75a; /* 썸 배경색 */
	  border-radius: 10px; /* 썸 모서리 둥글게 */
	}
	
}

.cateActive {
	color: #03c75a;
	border-right: 5px solid #03c75a;
}

#pointShopModal .modal-sidebar h4 {
	display: flex; 
	justify-content: center; 
	align-items: center; 	
}
#pointShopModal .modal-sidebar .category {
	cursor: pointer;	
}

/* 포인트샵 상품 카드 css */
#pointShopModal .modal-main .card {
	width:100%; 
	border: none; 
	height: 400px;
}
#pointShopModal .modal-main .card-img-top {
	object-fit: cover; 
	height: 250px;
}

#pointShopModal .modal-main .goodsName {
	word-break: break-all;
	line-height: 1.2; /* 줄 높이 조절 */
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

#pointShopModal .modal-main .card-text {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/* 기본 카드 스타일 */
#pointShopModal .goodsCard {	
	border-radius: 10px; /* 카드 모서리를 살짝 둥글게 */
	transition: all 0.3s ease; /* 호버 시 부드러운 효과 */
}

/* 브론즈 등급 */
/* #pointShopModal .bronze-border .goodsCard { */
/*   border-color: #cd7f32 !important;  */
/* } */

/* 골드 등급 */
/* #pointShopModal .gold-border .goodsCard { */
/*   border-color: #ffd700 !important;  */
/* } */

/* 다이아 등급 */
/* #pointShopModal .diamond-border .goodsCard { */
/*   border-color: #b9f2ff !important;  */
/* } */

/* 카드에 호버 시 약간 어두워지는 효과 */
#pointShopModal .goodsCard:hover {
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transform: translateY(-5px); /* 호버 시 살짝 위로 올라가는 효과 */
}


#pointShopModal .card {
	position: relative; /* 부모 요소에 상대적인 위치 설정 */
}

#pointShopModal .card-img-top {
	position: relative; /* 이미지 요소에 상대적인 위치 설정 */
}


#pointShopModal .updateBtn {
	position: absolute;
	top: 0;
	right: 0;
	z-index: 1; /* 버튼을 이미지보다 위로 배치 */
}

#pointShopModal .stopSaleBtn {
	position: absolute;
	top: 5;
	right: 5;
	z-index: 1; /* 버튼을 이미지보다 위로 배치 */
}

#pointShopModal .shipBadge {
	object-fit: contain;
	height: 40px;
	width: 40px;
}

#goodsModal .modal-content {
  	min-height: 670px; /* 최소 높이 설정 */
}

#pointShopModal .modal-right-sidebar .btn-circle {
	width: 40px;
	height: 40px;
	padding: 6px 0;
	border-radius: 50%;
	text-align: center;
	font-size: 18px;
	line-height: 1.5;
}

#pointShopModal .modal-right-sidebar .no-border {
	border: none;
	outline: none;  /* 클릭 시 외곽선도 제거 */
	font-weight: bold;  /* 글자를 두껍게 설정 */
}

#pointShopModal .modal-right-sidebar img {
	object-fit: cover;
	width: 80px;
	height: 80px;
}

#pointShopModal .modal-right-sidebar .basketDeleteBtn {
	cursor: pointer;
}

#pointShopModal .modal-right-sidebar .pointShopBasketItem h5 {
	word-break: break-all;
	line-height: 1.5; /* 줄 높이 조절 */
	display: -webkit-box;
	-webkit-line-clamp: 2;
	-webkit-box-orient: vertical;
	overflow: hidden;
}

#pointShopModal .modal-right-sidebar .pointShopBasketItem p {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}
#pointShopModal .modal-right-sidebar .media {
	display: flex;
	flex-direction: column; /* 기본적으로 세로 방향으로 배치 */
	
	@media (min-width: 700px) { /* 화면 너비가 768px 이상일 때 */
		flex-direction: row; /* 가로 방향으로 배치 */
	}
}
#pointShopModal .modal-right-sidebar ..media-body {
	order: 2; /* 이미지 다음에 배치 */
}

</style>

<link rel="stylesheet" href="/css/pointShopModal.css">

<script src="https://cdn.jsdelivr.net/npm/jsbarcode@3.11.6/dist/JsBarcode.all.min.js"></script>

<script src="/js/BoardInputUtil.js"></script>
<script src="/js/priceUtils.js"></script>
<script src="/js/pointShop/pointShop.js"></script>
<script src="/js/pointShopBasket/pointShopBasket.js"></script>
<script src="/js/pointShop/pointShopProcess.js"></script>
<script src="/js/pointShopBasket/pointShopBasketProcess.js"></script>
<script src="/js/pointShop/goodsModal.js"></script>

<script type="text/javascript">
	
	let service = new pointShopService();
	let basketService = new pointShopBasketService();
	
	let retryCount = 0; //이미지 로드 카운트
	let maxRetries = 20;  // 최대 5번 재시도
	
	let pointShopId = "";
	let pointShopGradeNo = 0;
	let pointShopShipNo = 0;
	
				
	if(${!empty login}) {
		pointShopId = "${login.id}";
		pointShopGradeNo = "${login.gradeNo}";
		pointShopShipNo = "${login.shipNo}";				
	} 
	
	
	
	$(function() {	
		
		$("#pointshop-btn").on("click", function() {
			
			service.id = pointShopId;
			basketService.id = pointShopId;
			service.gradeNo = pointShopGradeNo;
			basketService.gradeNo = pointShopGradeNo;
			basketService.shipNo = pointShopShipNo;
			
			//장바구니 닫기
			//장바구니
			let basket = $("#pointShopModal .modal-right-sidebar");
			//카테고리 메뉴
			let category = $("#pointShopModal .modal-sidebar");
			
			 // 패널이 열려 있을 때 (왼쪽으로 사라지는 애니메이션)
			category.find(".category i").hide();
			category.find(".category b").show();
			category.find("#basketBtn span").show();
			category.css({width: "20%",padding: "20px"});  // 250px로 확장 
	        basket.css({width: "0",padding: "0"});  // 0px로 축소 
			
			
			$("#pointShopModal").modal({backdrop: 'static', keyboard: false});	
			$("#pointShopModal .modal-sidebar,#pointShopModal .modal-right-sidebar,#pointShopModal .modal-main").css("height", $("#pointShopModal .modal-content").height()-80);
			//전체 카테고리 선택 시키기
			$(".modal-sidebar .category").removeClass("cateActive");
			$("#pointShopModal").find(".category:first").addClass("cateActive");
			$("#pointShopSearch").val("");
			service.list(showList,"","");
		});	
		
		
		window.addEventListener("resize", function() {			
			
			$("#pointShopModal .modal-sidebar,#pointShopModal .modal-right-sidebar,#pointShopModal .modal-main").css("height", $("#pointShopModal .modal-content").height()-80);
			
		
		});
		
		
		
// 		$("#barcodeBtn").click(function() {
// 			JsBarcode("#barcode", "123456789012", {
// 			    format: "CODE128",
// 			    displayValue: true
// 			});
// 		});
		
		$("#pointShopModal").draggable();
		
				
		
		
	});
</script>

<!-- The Modal -->
<div class="modal" id="pointShopModal" style="overflow: hidden;">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			
			<nav class="navbar navbar-expand-sm">
				<ul class="navbar-nav">
					<li class="nav-item active">
						<h3>
							<b class="nav-link text-primary">BeetSHOP</b>
						</h3>
					</li>
				</ul>
				<div class="w-50 mx-auto input-group">
					<!-- 검색 word 입력 -->
					<input type="text" class="form-control" id="pointShopSearch" placeholder="상품 이름 검색">
					<div class="input-group-append">
						<button class="btn btn-primary" id="searchBtn" type="button">
							<i class="fa fa-search"></i>
						</button>
					</div>
				</div>
				
				<div class="mx-auto d-flex align-items-center" style="font-size: 20px;">
					<c:if test="${!empty login }">
						<img src="/upload/pointshop/coin.png" height="30px;" width="30px;">
						<span class="text-primary"><b>&nbsp;&nbsp;<span id="pointShopPoint">1000</span>BP</b></span>
					</c:if>
				</div>
				
				<button type="button" class="close ml-auto" data-dismiss="modal">&times;</button>
			</nav>
			<!-- 사이드바와 메인 콘텐츠 영역 -->
        	<div class="modal-body-content">
				<!-- 왼쪽 20% 사이드바 -->
	        	<div class="modal-sidebar">
	        		<div class="ml-1 my-3 py-2 cateActive category" data-category="">
	          			<h4>
	          				<b>전체</b>
	          				<i class="fa fa-list-ul" style="display: none"></i>
	          			</h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="쿠폰">
	          			<h4>
	          				<b>쿠폰</b>
	          				<i class="fa fa-ticket" style="display: none"></i>
	          			</h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="상품권">
	          			<h4>
	          				<b>상품권</b>
	          				<i class="fa fa-gift" style="display: none"></i>
	          			</h4>	        		
	        		</div> 
	        		<div class="ml-1 my-3 py-2 category" data-category="음식">
	          			<h4>
	          				<b>음식</b>
	          				<i class="fa fa-mobile" style="display: none"></i>
	          			</h4>	        		
	        		</div>  
	        		
	        		<div class="mt-auto">
	        			<c:if test="${!empty login }">
		        			<button type="button" id="basketBtn" class="btn btn-primary btn-block">
		        				<i class="fa fa-shopping-cart"></i>
		        				<span>&emsp;장바구니</span>
		        			</button>
	        			</c:if>
	        		</div>	          			          		
	        	</div>
	        	
	        	
			
	        	<div class="modal-main">
	        		<c:if test="${!empty login && login.gradeNo == 9}">
	        			<button class="btn btn-primary" id="goodsWriteBtn">add</button>
	        		</c:if>
	        		
	        		<!-- 상품 데이터가 출력 -->
	        		<div id="goodsListDiv">
						<div class="row">
							<div class="col-md-3">
							
								
								
							</div>
						</div>
					</div>
				</div>
				
				
				<!-- 오른쪽 20% 사이드바 -->
				<div class="modal-right-sidebar left-shadow" style="display: flex; flex-direction: column; justify-content: space-between;">
				    <div class="ml-1 my-3 py-2">
				        <h4><b>장바구니</b></h4>
				        <div id="pointShopBasketList"></div>
				    </div>

				    <!-- 하단 총 가격과 구매 버튼 영역 -->
				    <div class="mt-auto">
				        <div class="row" style="font-size: 18px;">
				            <div class="col-md-4">총 가격</div>
				            <div class="col-md-8 text-primary font-weight-bold"><span id="pointShopBasketTotalPoint"></span>BP</div>
				        </div>
				        <button class="btn btn-primary btn-block mt-3" id="pointShopOrderBtn">구매하기</button>
				    </div>
				</div>
	        	
			</div>
		</div>
	</div>
</div>

<jsp:include page="goodsModal.jsp"/>