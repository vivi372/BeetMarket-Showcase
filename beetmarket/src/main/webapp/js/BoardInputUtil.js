/**
 *  게시판 류의 필요한 처리 메서드
 */
console.log("js loading");
// 입력 데이터가 비어 있는 경우의 메서드
// 비어 있다면 true를 리턴한다.
// 결과가 true이면 페이지 이동을 막기 위해서 추후에  return false를 실행해야 한다.
// isEmpty(객체 이름 - 선택자, 항목 이름)
function isEmpty(objName, name, trim) {	
	//console.log(objName+" "+name+" "+trim+" ");
	let str = $(objName).val();	
	//console.log(str);
	if(trim)
		str=str.trim();
	// 공백을 제거한 데이터를 입력 객체에 다시 넣는다.
	$(objName).val(str);
	if (str == "") {
		alert(name+"은(는) 필수 입력 항목입니다."); // 경고
		$(objName).focus(); // 커서 위치
		return true; // 비어있음(true)을 리턴한다.
	} // 체크의 끝
 } // end of isEmpty() 

function isFileEmpty(objName, name) {	
	//console.log(objName+" "+name+" "+trim+" ");
	let file = $(objName)[0].files;	
	if (file == null) {
		alert(name+"은(는) 필수 입력 항목입니다."); // 경고
		$(objName).focus(); // 커서 위치
		return true; // 비어있음(true)을 리턴한다.
	} // 체크의 끝
 } // end of isFileEmpty() 

function isClassEmpty(className, name) {	
	let result;
	//console.log(objName+" "+name+" "+trim+" ");
	$(className).each(function(){
		let str = $(this).val();
		if (str == "") {
			result =  true; // 비어있음(true)을 리턴한다.
		} // 체크의 끝
	});
	
	if(result) {
		alert(name+"은(는) 필수 입력 항목입니다."); // 경고
		return true;	
	}
		
 } // end of isEmpty() 

 // 길이 제한 메서드
 function lengthCheck(objName, name, min, max, trim) {
	//console.log(objName+" "+name+" "+min+" "+max+" "+trim+" ");
	let str = $(objName).val();	
	if(trim) {
		str=str.trim();
		// 공백을 제거한 데이터를 입력 객체에 다시 넣는다.
		$(objName).val(str);
	}
	let len = str.length;
	if(len<min || len>max) {
		alert(name+"은(는) "+min+"자 이상 "+max+"자 이내로 입력하셔야 합니다.");
		$(objName).focus(); // 커서 위치
		return true;
	}
 } // end of lengthCheck()

 // 길이 제한 메서드
 function classlengthCheck(objName, name, min, max) {
	let result = false;
	//console.log(objName+" "+name+" "+min+" "+max+" "+trim+" ");
	$(objName).each(function(){
		let str = $(this).val();	
		
		let len = str.length;
		if(len<min || len>max) {
			result = true;
			
		}		
	});
	
	if(result) {
		alert(name+"은(는) "+min+"자 이상 "+max+"자 이내로 입력하셔야 합니다.");
		return true;
	}
 } // end of lengthCheck()
 
/**
 * 옵션 수,수량 체크 메서드
 */
function optLengthCheck($form) {
	//$optCard 안에 있는 옵션 아이템의 수를 가져온다.
	let optLength = $($form).find(".amount").length;
	//0개뿐이면 경고를 출력하고 true 반환
	if(optLength == 0) {
		alert("옵션을 하나 이상 선택하셔야 합니다.");
		return true;
	}
	if($($form).find(".amount:first").val()<1) {
		alert("하나 이상의 수량을 선택하셔야 합니다.");
		return true;
	}
}
/**
* 데이터 비교 체크
*/
function compareCheck(objName1,objName2,name1,name2) {
	//objName 안에 있는 값을 가져온다.
	let objName1Data = $(objName1).val();
	let objName2Data = $(objName2).val();

	if(objName1Data!=objName2Data) {
		alert(name2+"은 "+name1+"과 같아야 합니다.");
		return true;
	}
}
/**
 * 수량 체크 메서드
 */
function amount($amount) {
	//수량 input 태그안에 있는 값 가져오기
	let amount = $amount.val();
	//값이 1보다 작으면 경고 출력하고 true 반환
	if(amount < 1) {
		alert("한개 이상 구매하셔야 합니다.");
		return true;
	}
}
/**
 * 데이트 픽커 체크
 */
function dateCheck($hopeDate){
	//희망 관람일의 값을 가져오기
	let hopeDate = $hopeDate.val();
	//값이 아무것도 없다면 경고를 출력하고 true 반환
	if(hopeDate == "") {
		alert("관람일은 반드시 선택하셔야 합니다.");
		return true;
	}
	
}
/**
 * 카테고리에 따른 무결성 검사
 */
function integrityOpt(categoryNo,$optCard,$amount,$hopeDate) {
	if(2000 > categoryNo && categoryNo >=1000) {
		//책일 경우 수량 체크
		return amount($amount);
	} else if(3000> categoryNo && categoryNo >= 2000) {
		//상품 경우 옵션 수 체크
		return optLengthCheck($optCard);
	} else if(4000>categoryNo && categoryNo>=3000) {
		//티켓일 경우 옵션 수와 데이트피커 체크
		return (optLengthCheck($optCard) || dateCheck($hopeDate))
	}
}

/**
 * 체크 수 메서드 <br>
 * $checkBax - 체크된 수량을 확인하고 싶은 체크박스들의 클래스 <br>
 * ex) checkedLength(".basketCheckBox:checked");
 */
function checkedLength($checkBax) {
	//체크된 체크박스 수를 가져온다.
	let checkBaxLength = $($checkBax).length;
	//수가 0이면 경고를 출력하고 true 반환
	if(checkBaxLength == 0) {
		alert("하나 이상의 물건을 선택하셔야 합니다.");
		return true;
	}
}
 
//정규식 확인
 function reg(objName, strAlert, regExp){
	let str = $(objName).val(); 	
	console.log(str);
	if(!regExp.test(str)){
		alert(strAlert);
		$(objName).focus(); // 커서 위치
		return true;
	}
 }
 // body부분의 문서가 로딩이 끝나면 처리되는 부분
 $(function(){
	
	$(".cancelBtn").click(function(){
		history.back();
	})
	
 })