<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.beetpayDiv {
	margin: 30px;
}

.owl-carousel .beetCard {
	 width: 350px; /* 고정된 너비 설정 */
     height: 300px;
	 flex-direction: column; /* 세로로 정렬 */
  	align-items: center;    /* 가로로 가운데 정렬 */
     display: flex;
     justify-content: center;
     align-items: center;

}
 /* 캐로셀 패딩 설정 (캐로셀 전체 외부 공간) */
.carousel-container {
    padding: 20px; /* 캐로셀 외부에 패딩을 추가 */
}

 /* 내비게이션 버튼 기본 스타일 */
.owl-nav button.owl-prev, 
.owl-nav button.owl-next {
    font-size: 2rem !important; /* 화살표 크기 */
    background-color: transparent; /* 기본 배경을 투명으로 설정 */
    border: none;
    color: #02c75b; /* 화살표 색상 변경 */
    padding: 10px 20px  !important; /* 여백 추가 */
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    transition: background-color 0.3s, box-shadow 0.3s; /* 애니메이션 추가 */
}

/* 이전 버튼 위치 (왼쪽) */
.owl-nav button.owl-prev {
    left: 0px; /* 캐로셀 왼쪽 밖으로 이동 */
}

/* 다음 버튼 위치 (오른쪽) */
.owl-nav button.owl-next {
    right: 0px; /* 캐로셀 오른쪽 밖으로 이동 */
}

/* 마우스를 올렸을 때 스타일 */
.owl-nav button.owl-prev:hover, 
.owl-nav button.owl-next:hover {
    background-color: #028001 !important; /* 배경 색상을 #800080으로 변경 */
    color: white !important; /* 화살표 색상을 흰색으로 변경 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* 그림자 추가 */
}

/* 클릭 시 스타일 */
.owl-nav button.owl-prev:focus, 
.owl-nav button.owl-next:focus {
    outline: none !important; /* 기본 초점 제거 */
    background-color: #02c75b !important; /* 클릭 시 배경색 */
    color: white !important; /* 화살표 색상 흰색으로 변경 */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.5); /* 클릭 시 그림자 */
}


/* 페이지네이션 점 색상 변경 */
.owl-dots .owl-dot span {
    background-color: #145a32 !important; /* 점의 기본 색상 변경 */
}

.owl-dots .owl-dot.active span {
    background-color: #02c75b !important; /* 점의 기본 색상 변경 */
}

/* PayCard 기본 스타일 */
.payCard {
    position: relative;
    width: 300px; /* 카드의 너비 */
    height: 180px; /* 카드의 높이 */
    display: flex;
    justify-content: center;
    align-items: center;
    cursor: pointer;
    margin-bottom: 15px; /* 카드와 select 사이에 약간의 공간 추가 */
}


/* 카드 이미지: 좌측 상단에 위치 */
.cardImage {
    position: absolute;
    top: -60px;
    left: -50px;
    width: 250px !important; /* 이미지 너비 조정 */
    height: auto;
}

/* 카드 번호: 카드의 정중앙에 위치 */
.cardNumber {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); /* 중앙 정렬 */
    font-size: 18px;
    letter-spacing: 2px; /* 각 숫자 그룹 사이의 간격 조정 */
    white-space: nowrap; /* 줄바꿈 방지 */
    text-align: center; /* 텍스트와 버튼 모두 중앙 정렬 */
}


 /* 버튼 스타일 */
.cardNumber button {
    width: 50px;
    height: 50px;
    border-radius: 50%; /* 버튼을 원형으로 */
    background-color: #02c75b; /* 버튼 배경색 (Bootstrap 기본색) */
    color: white; /* 버튼 텍스트 색상 */
    border: none;
    font-size: 24px;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 카드 브랜드: 우측 하단에 위치 */
.cardBrand {
    position: absolute;
    bottom: -40px;
    right: -50px;
    width: 200px !important; /* 브랜드 이미지 너비 조정 */
    height: auto;
}

 /* 카드 번호 입력 필드 */
.cardNumberGroup input {
    width: 21% !important; /* 각 필드가 전체 그룹의 약 22% 차지 */
    height: 40px;
    font-size: 18px;
    text-align: center;
/*     border: 1px solid #ccc; */
/*     border-radius: 5px; */
}

/* readonly input 태그의 스타일을 일반 input과 동일하게 설정 */
#beetpayWriteModal input[readonly] {
    background-color: white !important; /* 배경색 */
    color: black !important; /* 텍스트 색 */
/*    	border: 1px solid #ccc !important;  */
}

/* 구분자 아이콘 스타일 */
.separator {
    font-size: 18px;
    color: #333;
}

#beetpayWriteModal input, #beetpayPasswordModal input {
	width: 100%;
  	border: none; /* 모든 테두리 제거 */
  	border-bottom: 2px solid #aaa; /* 아래쪽에 회색 실선 추가 */
  	padding: 10px;
}

#beetpayWriteModal input:focus, #beetpayPasswordModal input:focus {
	border-bottom: 2px solid #03c75a; /* 포커스 시 하단 테두리 색상 변경 */
	outline: none; /* 외곽선 제거 */
 	box-shadow: none; /* 포커스 시 생기는 특수 효과 제거 */
}


</style>
<link rel="stylesheet" href="/css/owl.carousel.css">
<link rel="stylesheet" href="/css/owl.theme.default.css">
<link rel="stylesheet" href="/css/beetpay.css">
<script type="text/javascript" src="/js/owl.carousel.min.js"></script>
<script type="text/javascript">
function beetpayList() {
	//카드 리스트 출력
	$(".beetpayDiv").load("/beetpay/list.do", function() {
		$('.owl-carousel').owlCarousel({
			items: 2,
			center:true,
		    margin:30,
		    nav:true,
		    navText: ['<', '>'],  /* 내비게이션 텍스트 커스터마이징 */
		    dots:true,
		    mouseDrag:true,
		    touchDrag:true,
		    pullDrag:true,
		    onChanged: function(event) {
		        // 현재 중앙에 있는 아이템의 인덱스
		        let centerIndex = event.item.index + Math.floor(event.page.size / 2);

		        // 중앙 아이템 선택
		        let $centerItem = $(event.target).find('.owl-item').eq(centerIndex).find('div');
		        
		        // 중앙에 있는 아이템에 클래스를 추가하거나 다른 작업 수행
		        $(".payCard").removeClass("active");
		        $centerItem.find(".payCard").addClass("active");
		     }
		});
	});
}

$(function() {
	
	
	
	$("#beetpayWriteModal").draggable();
	
	//카드 리스트 출력
	beetpayList();
	
	//카드 등록 버튼 클릭이벤트
	$(".beetpayDiv").on("click","#beetpayWriteBtn",function() {
		//비트페이 비밀번호 존재여부를 가져온다.
		let isPassword = $(".owl-carousel").data("ispassword");
		//존재하면 비밀번호 입력 부분을 숨기고
		if(isPassword) $("#payPasswordDiv").hide();
		//없으면 비밀번호 입력 부분 등장
		else $("#payPasswordDiv").show();
		$("#cardDetailDiv").hide();
		$("#beetpayWriteModal input").val("");
		$("#beetpayWriteModal").modal("show");
	});
	
	//카드 삭제 이벤트
	$(".beetpayDiv").on("click",".payCard",function() {
		if($(this).hasClass("writeCard")) return;
		let beetpayNo = $(this).data("beetpayno");
		if(confirm("해당 카드를 정말로 삭제하시겠습니까?")){
			let formData = new FormData();
			formData.append("beetpayNo",beetpayNo);
			//담은 데이터로 카드를 삭제
			$.ajax({
			    url: "/beetpay/delete.do", // 서버 URL
			    type: "POST",
			    data: formData,
			    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
			    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
			    success: function(data) {
			       alert(data);			
			       beetpayList();
			    },
			    error: function(xhr,status,err) {
					console.log("xhr-"+JSON.stringify(xhr));
					console.log("status-"+status);
					console.log("err-"+err);
					alert(xhr.responseText);
			    }
			});
			
		}
		
	});
	
	//api를 통해 카드 정보 가져오기
	$(".cardNumberInput").keyup(function() {
		//입력한 카드 번호가 첫번째나 두번째칸일때
		let index = $(this).index();
		if(index == 0 || index == 2){
			let cardNumber1 = $(".cardNumberInput").eq(0).val();
			let cardNumber2 = $(".cardNumberInput").eq(1).val();
			//카드 번호가 8자 이상 입력되면 정보를 가져온다.
			if(cardNumber1.length==4 && cardNumber2.length==4) {
				let bin = cardNumber1+cardNumber2;
				console.log(bin);
				//카드 정보 가져오기
				let settings = {
						async: true,
						crossDomain: true,
						url: `https://bin-ip-checker.p.rapidapi.com/?bin=\${bin}`,
						method: 'POST',
						headers: {
							'x-rapidapi-key': 'e27f927316msh17728d5e05a657ep1f205cjsnb7a806adc04d',
							'x-rapidapi-host': 'bin-ip-checker.p.rapidapi.com',
							'Content-Type': 'application/json'
						},
						processData: false,
						data: '{"bin":"448590"}'
				};
	
				$.ajax(settings).done(function (response) {
					console.log(response);
					let cardType = response.BIN.type;
					let cardCompany = response.BIN.issuer.name;
					cardCompany = cardCompany.substring(0,cardCompany.indexOf(' '));
					let cardBrand = response.BIN.brand;
					if(companyMap[cardCompany]!=null && companyMap[cardCompany] != '') {
						//가져온 데이터 모달에 입력
						$("#cardCompanyInput").val(companyMap[cardCompany]);
						$("#cardCompanyRealInput").val(cardCompany);
						$("#cardBrandInput").val(cardBrand);
						$("#cardTypeInput").val(typeMap[cardType]);		
						$("#cardDetailDiv").show();
					} else {
						alert("비트페이에 등록할수 없는 카드입니다.");
					}						
				});
			}
		}
	});
	
	
	//카드 등록 모달의 등록 버튼 클릭 이벤트
	$("#beetpayWriteModal #submitBtn").click(function() {
		
		//무결성 검사 - 카드 번호, 카드 회사, 유효기간, cvc,카드 비밀번호,비트페이 비밀번호
		let payPasswordDivDisplay = $("#payPasswordDiv").css("display");
		console.log(payPasswordDivDisplay);
		if(payPasswordDivDisplay != 'none') {
			if(isEmpty("#payPassword","비트페이 비밀번호")||lengthCheck("#payPassword","비트페이 비밀번호",6,6)
					||compareCheck("#payPassword","#payPassword2","비트페이 비밀번호","비트페이 비밀번호 확인")) return false;
		}
		if(isClassEmpty(".cardNumberInput","카드 번호")||isEmpty("#cardCompanyInput","카드 번호")||
				isEmpty("#expirationPeriod","유효기간")||isEmpty("#cvc","cvc")||isEmpty("#cardPass","카드 비밀번호")) 
			return false;
		if(classlengthCheck(".cardNumberInput","카드 번호",4,4)||lengthCheck("#expirationPeriod","유효기간",4,4)
				||lengthCheck("#cvc","cvc",3,3)||lengthCheck("#cardPass","카드 비밀번호",2,2)) 
			return false;
		//모달에 작성된 데이터 담기
		let formData = new FormData();
		
		let cardNumber1 = $(".cardNumberInput").eq(0).val();
		let cardNumber2 = $(".cardNumberInput").eq(1).val();
		let cardNumber = cardNumber1+' '+cardNumber2+' '+"****"+' '+"****";
		
		formData.append("cardCompany", $("#cardCompanyRealInput").val());
		formData.append("cardBrand", $("#cardBrandInput").val());
		formData.append("cardType", $("#cardTypeInput").val());
		formData.append("cardNumber", cardNumber);
		if(payPasswordDivDisplay != 'none') {
			let payPassword = $("#payPassword").val();
			formData.append("payPassword", payPassword);
			
		}
		
		//담은 데이터로 카드를 등록
		$.ajax({
		    url: "/beetpay/write.do", // 서버 URL
		    type: "POST",
		    data: formData,
		    processData: false, // jQuery에서 데이터를 처리하지 않도록 설정
		    contentType: false, // HTTP 헤더의 Content-Type을 자동으로 설정하지 않도록 설정
		    success: function(data) {
		       $("#beetpayWriteModal").modal("hide");
		       alert(data);			
		       beetpayList();
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
</script>

<div class="beetpayDiv border rounded-lg">

</div>


