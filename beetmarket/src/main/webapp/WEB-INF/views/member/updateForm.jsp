<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Form with Modal</title>
<script type="text/javascript">
$(function(){
	// 이벤트 처리
	$(".statusTal").click(function(){
		location="changeStatus.do?id=${vo.id}"+"&status=탈퇴&admin=1";
	});
});
</script>
</head>
<body>
  <div class="container mt-5">
    <div class="card" style="width: 600px; margin: 0 auto;">
      <form action="update.do">
        <img src="${vo.photo }" alt="Card image" class="card-img-top" style="width: 100px; height: 100px;"> 아이디 : ${vo.id }
        <div class="card-body">
          <h4 class="card-title">이름 : <input name="name" value="${vo.name }" class="form-control"></h4>
          <h6>
           <br> 성별 : <input name="gender" value="${vo.gender }" class="form-control" readonly="readonly" style="width: 100px;"><br>
          </h6>
          <p class="card-text">
            생년월일 : <input type="date" name="birth" value="${vo.birth }" class="form-control"><br>
            <div class="form-group mt-3">
              <label for="tel">전화번호 입력 : </label>
              <input type="text" class="form-control" name="tel" id="tel" maxlength="13"
                     placeholder="000-0000-00000" value="${vo.tel }"
                     pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}" required>
            </div>
            <br> 회원 등급 : ${vo.gradeName }<br>
            가입일 : <fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/><br>
            이메일 : <input name="email" value="${vo.email }" class="form-control"><br>
            회원 상태 : ${vo.status }
          </p>
      		<input type="password" name="pw">
          <button  class="btn btn-dark">수정완료</button>
          <button type="button" class="btn btn-danger statusTal" >탈퇴</button>
        </div>
      </form>
    </div>
   </div> 


</html>

