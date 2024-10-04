/**
 * 포인트 샵 서비스 처리
 */
$(function() {
	
	//검색 버튼 클릭 이벤트
	$("#searchBtn").click(function() {
		let goodsName =  $("#pointShopSearch").val();
		let category = $(".modal-sidebar .cateActive").data("category");
		service.list(showList,goodsName,category);
	});
	//input 엔터 버튼 클릭 이벤트
	$("#pointShopSearch").keyup(function(key) {
		if(key.keyCode == 13) {
			let goodsName =  $("#pointShopSearch").val();
			let category = $(".modal-sidebar .cateActive").data("category");
			service.list(showList,goodsName,category);
		}
	});
	//카테고리 클릭 이벤트
	$(".modal-sidebar .category").click(function() {
		$(".modal-sidebar .category").removeClass("cateActive"); 
		$(this).addClass("cateActive");
		let goodsName =  $("#pointShopSearch").val();
		let category = $(".modal-sidebar .cateActive").data("category");
		console.log(goodsName);
		console.log(category);
		service.list(showList,goodsName,category);
	});
	
	//상품 등록 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='등록') {
			//무결성 검사
			if(isEmpty("#goodsModal #goodsNameInput","상품 이름")||
			isFileEmpty("#goodsModal #goodsImageInput","상품 이미지")||
			isEmpty("#goodsModal #pointAmountInput","상품 금액")||
			isEmpty("#goodsModal #goodsStockInput","상품 재고")||
			isEmpty("#goodsModal #cateInput","카테고리")||
			isEmpty("#goodsModal #goodsGradeInput","상품 등급")) 
				return false;
			if(lengthCheck("#goodsModal #goodsNameInput","상품 이름",2,100)) 
				return false;
			if($("#cateInput").val()=='쿠폰') {
				if(isEmpty("#goodsModal #discountRateInput","할인율"))
					return false;
			}
			//아작스를 통해 데이터를 넘기기위해 FormData 생성
			let formData1 = new FormData();	
			
			//이미지 파일을 가져온다.
			let goodsImageFile = document.getElementById('goodsImageInput').files[0];
			
			
			
			//console.log(goodsImageFile);
			
			//form에 입력된 데이터를 가져와 formData1에 저장
			formData1.append("goodsName",$("#goodsNameInput").val());
			formData1.append("goodsImageFile",goodsImageFile);
			formData1.append("pointAmount",$("#pointAmountInput").val());
			formData1.append("goodsStock",$("#goodsStockInput").val());
			formData1.append("category",$("#cateInput").val());
			formData1.append("shipNo",$("#goodsGradeInput").val());
			formData1.append("discountRate",$("#discountRateInput").val());			
			
			
			let keys = formData1.values();
			for(let i of keys) {
				console.log(i);
			}
			//상품을 등록
			service.write(function(data) {
				alert(data);	
				let goodsName =  $("#pointShopSearch").val();	
				let cate = $(".modal-sidebar .cateActive").data("category");	
				//등록후 리스트 출력
				service.list(showList,goodsName,cate);
				//등록후 모달창 닫기
				$("#goodsModal").modal("hide");
			}
			,formData1);
		}
	});	
	
	//상품 수정 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='수정' && $("#goodsModal .nav-tabs").find(".active").text() == '상품 수정' ) {		
			//무결성 검사
			if(isEmpty("#goodsModal #goodsNameUpdate","상품 이름")||			
			isEmpty("#goodsModal #pointAmountUpdate","상품 금액")||
			isEmpty("#goodsModal #cateUpdate","카테고리")||
			isEmpty("#goodsModal #goodsGradeUpdate","상품 등급")) 
				return false;
			if(lengthCheck("#goodsModal #goodsNameUpdate","상품 이름",2,100)) 
				return false;
			if($("#cateInput").val()=='쿠폰') {
				if(isEmpty("#goodsModal #discountRateUpdate","할인율"))
					return false;
			}	
			
			let formData1 = new FormData();			
			
			if($("#imageCheckBox").is(":checked")) {
				if(isFileEmpty("#goodsModal #goodsImageUpdate","상품 이미지")) return false;
				let goodsImageFile = document.getElementById('goodsImageUpdate').files[0];
				formData1.append("goodsImageFile",goodsImageFile);
				let imageDeleteFile = $("#imageDeleteFile").val();
				formData1.append("imageDeleteFile",imageDeleteFile);
			}
			
			
			//console.log(goodsImageFile);
			
			formData1.append("goodsId",$("#goodsIdUpdate").val());			
			formData1.append("goodsName",$("#goodsNameUpdate").val());			
			formData1.append("pointAmount",$("#pointAmountUpdate").val());			
			formData1.append("category",$("#cateUpdate").val());
			formData1.append("shipNo",$("#goodsGradeUpdate").val());
			formData1.append("discountRate",$("#discountRateUpdate").val());
			
			let keys = formData1.values();
			for(let i of keys) {
				console.log(i);
			}
			//상품을 수정
			service.update(function(data) {
				//등록후 모달창 닫기
				$("#goodsModal").modal("hide");
				
				//등록후 리스트 출력
				let goodsName =  $("#pointShopSearch").val();
				let cate = $(".modal-sidebar .cateActive").data("category");
				service.list(showList,goodsName,cate);									
				alert(data);	
				
				
				
			}
			,formData1);
		}
	});	
	
	//상품 수정 버튼 클릭 이벤트
	$("#goodsModal #goodsSubmitBtn").click(function() {
		if($(this).text()=='수정' && $("#goodsModal .nav-tabs").find(".active").text() == '재고 수정' ) {			
			if(isEmpty("#goodsModal #goodsStockUpdate","상품 재고")) return false;
			
			
			let formData1 = new FormData();			
			
			
			formData1.append("goodsId",$("#goodsIdUpdate").val());			
			formData1.append("goodsStock",$("#goodsStockUpdate").val());			
			formData1.append("currentStock",$("#currentStock").text());			
			
			
			let keys = formData1.values();
			for(let i of keys) {
				console.log(i);
			}
			//상품의 재고를 수정
			service.updateStock(function(data) {
				alert(data);		
				
				//등록후 리스트 출력
				let goodsName =  $("#pointShopSearch").val();
				let category = $(".modal-sidebar .cateActive").data("category");
				service.list(showList,goodsName,category);
				//등록후 모달창 닫기
				$("#goodsModal").modal("hide");
			}
			,formData1);
		}
	});	
	
	//상품 판매 중지 버튼 클릭
	$("#goodsListDiv").on("click",".stopSaleBtn",function(e) {			
		
		let goodsId = $(this).closest(".goodsCard").data("goodsid");			
		let stopSell = $(this).data("stopsell");		
		
		//상품의 재고를 수정
		service.delete(function(data) {
			alert(data);				
			//등록후 리스트 출력
			let goodsName =  $("#pointShopSearch").val();
			let category = $(".modal-sidebar .cateActive").data("category");
			service.list(showList,goodsName,category);
			
		}
		,goodsId,stopSell);
		
		//부모 이벤트 막기
		e.stopPropagation();
	});
	
	//상품 삭제 버튼 클릭
	$("#goodsListDiv").on("click",".goodsDeleteBtn",function(e) {			
		
		let goodsId = $(this).closest(".goodsCard").data("goodsid");
		let goodsImage = $(this).closest(".goodsCard").find(".card-img-top").prop("src");
		
		//상품의 재고를 수정
		if(confirm("해당 상품을 정말로 삭제 하시겠습니까?\n(이미 구매된 상품을 삭제가 불가능합니다.)")){
			service.realDelete(function(data) {				
				service.list(showList,"","");				
			}
			,goodsId,goodsImage);			
		}
		
		//부모 이벤트 막기
		e.stopPropagation();
	});
});
	

//data를 포인트샵 리스트로 출력
function showList(data) {
	
			//멤버쉽 번호를 이름으로 바꾸기 위한 JSON
			let shipMap = {
					"1":"bronze",
					"2":"gold",
					"3":"diamond",
			};
	
			let list = data.list;			
			let point = numWithComma(data.point);
			//현재 포인트 출력
			$("#pointShopPoint").text(point);
			
			retryCount = 0;
			
			let rowCnt = 0;
			
			//상품 리스트 출력할 태그
			let goodsList =``;
			
			for(let i=0;i<list.length;i++) {
				let goodsId = list[i].goodsId;
				let goodsName = list[i].goodsName;
				let goodsImage = list[i].goodsImage;				
				let goodsStock = list[i].goodsStock;
				let amount = numWithComma(list[i].pointAmount);
				let category = list[i].category;
				let discountRate = list[i].discountRate;
				let shipNo = list[i].shipNo;
				let shipName = shipMap[shipNo];
				let stopSell = list[i].stopSell;
				if(i == 0) {
					let borderClass = "";
					if(shipNo == '3') borderClass = "diamond-border";
					else if(shipNo == '2') borderClass = "gold-border";
					else if(shipNo == '1') borderClass = "bronze-border";
					else borderClass = "no-grade-border";
					goodsList = `
						<div class="${borderClass}">
							<div class="row">
					`;
				}
				
				if(i != 0 && shipNo != list[i-1].shipNo) {
					let borderClass = "";
					if(shipNo == '3') borderClass = "diamond-border";
					else if(shipNo == '2') borderClass = "gold-border";
					else if(shipNo == '1') borderClass = "bronze-border";
					else borderClass = "no-grade-border";
					rowCnt = 0;
					goodsList += `
							</div>
						</div>
						<div class="${borderClass}">
							<div class="row">
					`;
				}
				
				if(rowCnt != 0 && rowCnt%3 == 0) {
					goodsList += `
					</div>
					<div class="row">
					`;
				}
				let time = new Date().getTime();
				goodsList += `
				<div class="col-lg-4">
							
					<div class="card shadow-sm m-2 d-flex flex-column goodsCard" 
					data-goodsid="${goodsId}" data-category="${category}" 
					data-discountRate="${discountRate}" data-shipNo="${shipNo}">						
						<img class="card-img-top" src="${goodsImage}?t=${time}" alt="Card image"
						 onerror="if (retryCount < maxRetries) {
								retryCount++; 
								setTimeout(() => { 
									this.src='${goodsImage}?t=${new Date().getTime()}'; 
								}, 1000); 
								} else { 
									console.error('Image load failed after maximum retries'); 
								}">`;
				if(pointShopGradeNo == '9') {
					if(stopSell == 0) {
						goodsList += `<button class="btn btn-sm btn-outline-danger stopSaleBtn float-right" data-stopSell=${stopSell}>
						<i class="fa fa-ban"></i>
						</button>`;				
					} else {
						goodsList += `<button class="btn btn-sm btn-outline-success stopSaleBtn float-right" data-stopSell=${stopSell}>
						<i class="fa fa-check-circle"></i>
						</button>`;
					}						
									
					goodsList += `<button class="btn btn-sm btn-outline-secondary updateBtn float-right">
								<i class="fa fa-edit"></i>
							</button>`;
				}
						
						
				goodsList += `<div class="card-body d-flex flex-column justify-content-between">
							<div class="card-title mt-2 d-flex align-items-center">
								<img class="shipBadge" src="/upload/member/ship/${shipName}.png">
								<b style="font-size: 25px;" class="goodsName">${goodsName}</b>`;
				if(stopSell == 1)
					goodsList += `<b class="text-danger">(판매중지)</b> <button class="btn btn-danger btn-sm mb-2 goodsDeleteBtn"><i class="fa fa-trash"></i></button>`					
				goodsList +=		`</div>					
							<div class="mt-auto d-flex justify-content-between align-items-center">
        						<span class="card-text"><span class="text-primary"><span class="amount">${amount}</span>BP</span> `;
				if(goodsStock == 0) {
					goodsList += `<span class="goodsStock text-danger" data-goodsstock=${goodsStock}>(품절)</span></span>`;
				} else {
					goodsList += `<span class="goodsStock" data-goodsstock=${goodsStock}>(${goodsStock}개 남음)</span></span>`;				
				}
				goodsList += `
							
      						</div>
      						
					  	</div>
					</div>
								
				</div>
				`;
				rowCnt++;
				
			}		
			
		goodsList += `
						</div>
					</div>
					`;		
		
		$("#goodsListDiv").html(goodsList);		

		
		
	}
