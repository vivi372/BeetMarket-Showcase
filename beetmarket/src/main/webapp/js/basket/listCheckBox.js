/**
 * 장바구니 리트스에서 체크박스 관련 처리
 */

//체크된 장바구니의 가격과 건수 가져온후 표시해 주는 함수
function checkedPriceAmount() {
	let totalGoodsPrice = 0;
	let totalDlvyPrice = 0;
	$(".sellerUl").each(function() {
		totalGoodsPrice += +(numWithoutComma($(this).find(".sellerGoodsPrice").text()));			
		totalDlvyPrice += +(numWithoutComma($(this).find(".sellerDlvyPrice").text()));		
	});
	
	$("#totalCheckAmount").text($(".basketCheckBox:checked").length);
	
	$(".totalGoodsPrice").text(numWithComma(totalGoodsPrice));
	$(".totalDlvyPrice").text(numWithComma(totalDlvyPrice));
	$(".totalCheckPrice").text(numWithComma(totalGoodsPrice+(+totalDlvyPrice)));		
	
};

//체크된 판매자 장바구니의 가격과 건수 가져온후 표시해 주는 함수
function checkedSellerPriceAmount($sellerUl) {
	let SellerGoodsPrice = 0;
	let SellerDlvyPrice = 0;	
	let freedelivery = numWithoutComma($sellerUl.find(".freedelivery").text());
	$sellerUl.find(".basketCheckBox:checked").each(function() {		
		let $listItem = $(this).closest(".list-group-item");
		SellerGoodsPrice += +(numWithoutComma($listItem.find(".orderPrice").text()));			
		SellerDlvyPrice = +(numWithoutComma($listItem.find(".dlvyCharge").text()));		
	});
	if(freedelivery <= SellerGoodsPrice) SellerDlvyPrice = 0;
	$sellerUl.find(".sellerGoodsPrice").text(numWithComma(SellerGoodsPrice));
	$sellerUl.find(".sellerDlvyPrice").text(numWithComma(SellerDlvyPrice));
	$sellerUl.find(".sellerOrderPrice").text(numWithComma(SellerGoodsPrice+(+SellerDlvyPrice)));		
	
};

$(function(){
	//체크박스 클릭할때 이벤트
	$(".basketCheckBox").change(function() {		
		//체크된 가격과 수량을 계산해 표시된 값을 바꿔준다.
		checkedSellerPriceAmount($(this).closest(".sellerUl"));
		checkedPriceAmount();
	});
	//전체 체크 체크박스 클릭 이벤트
	$("#allCheck").change(function() {
		//전체 체크가 체크된 상태면 모든 체크박스를 체크하고
		if($(this).is(":checked")){			
			$(".basketCheckBox").prop('checked',true);
			$(".sellerCheckBox").prop('checked',true);
			//아니면 체크를 푼다.
		} else{					
			$(".basketCheckBox").prop('checked',false);
			$(".sellerCheckBox").prop('checked',false);
		}
		//체크된 가격과 수량을 계산해 표시된 값을 바꿔준다.
		$(".sellerUl").each(function(){
			checkedSellerPriceAmount($(this));			
		})
		checkedPriceAmount();
	});
	
	//판매자 체크 체크박스 클릭 이벤트
	$(".sellerCheckBox").change(function() {
		let sellerUl = $(this).closest(".sellerUl");
		//전체 체크가 체크된 상태면 모든 체크박스를 체크하고
		if($(this).is(":checked")){			
			sellerUl.find(".basketCheckBox").prop('checked',true);
			//아니면 체크를 푼다.
		} else{					
			sellerUl.find(".basketCheckBox").prop('checked',false);
		}
		//체크된 가격과 수량을 계산해 표시된 값을 바꿔준다.
		$(".sellerUl").each(function(){
			checkedSellerPriceAmount($(this));			
		})
		checkedPriceAmount();
	});
	
	//주문 이벤트
	//단일 주문
	$(".orderWriteBtn").click(function() {
		//모든 input 태그를 비활성화 시킨다.
		$(".orderData").prop("disabled","true");
		
		let basketListItem = $(this).closest(".basketListItem");
		basketListItem.find(".basketCheckBox").prop("checked",true);
		//주문하기 버튼이 존재하는 곳의 listItem에 input 태그만 비활성화를 푼다.
		basketListItem.find(".orderData").each(function() {
			$(this).removeAttr("disabled");
		});
		//그 이후 폼을 submit() 시킨다.
		$("#orderWriteFromBasketForm").submit();
	});
	//다중 주문
	$("#checkedOrderWriteBtn").click(function() {
		//체크된 체크박스만 가져온다.
		$checkedBax = $(".basketCheckBox:checked");
		//체크박스 무결성 체크
		if(!checkedLength($checkedBax)) {
			//전체 주문 가격을 가져와 전체 주문 가격 input에 입력 시킨다.
			$("#totalCheckPriceInput").val(numWithoutComma($("#totalCheckPrice").text()));
			//모든 input 태그를 비활성화 시킨다.
			$(".orderData").prop("disabled","true");
			//체크된 곳의 listItem에 input 태그만 비활성화를 푼다.
			$checkedBax.each(function(index){
				$(this).closest(".basketListItem").find(".orderData").each(function() {
					$(this).removeAttr("disabled");
				});
			});		
			//그 이후 폼을 submit() 시킨다.
			$("#orderWriteFromBasketForm").submit();
		}
	});
	
	
	//장바구니 삭제 이벤트
	//단일 삭제
	$(".basketRemove").click(function() {
		let basketNo = $(this).closest(".list-group-item").find(".basketCheckBox").val();
		location="/basket/delete.do?basketNo="+basketNo;
	});
	//다중 삭제
	$("#checkedDeleteBtn").click(function() {
		//체크된 체크박스만 가져온다
		$checkedBax = $(".basketCheckBox:checked");
		//무결성 체크
		if(!checkedLength($checkedBax)) {
			//체크된 장바구니 번호를 담아 삭제 시킨다.
			let href = "/basket/delete.do?";
			$checkedBax.each(function(index){
				if(index==0) href += "basketNo="+$(this).val();
				else href += "&basketNo="+$(this).val();
			});
			if(confirm("선택하신 "+$checkedBax.length+"개 상품을 장바구니에서 삭제하시겠습니까?")){
				location = href;		
			}
		}
	});
	
});

