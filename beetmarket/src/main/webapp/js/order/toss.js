/**
 * 토스 결제 위젯 관련 js
 */

$(function(){
	main();
	
	$("#beetpayPasswordModal #submitBtn").click(function() {
		if(isEmpty("#beetpayPasswordModal #payPassword","비트페이 비밀번호")||lengthCheck("#beetpayPasswordModal #payPassword","비트페이 비밀번호",6,6)) return false;
		let payPassword = $("#beetpayPasswordModal #payPassword").val();
		let formData = new FormData();
		formData.append("payPassword",payPassword);
		$.ajax({
		    url: "/beetpay/passwordCheck.do", // 서버 URL
		    type: "POST",
		    data: formData,
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		       //비밀번호가 맞으면 결제 데이터를 가져와 결제
				let query = $("#queryInput").val();
				let payQuery = $("#payQueryInput").val();
				location = "write.do?query="+query+"&payQuery="+encodeURIComponent(payQuery); 
		    },
		    error: function(xhr,status,err) {
				console.log("xhr-"+JSON.stringify(xhr));
				console.log("status-"+status);
				console.log("err-"+err);
				//$("#beetpayWriteModal").modal("hide");
				alert(xhr.responseText);
		    }
		});
	});
});
async function main() {
	const button = document.getElementById("orderSubmitBtn");
	
    // ------  결제위젯 초기화 ------
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const tossPayments = TossPayments(clientKey);
    // 회원 결제
    const customerKey = uuidv4();
    const widgets = tossPayments.widgets({
      customerKey,
    });

    // ------ 주문의 결제 금액 설정 ------
    await widgets.setAmount({
      currency: "KRW",
      value: 1000,
	});
	
    await Promise.all([
        // ------  결제 UI 렌더링 ------
        widgets.renderPaymentMethods({
          selector: "#payment-method",
          variantKey: "DEFAULT",
        }),
        // ------  이용약관 UI 렌더링 ------
        widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
     ]);

	button.addEventListener("click", async function () {
		
		// ------ 주문의 결제 금액 설정 ------
	    await widgets.setAmount({
	      currency: "KRW",
	      value: Number(numWithoutComma($("#totalOrderPrice").text())),
		});
			
		let data = $("#writeForm").serializeArray();
		
		console.log(data);			
		let form = {
				dlvyAddrNo: '',
				goodsId: '',				  
				payWay: '',
				items: [],  // goods 관련 항목들은 여기에 배열로 들어감
				basketNo: [],
		};			
		data.forEach((item) => {
			if(item.name != 'dlvyMemo') {
				
			  if (item.name === 'goodsNo' || item.name === 'optNo' || item.name === 'amount' || item.name === 'orderPrice' || item.name === 'dlvyCharge') {
			    // items 배열에 해당하는 값을 그룹화하여 추가
			    if (form.items.length === 0 || form.items[form.items.length - 1][item.name]) {
				
			    	form.items.push({});
			    }
			    form.items[form.items.length - 1][item.name] = item.value;
			  } else {
				if(item.name==='basketNo') {
				 	form.basketNo.push(item.value);
				} else {
					// 공통 필드 처리
			    	form[item.name] = item.value;
				}
			    
			  }
			} 
		});	
		
		//무결성 체크 - dlvyAddrNo,카드 선택
		if(isEmpty("#dlvyAddrNoInput","배송지")) return false;
		
		
		let cnt = 0;
		data.forEach((x) => {
			if(x.name=='dlvyMemo') {
				form.items[cnt++]['dlvyMemo'] = x.value;				
			}
		});
		
		if(cnt < form.items.length) {
			form.items.forEach((item)=> {
				item['dlvyMemo'] = form.items[0]['dlvyMemo'];
			});
		}
		
		
		
		console.log(form);
		let strJSON = encodeURIComponent(JSON.stringify(form));
		console.log(strJSON);
		
		
		
		if(form.payWay == '카드간편결제') {
			let payCard = $(".owl-carousel").find(".payCard.active");
			if(payCard.hasClass("writeCard")) {
				alert("결제 가능한 카드가 아닙니다. 다시 선택해주세요");
				return false;
			}
			let cardNumber = payCard.find(".cardNumber").text();
			let cardCompany = payCard.data("cardcompany");
			let installment = payCard.closest(".beetCard").find(".installmentSelect").val();
			let strPayQuery = companyMap[cardCompany]+" "+cardNumber+" "+installment;
			//비트페이 비밀번호 확인
			$("#beetpayPasswordModal #payPassword").val("");
			$("#beetpayPasswordModal #queryInput").val(strJSON);
			$("#beetpayPasswordModal #payQueryInput").val(strPayQuery);
			$("#beetpayPasswordModal").modal("show");
//			console.log(strPayQuery);

			
		} else {
			
			await widgets.requestPayment({
	            orderId: uuidv4(),
				orderName: $(".orderListItem:first").find(".goodsTitle").text()+"결제",
	            successUrl: window.location.origin + "/order/write.do?query="+strJSON ,
	            failUrl: window.location.origin + "/order/write.do",
	            customerEmail: email,
	         });
			
		}
			
		
			
		
	});
}