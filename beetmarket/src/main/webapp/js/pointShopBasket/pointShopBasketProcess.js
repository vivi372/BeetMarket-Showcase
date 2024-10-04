/**
 * 포인트 샵 바스켓 서비스 처리
 */
$(function() {
	//장바구니 리스트 버튼 클릭
	$(".modal #basketBtn").click(function() {
		toggleBasket();        
	});
	
	
	//상품 클릭시 장바구니 등록 이벤트
	$("#goodsListDiv").on("click",".goodsCard",function(e){
		console.log("클릭");
		
		let goodsShipNo = $(this).data("shipno");
		
		if(pointShopId == "") {
			alert("포인트샵의 물건은 로그인 하셔야 구매가 가능합니다.");
			return;
		}
		
		if(goodsShipNo > pointShopShipNo) {
			alert("회원님의 많은 관심에 감사드립니다.\n해당 상품은 더 높은 등급의 회원님을 위한 특별 상품입니다. 등급을 업그레이드하시면 구매하실 수 있습니다.");
		} else {			
			let goodsId = $(this).data("goodsid");
			//상품 재고
			let stock = $(this).find(".goodsStock").data("goodsstock");
			//현재 장바구니 재고
			let basketAmount = 0;
			$("#pointShopBasketList").find(".pointShopBasketItem").each(function() {
				if($(this).data("goodsid")==goodsId) basketAmount = $(this).find(".pointShopBasketAmount").val();
			});		
			
			if(basketAmount < stock) {
				basketService.write(function(data){
					alert(data);
					toggleBasket(true);
				},goodsId);
			} else {
				alert("죄송합니다. 현재 해당 상품의 재고가 부족하여 구매하실 수 없습니다.")
			}
		}
		
		
	});
	

	//장바구니 수량 입력 이벤트
	$("#pointShopBasketList").on("change",".pointShopBasketAmount", function(){
		//해당 장바구니의 데이터 가져오기
		let pointShopBasketItem = $(this).closest(".pointShopBasketItem");
		let pointShopBasketNo = pointShopBasketItem.data("pointshopbasketno");
		let basketGoodsId = pointShopBasketItem.data("goodsid");
		//현재 장바구니 재고
		let amount = $(this).val();			
		//현재 상품 재고
		let goodsStock;
		$("#goodsListDiv").find(".goodsCard").each(function(){
			if($(this).data("goodsid") == basketGoodsId) goodsStock = $(this).find(".goodsStock").data("goodsstock");
		});
		if(goodsStock >= amount) {
			if(amount>0) {
				let formData = new FormData();
				formData.append("pointShopBasketNo",pointShopBasketNo);
				formData.append("amount",amount);
				
				basketService.update(function(data) {					
					oppPoint();
					alert(data);
				},formData);
			} else {
				pointShopBasketItem.find(".pointShopBasketAmount").val(1);
			}
		} else {
			alert("죄송합니다. 현재 해당 상품의 재고가 부족하여 더 구매하실 수 없습니다.");
			toggleBasket(true);
		}
		
	
	});
	
	//장바구니 +,-버튼 클릭 이벤트
	$("#pointShopBasketList").on("click",".minusBtn , .plusBtn", function(){
		//해당 장바구니의 데이터 가져오기
		let pointShopBasketItem = $(this).closest(".pointShopBasketItem");
		let pointShopBasketNo = pointShopBasketItem.data("pointshopbasketno");
		let amount = pointShopBasketItem.find(".pointShopBasketAmount").val();
		let basketGoodsId = pointShopBasketItem.data("goodsid");
		//현재 장바구니 재고
		//클릭한게 +면 수량에 1을 더하고 -면을 1을 뺀다.
		if($(this).text()=='+') amount = Number(amount)+1;
		else amount = Number(amount)-1;
		//현재 상품 재고
		let goodsStock;
		$("#goodsListDiv").find(".goodsCard").each(function(){
			if($(this).data("goodsid") == basketGoodsId) goodsStock = $(this).find(".goodsStock").data("goodsstock");
		});
		console.log(amount);
		console.log(goodsStock);
		if(goodsStock >= amount) {
			if(amount>0) {
				let formData = new FormData();
				formData.append("pointShopBasketNo",pointShopBasketNo);
				formData.append("amount",amount);
				
				basketService.update(function(data) {
					
					pointShopBasketItem.find(".pointShopBasketAmount").val(amount);
					oppPoint();
					alert(data);
				},formData);
			} else {
				basketService.delete(function(data) {			
					alert(data);
					basketService.list(showBasketList);
				},pointShopBasketNo);
			}
		} else {
			alert("죄송합니다. 현재 해당 상품의 재고가 부족하여 더 구매하실 수 없습니다.");
			toggleBasket(true);
		}
	
	});
	
	//장바구니 삭제 버튼 클릭 이벤트
	$("#pointShopBasketList").on("click",".basketDeleteBtn", function(){
		//해당 장바구니의 데이터 가져오기
		let pointShopBasketItem = $(this).closest(".pointShopBasketItem");
		let pointShopBasketNo = pointShopBasketItem.data("pointshopbasketno");	
		
		
		basketService.delete(function(data) {			
			alert(data);
			basketService.list(showBasketList);
		},pointShopBasketNo);
		
	
	});
	
	//장바구니의 구매 버튼 클릭 이벤트
	$(".modal-right-sidebar #pointShopOrderBtn").click(function() {
		//현재 계정 총 포인트
		let totalPoint = numWithoutComma($("#pointShopModal #pointShopPoint").text());
		//장바구니 상품 총 포인트
		let basketTotalPoint = numWithoutComma($("#pointShopModal #pointShopBasketTotalPoint").text());
		
		if(Number(totalPoint) < Number(basketTotalPoint)) {
			alert("포인트가 부족합니다.");
			return false;
		}
		let formData = new FormData();
		//서버로 보낼 데이터 수집(상품코드,수량)
		$("#pointShopBasketList").find(".pointShopBasketItem").each(function(i){
			formData.append(`list[${i}].goodsId`,$(this).data("goodsid"));
			formData.append(`list[${i}].pointShopBasketNo`,$(this).data("pointshopbasketno"));
			formData.append(`list[${i}].amount`,$(this).find(".pointShopBasketAmount").val());
			formData.append(`list[${i}].goodsName`,$(this).find(".goodsName").text());
		});
		
		let value = formData.values();
		for(let i of value) {
			console.log(i);
		}
		
		//장바구니 데이터로 결제
		basketService.orderWrite(function(data){
			alert(data);
			service.list(showList,"","");
			toggleBasket(true);
		},formData);
		
	});
	

	
	
});
//장바구니 열리는 함수
function toggleBasket(open) {
	//장바구니
	let basket = $("#pointShopModal .modal-right-sidebar");
	//카테고리 메뉴
	let category = $("#pointShopModal .modal-sidebar");
	
	
    if (basket.width() === 0 || open) {
        // 패널이 닫혀 있을 때 (오른쪽에서 나오는 애니메이션)
		category.find(".category i").show();
		category.find(".category b").hide();			
		category.find("#basketBtn span").hide();
        category.animate({width: "10%",padding: "10px"}, 500);  // 250px로 확장 (시간은 500ms)
        basket.animate({width: "30%",padding: "20px"}, 500);  // 250px로 확장 (시간은 500ms)
        basketService.list(showBasketList);
    } else {
        // 패널이 열려 있을 때 (왼쪽으로 사라지는 애니메이션)
		category.find(".category i").hide();
		category.find(".category b").show();
		category.find("#basketBtn span").show();
		category.animate({width: "20%",padding: "20px"}, 500);  // 250px로 확장 (시간은 500ms)
        basket.animate({width: "0",padding: "0"}, 500);  // 0px로 축소 (시간은 500ms)
    }

}



function oppPoint() {
	let totalPoint = 0;
	
	$("#pointShopBasketList").find(".pointShopBasketItem").each(function() {
		let amount = $(this).find(".pointShopBasketAmount").val();				
		let pointAmount = $(this).data("pointamount");	
		totalPoint += (+pointAmount)*(+amount);
	});
	$("#pointShopBasketTotalPoint").text(numWithComma(totalPoint));
}

//data를 포인트샵 장바구니 리스트로 출력
function showBasketList(list) {			
		
		//상품 리스트 출력할 태그
		let basketList = ``;	
		let totalPoint = 0;
		
	
			
		for(let i=0;i<list.length;i++) {
			let pointShopBasketNo = list[i].pointShopBasketNo;
			let goodsId = list[i].goodsId;
			let goodsName = list[i].goodsName;
			let goodsImage = list[i].goodsImage;
			let amount = list[i].amount;				
			let pointAmount = list[i].pointAmount;		
			totalPoint += (+pointAmount)*(+amount);
			basketList += `
					<div class="media rounded-sm shadow-sm p-3 pointShopBasketItem my-2"
						data-pointamount=${pointAmount} data-pointShopBasketNo=${pointShopBasketNo} data-goodsid="${goodsId}">
						<img src="${goodsImage}" class="mr-3 img-thumbnail">
						<div class="media-body">
							<span class="float-right basketDeleteBtn">&times;</span>
							<h5 class="goodsName">${goodsName}</h5>	
							<p class="text-primary">${numWithComma(pointAmount*amount)}BP</p>

							<div class="input-group">
								<div class="input-group-prepend">
									<button class="btn btn-outline-primary btn-circle minusBtn" type="button">-</button>
								</div>
								<input type="text" class="form-control text-center no-border pointShopBasketAmount" value="${amount}" style="max-width: 50px;">
								<div class="input-group-append">
									<button class="btn btn-outline-primary btn-circle plusBtn" type="button">+</button>
								</div>
							</div>

						</div>
					</div>
			`;
		}
		
		$("#pointShopBasketTotalPoint").text(numWithComma(totalPoint));
			
		$("#pointShopBasketList").html(basketList);
		
		
}
	

