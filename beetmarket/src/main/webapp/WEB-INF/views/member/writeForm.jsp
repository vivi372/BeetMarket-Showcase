<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/js/member/telInput.js"></script>
<script type="text/javascript">
$(function(){
	// 날짜 입력 설정 - datepicker
	let now = new Date();
    let startYear = now.getFullYear();
    let yearRange = (startYear - 100) +":" + startYear ;
	$(".datepicker").datepicker({
		dateFormat: "yy-mm-dd",
		changeMonth: true,
		changeYear: true,
		monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
		dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
		yearRange: yearRange,
		maxDate : now
	});

	// 비밀번호와 비밀번호 확인 이벤트
	$("#pw, #pw2").keyup(function(){
		let pw = $("#pw").val();
		let pw2 = $("#pw2").val();
		if(pw.length < 4){
			$("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-danger");
			$("#pwDiv").text("비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
		} else {
			$("#pwDiv").removeClass("alert-success alert-danger").addClass("alert-success");
			$("#pwDiv").text("적당한 비밀번호를 입력하셨습니다.");
		}
		if(pw2.length < 4){
			$("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
			$("#pw2Div").text("비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
		} else {
			if(pw != pw2){
				$("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-danger");
				$("#pw2Div").text("비밀번호와 비밀번호 확인은 같아야 합니다.");
			} else {
				$("#pw2Div").removeClass("alert-success alert-danger").addClass("alert-success");
				$("#pw2Div").text("적당한 비밀번호 확인을 입력하셨습니다.");
			}
		}
	});
	
	  
});

function checkId(){
    var id = $("#id").val(); //id값이 "id"인 입력란의 값을 저장
    $.ajax({
        url:"./idCheck", //Controller에서 요청 받을 주소
        type:"post", //POST 방식으로 전달
        data:{id:id},
        success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다 
            if($(cnt).find("Integer").text() == 0){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디 
                $(".id_ok").show();
                $(".id_already").hide();
                $("#submitBtn").prop("disabled", false); // 활성화
            } else { // cnt가 1일 경우 -> 이미 존재하는 아이디            	
                $(".id_already").show();
                $(".id_ok").hide();
                $("#submitBtn").prop("disabled", true); // 비활성화
            }
        },
        error:function(){
            alert("에러입니다");
        }
    });
};
// 전화번호 중복 체크
function checkTel(){
    var tel = $("#tel").val(); //tel값이 "tel"인 입력란의 값을 저장
    $.ajax({
        url:"./telCheck", //Controller에서 요청 받을 주소
        type:"post", //POST 방식으로 전달
        data:{tel:tel},
        success:function(cnt2){ //컨트롤러에서 넘어온 cnt2값을 받는다 
            if($(cnt2).find("Integer").text() == 0){ //cnt2가 1이 아니면(=0일 경우) -> 사용 가능한 tel
                $(".tel_ok").show();
                $(".tel_already").hide();
                $("#submitBtn").prop("disabled", false); // 활성화
            } else { // cnt2가 1일 경우 -> 이미 존재하는 tel           	
                $(".tel_already").show();
                $(".tel_ok").hide();
                $("#submitBtn").prop("disabled", true); // 비활성화
            }
        },
        error:function(){
            alert("에러입니다");
        }
    });
};

// 이메일 중복 체크 
function checkEmail(){
    var email = $("#email").val(); //email값이 "email"인 입력란의 값을 저장
    $.ajax({
        url:"./emailCheck", //Controller에서 요청 받을 주소
        type:"post", //POST 방식으로 전달
        data:{email:email},
        success:function(cnt1){ //컨트롤러에서 넘어온 cnt값을 받는다 
            if($(cnt1).find("Integer").text() == 0){ //cnt1이 1이 아니면(=0일 경우) -> 사용 가능한 이메일 
                $(".email_ok").show();
                $(".email_already").hide();
                $("#submitBtn").prop("disabled", false); // 활성화
            } else { // cnt1이 1일 경우 -> 이미 존재하는 이메일            	
                $(".email_already").show();
                $(".email_ok").hide();
                $("#submitBtn").prop("disabled", true); // 비활성화
            }
        },
        error:function(){
            alert("에러입니다");
        }
    });
};

</script>

<style type="text/css">
h2{
	margin-top: 15px;
	font-size: 60px;
	border-bottom: 	#A9A9A9 1px solid;
}
.id_ok{
	color:#008000;
	display: none;
}
.id_already{
	color:#6A82FB; 
	display: none;
}

.tel_ok{
	color:#008000;
	display: none;
}
.tel_already{
	color:#6A82FB; 
	display: none;
}

.email_ok{
	color:#008000;
	display: none;
}
.email_already{
	color:#6A82FB; 
	display: none;
}
</style>
</head>
<body>
<div class="container" style="width: 800px;">
    <h2>BitMarket</h2>
    <form action="write.do" method="post" enctype="multipart/form-data">
         <div class="form-group">
         <label for="address2">아이디</label> 
			<input type="text" id="id" name="id" oninput = "checkId()" 
				required autocomplete="off"
		        class="form-control" maxlength="20"
		        pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$"
		        title="맨앞 글자는 영문자 뒤에는 영숫자 입력. 3~20 이내로 입력"
		        placeholder="아이디 입력"
			>
			<!-- id ajax 중복체크 -->
			<span class="id_ok">사용 가능한 아이디입니다.</span>
			<span class="id_already">누군가 이 아이디를 사용하고 있어요.</span>
          </div>
          
         <div class="form-group">
            <label for="pw">비밀번호</label>
            <input id="pw" name="pw" required type="password"
                class="form-control" maxlength="20"
                pattern="^.{4,20}$"
                title="4~20 이내로 입력"
                placeholder="비밀번호 입력"
            >
          </div>
          <div id="pwDiv" class="alert alert-danger">
              비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.
          </div>
          
         <div class="form-group">
            <label for="pw2">비밀번호 확인</label>
            <input id="pw2" required type="password"
                class="form-control" maxlength="20"
                pattern="^.{4,20}$"
                title="4~20 이내로 입력"
                placeholder="비밀번호 확인 입력"
            >
          </div>
          <div id="pw2Div" class="alert alert-danger">
              비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.
          </div>
          
         <div class="form-group">
            <label for="name">이름</label>
            <input id="name" name="name" required
                class="form-control" maxlength="10"
                pattern="^[가-힣]{2,10}$"
                title="한글로 2~10자 이내로 입력"
                placeholder="이름 입력"
            >
          </div>
          
         <div class="form-group">
            <label>성별</label>
            <div class="form-check-inline">
              <label class="form-check-label">
                <input type="radio" class="form-check-input" name="gender"
                 checked value="남자" > 남자
              </label>
            </div>
            <div class="form-check-inline">
              <label class="form-check-label">
                <input type="radio" class="form-check-input" name="gender"
                 value="여자" > 여자
              </label>
            </div>
          </div>
         
         <div class="form-group">
            <label for="birth">생년월일</label>
            <input id="birth" name="birth" required autocomplete="off"
                class="form-control datepicker" 
            >
          </div>
          
            <div style="margin-top: 20px;" class="form-group">
            <label for="tel">전화번호 입력 : </label>
            <input type="text" class="txtPhone" name="tel" id="tel" style="text-align:center;" maxlength="13"
            placeholder="000-0000-00000"  onkeyup = "checkTel()"
            pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" required/>
             <!-- tel ajax 중복체크 -->
			<span class="tel_ok">사용 가능한 전화번호 입니다.</span>
			<span class="tel_already">누군가 이 전화번호를 사용하고 있어요.</span>
            </div>
            
         <div class="form-group">
            <label for="email">이메일</label>
            <input id="email" name="email" required 
                class="form-control"  oninput = "checkEmail()"
                placeholder="id@도메인">
            <!-- email ajax 중복체크 -->
			<span class="email_ok">사용 가능한 이메일입니다.</span>
			<span class="email_already">누군가 이 이메일을 사용하고 있어요.</span>
          </div>
         <div class="form-group">
            <label for="photoFile">사진 이미지</label>
            <input id="photoFile" name="photoFile" 
                class="form-control" type="file"
            >
          </div>
          
        <button id="submitBtn" class="btn btn-outline-dark" disabled="disabled">가입</button>
        <button class="btn btn-outline-dark" type="reset">다시입력</button>
        <button class="btn btn-outline-dark" type="button" onclick="history.back();">취소</button>
        
    </form>
</div>
</body>
</html>