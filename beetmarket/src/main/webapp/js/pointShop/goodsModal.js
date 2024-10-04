/**
 * 
 */

$(function() {
	$("#goodsModal").draggable();	
	
		
	
	$("#goodsImageInput,#goodsImageUpdate").change( function() {
		//console.log($(this).val());
		$(this).closest(".goodsImageDiv").find(".modalImageNamePrint").text($(this).val());		
	});
	
	$("#cateInput,#cateUpdate").change(function() {		
		if($(this).val() == '쿠폰') {
			$(this).parent().next().show();			
		} else {
			$(this).parent().next().hide();
			$("#discountRateInput").val("");
		}
	});
	
	//포인트샵 상품 모달 등장 이벤트
	$("#goodsWriteBtn").on("click", function() {
		$("#goodsModal").modal({backdrop: 'static', keyboard: false});
		//모달 제목 바꾸기
		$("#goodsModal .modal-title").text("상품 등록");
		//버튼 이름 바꾸기
		$("#goodsModal #goodsSubmitBtn").text("등록");
		//모달안 input,select 태그 값 초기화
		$("#goodsModal").find("input").val("");
		$("#goodsModal").find("select").val("");
		$(".modalImageNamePrint").text("");
		//상품 등록 폼 보이기
		$("#goodsModal #goodsWriteDiv").show();
		//상품 수정 폼 숨기기
		$("#goodsModal #goodsUpdateDiv").hide();
		//할인율 div 숨기기
		$("#discountRateInput").closest(".form-group").hide();
		
	});
	//포인트샵 상품 수정 모달 등장 이벤트
	$("#goodsListDiv").on("click",".updateBtn", function(e) {		
		$("#goodsModal").modal({backdrop: 'static', keyboard: false});
		//모달 제목 바꾸기
		$("#goodsModal .modal-title").text("상품 수정");
		//버튼 이름 바꾸기
		$("#goodsModal #goodsSubmitBtn").text("수정");
		//모달안 input,select 태그 값 초기화
		$("#goodsModal").find("input").val("");
		$("#goodsModal").find("select").val("");
		//수정을 위한 데이터 가져오기
		let goodsCard = $(this).closest(".goodsCard");
		let goodsId = goodsCard.data("goodsid");
		let goodsName = goodsCard.find(".goodsName").text();
		let amount = numWithoutComma(goodsCard.find(".amount").text());
		let goodsStock = goodsCard.find(".goodsStock").data("goodsstock");
		let category = goodsCard.data("category");
		let discountRate = goodsCard.data("discountrate");
		let shipNo = goodsCard.data("shipno");
		let goodsImage = goodsCard.find("img").prop("src");
		//데이터 세팅
		$("#goodsIdUpdate").val(goodsId);
		$("#goodsNameUpdate").val(goodsName);
		$("#pointAmountUpdate").val(amount);
		$("#cateUpdate").val(category);
		$("#discountRateUpdate").val(discountRate);
		$("#goodsStockUpdate").val(goodsStock);
		$("#goodsGradeUpdate").val(shipNo);
		$(".modalImageNamePrint").text("");
		$("#updateMenu").find(".goodsImageDiv").hide();
		$("#updateMenu").find("#imageCheckBox").prop("checked",false);
		$("#imageDeleteFile").val(goodsImage);
		$("#goodsImageStock").attr("src",goodsImage);
		$("#goodsNameStock").text(goodsName);
		$("#currentStock").text(goodsStock);
		//상품 등록 폼 보이기
		$("#goodsModal #goodsWriteDiv").hide();
		//상품 수정 폼 숨기기
		$("#goodsModal #goodsUpdateDiv").show();
		//할인율 div 숨기기
		if(category != '쿠폰')
			$("#discountRateUpdate").closest(".form-group").hide();
		else 
			$("#discountRateUpdate").closest(".form-group").show();
		//부모 이벤트 막기
		e.stopPropagation();
	});
	
	//상품 이미지 수정 체크 이벤트
	$("#imageCheckBox").change(function() {
		//체크된 상태면 이미지 입력태그 나타남
		if($(this).is(":checked")) {
			$(this).parent().next().show();
		} else {
			$(this).parent().next().hide();
		}
		
	});
	
	//재고 +,- 버튼 클릭
	$("#stockUpdateMenu .plusBtn").click(function() {
		let stock = Number($("#stockUpdateMenu #goodsStockUpdate").val());
		$("#stockUpdateMenu #goodsStockUpdate").val(stock+1);
	});
	
	//재고 +,- 버튼 클릭
	$("#stockUpdateMenu .minusBtn").click(function() {
		let stock = Number($("#stockUpdateMenu #goodsStockUpdate").val());
		if(stock-1 < 0)
			$("#stockUpdateMenu #goodsStockUpdate").val(0);
		else
			$("#stockUpdateMenu #goodsStockUpdate").val(stock-1);
	});
	
});