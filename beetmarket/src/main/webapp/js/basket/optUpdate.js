/**
 * 장바구니 리스트에서 옵션을 수정 처리를 한다.
 */
//옵션이 하나일때 삭제 버튼 지우는 함수
function removeDelete() {
	let $listItem = $("#optUpdateModal").find(".list-group-item");
	if($listItem.length == 1)
		$listItem.find(".remove").hide();
};
//옵션이 하나 이상일때 삭제 버튼 생기게하는 함수
function removeShow() {
	let $listItem = $("#optUpdateModal").find(".list-group-item");
	if($listItem.length>1){
		$listItem.find(".remove").show();		
	}
};


$(function(){
	
	
	//장바구니 옵션 수정 관련
	//모달이 사라질때 이벤트
	$("#optUpdateModal").on("hidden.bs.modal", function() {		
		//모달에 존재하는 모든 옵션을 지운다.
		$(this).find(".list-group-item").each(function() {
			$(this).remove();
		});		
	});
	
	//옵션 수정 폼이 submit 이벤트
	$("#updateForm").submit(function() {		
		//주문 가격에서 ,를 뺀후 백엔드로 보낸다.
		$("#orderPrice").val(numWithoutComma($("#totalPrice").text()));
	});	
	
	
	//옵션 수정 버튼 클릭시 이벤트
	$(".optUpdateBtn").click( function() {
		//필요한 데이터 들을 가져온다.
		let listItem = $(this).closest(".basketListItem");
		let goodsImage = listItem.find(".goodsImage").data("goodsiamge");
		let goodsTitle = listItem.find(".goodsTitle").text();
		let dlvyCharge = listItem.find(".dlvyCharge").text();
		let goodsNo = listItem.data("goodsno");	
		let basketNo = listItem.data("basketno");
		let freedelivery = numWithoutComma(listItem.closest(".sellerUl").find(".freedelivery").text());
		let orderPrice = numWithoutComma(listItem.find(".orderPrice").text());
		
				
		
		
		//가져온 데이터를 옵션 수정 모달에 입력한다.
		$("#updateModalImage").attr("src",goodsImage);
		$("#updateModalTitle").text(goodsTitle);
		$("#optUpdateModal").attr("data-freedelivery",freedelivery);
		$("#optUpdateModal").attr("data-dlvychargey",dlvyCharge);
		if(dlvyCharge == '무료') {
			$("#dlvyWon").text("");
		} else {
			$("#dlvyWon").text("원");
		}
		$("#updateModalCharge").text(dlvyCharge);			
		$("#basketNo").val(basketNo);
		
		//해당 장바구니의 상품 코드를 보내 해당 상품의 옵션 리스트를 가져온다.
		$("#selDiv").load("/opt/list.do?goodsNo="+goodsNo , function() {		
			//아작스 통신 성공후
			
			let jsonList = JSON.parse($("#jsonList").text());			
			//장바구니에 존재하는 옵션과 수량을 찾아 옵션 모달에 생성한다.
			listItem.find(".optNo").each(function() {	
				if($(this).val()!=null && $(this).val() != '0')		
					createTag($(this).val(),$(this).next().val(),jsonList);
				else{
					//옵션이 없을때
					$("#optUpdateModal .amount").val($(this).next().val());
					$(".optPrice").attr("data-basicprice", +orderPrice/$(this).next().val());
					
					$("#optUpdateModal #totalPrice").text(orderPrice);
				 	
				 }
			});			
					
			//옵션이 하나라뿐이면 옵션 삭제 버튼을 지운다.
			removeDelete();
		});	
	});
	
	//옵션 수정 모달의 옵션 삭제 버튼 클릭 이벤트
	$("#optUpdateModal").on("click",".remove", function() {
		$(this).closest(".list-group-item").remove();
		totalPrice($("#optUpdateModal").data("freedelivery"));
		removeDelete();	
	});
	//옵션 수정 모달의 옵션 select 태그 선택
	$("#optUpdateModal").on("change",".opt", function(){		
		//console.log(jsonList);
		createTag($(this).val(),1,jsonList,$("#optUpdateModal").data("freedelivery"));
		$(".optSelect").val("");
		removeShow();
	});
});