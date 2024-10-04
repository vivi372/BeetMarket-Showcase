<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>	
	$(function() {
		if(${empty vo}){
			$("#postApiAddrDetailDiv").hide();
			$("#postApiAddrDiv").hide();			
		} else {
			$("#postApiAddrDetailDiv").show();
			$("#postApiAddrDiv").show();
			$("#sample4_roadAddress").val('${vo.addr}');
			$("#sample4_detailAddress").val('${vo.addrDetail}');
			$("#sample4_postcode").val('${vo.postNo}');
		}
	});
	function validatePhoneNumber(input) {
	    // 숫자와 하이픈만 남기고 나머지는 제거
	    input.value = input.value.replace(/[^0-9-]/g, '');

	    // 자동으로 전화번호 형식으로 변환 (000-0000-0000)
	    var cleaned = input.value.replace(/[^0-9]/g, ''); // 숫자만 남김
	    if (cleaned.length > 3 && cleaned.length <= 7) {
	      input.value = cleaned.slice(0, 3) + '-' + cleaned.slice(3);
	    } else if (cleaned.length > 7) {
	      input.value = cleaned.slice(0, 3) + '-' + cleaned.slice(3, 7) + '-' + cleaned.slice(7);
	    }
	  }
	
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;               
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                	document.getElementById("sample4_roadAddress").value = document.getElementById("sample4_roadAddress").value + extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

//                 var guideTextBox = document.getElementById("guide");
//                 // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
//                 if(data.autoRoadAddress) {
//                     var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
//                     guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
//                     guideTextBox.style.display = 'block';

//                  } else {
//                    guideTextBox.innerHTML = '';
//                    guideTextBox.style.display = 'none';
//                 }
                
                $("#postApiAddrDiv").show();
        		$("#postApiAddrDetailDiv").show();
            }
        }).open();
       
    }
</script>
</head>
<body>
<div class="container">
<form action="Apply.do" method="post">
	<div class="form-group">
		<label for="id">아이디</label>
		<input class="form-control" name="id" id="id" required>
	</div>
	<div class="form-group">
	  <label for="tel">전화번호</label>
	  <input class="form-control" name="tel" id="tel" required pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}" title="전화번호 형식: 000-0000-0000" maxlength="13" oninput="validatePhoneNumber(this)">
	</div>
	<input type="text" name="address" placeholder="주소" required>
	<input type="hidden" name="event_no" value="${param.event_no}" />
	<button class="btn btn-primary">신청</button>
 </form>
</div>
</body>
</html>