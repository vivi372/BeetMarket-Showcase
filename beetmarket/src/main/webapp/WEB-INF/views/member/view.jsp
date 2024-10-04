<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>{vo.name}님 정보 보기</title>
<style type="text/css">
.btn{
	style="background-color: #87CEFA; 
	color: #FFFFFF; 
	border: 1px solid #87CEFA; 
	padding: 10px 20px; 
	border-radius: 5px; 
	font-size: 16px;"
}
.data{
	font-size: 20px; 
	margin-left: 50px; 
	margin-bottom: 10px;
}
.blue-button {
    background-color: #87CEEB; /* 파란색 */
    color: white; /* 텍스트 색상: 흰색 */
    padding: 10px 20px;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    position: absolute; 
    top: 10px; 
    left: 10px;
}

/* 마우스를 올렸을 때 */
.blue-button:hover {
    background-color: #0056b3; /* 조금 더 어두운 파란색 */
}
</style>

<script>
  function goBack() {
    window.history.back();
  }
</script>
</head>
<body>
<div class="container">
	<div class="card">
		<div class="card-header" style="display: flex; align-items: center; justify-content: center;">
		<button class="blue-button" onclick="goBack()" ><i class="fa fa-angle-double-left"></i></button>
		  <img src="${vo.photo}" style="width: 150px; height: 150px; margin-right: 20px;">
			  <div style="font-size: 25px;">
			    ID : ${vo.id} (${vo.name})
			  </div>
		</div>
		<div class="card-body">
			<div class="data">
				TEL : ${vo.tel } &nbsp;|&nbsp; EMAIL : <span>${vo.email }</span>
			</div>
			<div class="data">
				BIRTH : ${vo.birth} &nbsp;|&nbsp; 가입일 : <fmt:formatDate value="${vo.regDate }" pattern="yyyy-MM-dd"/>
			</div>
			<div class="data">
				Grade 등급 : ${vo.gradeName } &nbsp;|&nbsp; MemberSip 등급 : ${vo.shipName } 
				<img src="/upload/member/ship/${vo.shipName }.png" style="width: 30px; height: 30px;">
			</div>
		</div>
		<div class="card-footer">
			<div class="data float-right">
				최근 접속일 : <fmt:formatDate value="${vo.conDate }" pattern="yyyy-MM-dd"/>
			</div>
		</div>
	</div>
</div>
</body>
</html>