/**
 * 
 */



	/**
	 * 수량이 변화될때 해당 옵션의 가격을 계산 하는 함수
	 * $listitem - 옵션들의 정보가 존재하는 태그의 선택자
	 */
	function priceOpp($listitem) {
		//태그에서 수량 input 태그 찾는다.
		let $amount = $listitem.find(".amount");
		//태그에서 가격 정보가 담긴 태그 찾는다.
		let $optPrice = $listitem.find(".optPrice");
		//수량 값 가져오기
		let amount = $amount.val();
		//옵션의 기본 값 가져오기
		let basicPrice = $optPrice.data("basicprice");	
		console.log(basicPrice);
		console.log(amount);
		//기본 값과 수량 값을 곱하여 옵션 값에 입력한다.
		$optPrice.text(numWithComma(basicPrice*amount));
	};
	/**
	 * 총 상품 금액을 계산 하는 함수
	 */
	function totalPrice(freedelivery) {		
		let totalAmount = 0;
		let totalPrice = 0;
		//수량이 담긴 input들을 찾아 그 값을 totalAmount에 더한다.
		$(".amount").each(function() {
			totalAmount += +$(this).val();
		});
		//옵션 가격이 담긴 input들을 찾아 그 값을 totalPrice에 더한다.
		$(".optPrice").each(function() {			
			//console.log($(this).text()+" "+numWithoutComma($(this).text()));
			totalPrice = totalPrice + Number(numWithoutComma($(this).text()));			
		});
		
		if(freedelivery != null) {
			if(totalPrice >= freedelivery)
				$("#updateModalCharge").text(0);
			else
				$("#updateModalCharge").text($("#optUpdateModal").data("dlvychargey"));
		}
		
		//구한 값을 totalAmount, totalPrice에 넣는다.
		$("#totalAmount").text(totalAmount);
		$("#totalPrice").text(numWithComma(totalPrice));
	};
	
	/**
	 * 옵션 태그 생성하는 함수
	 * optNo - 만들 옵션의 번호
	 * amount - 만들 옵션의 수량
	 */
	function createTag(optNo,amount,jsonList,freedelivery){		
		let jsonItem = jsonList.find(function(item){
			return item.optNo == optNo;
		});	
		
		let optName = jsonItem.optName;
		let optPrice = jsonItem.optPrice+jsonItem.goodsPrice;
		let price = numWithComma(optPrice*amount);
		//console.log(optPrice);
		if($("#optCard").find("."+optNo).length == 0){
		let list = `
				<li class="list-group-item ${optNo} optListItem">
					<input type="hidden" name="goodsNo" value="${goodsNo }">			
					<input type="hidden" name="optNo" value="${optNo}">									
					<span>${optName}</span>
					<button type="button" class="close remove">&times;</button><br><br>
					<span class="float-right mt-2"><span class="optPrice font-weight-bold" data-basicPrice="${optPrice}">${price}</span>원</span>
						<div class="input-group mb-3 optAmount" style="width: 150px;">
							<div class="input-group-prepend">
								<button class="btn btn-primary minusBtn" type="button">
									<i class="fa fa-minus"></i>
								</button>
							</div>
							<input type="text" name="amount" class="amount form-control" value="${amount}">
							<div class="input-group-append">
								<button class="btn btn-primary plusBtn" type="button">
									<i class="fa fa-plus"></i>
								</button>
							</div>
						</div>
				</li>`
			$("#optCard").append(list);	
			totalPrice(freedelivery);
			
		}
	}	
	
	
	//수량이 입력될때 이벤트
	$(document).on("input",".amount", function() {
		//입력된 수량이 숫자가 아니면 지워버린다.	
		$(this).val($(this).val().replace(/[^0-9]/g, ""));
		$(this).val(Number($(this).val()));
		//수량이 1보다 작아지면 0으로 바꾼다.
		if ($(this).val() < 1)
			$(this).val(0);	
		//수량이 변했기 때문에 가격을 다시 계산한다.	
		priceOpp($(this).closest(".optListItem"));
		totalPrice($("#optUpdateModal").data("freedelivery"));
	});
	
	$(document).on("change",".amount", function() {
		if($(this).val()==0) $(this).val(1);
	});
	
	//-버튼 클릭시 이벤트
	$(document).on("click",".minusBtn", function() {
		//수량이 입력된 input태그에서 값을 가져온다.
		let amountInput = $(this).closest(".optAmount").find(".amount");		
		let amount = amountInput.val();
		//수량에 1를 뺀후 다시 입력한다. 만약 뺀값이 1보다 작은 경우 1을 입력한다.
		if(amount-1 < 1){
			amountInput.val(1);
		} else 
			amountInput.val(Number(amount)-1);
		//수량이 변했기 때문에 가격을 다시 계산한다.	
		priceOpp($(this).closest(".optListItem"));
		totalPrice($("#optUpdateModal").data("freedelivery"));
	});
	//+버튼 클릭시 이벤트
	$(document).on("click",".plusBtn", function() {
		//수량이 입력된 input태그에서 값을 가져온다.
		let amountInput = $(this).closest(".optAmount").find(".amount");
		let amount = amountInput.val();
		//console.log(amount);
		//수량에 1를 더한 후 다시 입력한다.
		amountInput.val(Number(amount) + 1);
		//수량이 변했기 때문에 가격을 다시 계산한다.	
		priceOpp($(this).closest(".optListItem"));
		totalPrice($("#optUpdateModal").data("freedelivery"));
	});
	
	
	
	
	