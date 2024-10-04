<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원리스트</title>
<style type="text/css">
.dataRow:hover{
	background: #e0e0e0;
	cursor: pointer;
}
.MemberListBtn{
	background-color: #4B89DC;
}
</style>
<script type="text/javascript">
$(function(){
	
	// 이벤트처리
	$(".dataRow").on("click", function(){
		let id2 = $(this).find(".id").text();
		console.log(id2);
		location = "view.do?id="+id2;

	});
	
	$(".grade, .status , .ship").parent()
	.on("mouseover", function(){
		// dataRow의 click 이벤트를 없앤다.
		$(".dataRow").off("click");
	})
	.on("mouseout", function(){
		// dataRow의 click 이벤트를 다시 설정해준다..
		$(".dataRow").on("click", function(){
			dataRowClick()
		});
	});
	
	$(".dataRow").on("change", ".grade, .status , .ship ", function(){
		// alert("값이 바뀜");
		// this - select 태그 선택 .next() 다음 태그 - div 태그
		// 변경되었는지 알아내는 것 처리.
		let changeData =  $(this).val();
		let data = $(this).data("data"); // data-data 속성으로 넣어 둔다.
		console.log("원래 데이터=" + data + ", 바꿀 데이터=" + changeData);
		if(changeData == data)
			$(this).next().find("button").prop("disabled", true);
		else
			$(this).next().find("button").prop("disabled", false);
	});

});
</script>
</head>
<body>
<div class="container">
	<h2>회원 리스트</h2>
	<table class="table">
		<thead>
			<tr align="center">
				<th>사진</th>
				<th>아이디</th>
				<th>이름</th>
				<th>성별</th>
				<th>연락처</th>
				<th>등급</th>
				<th>맴버쉽</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="vo">
				<tr class="dataRow">
					<td><img src="${vo.photo }" style="width: 30px; height: 30px;"></td>
					<td class="id">${vo.id }</td>
					<td>${vo.name }</td>
					<td>${vo.gender }</td>
					<td>${vo.tel }</td>
					<td>
						<form action="changeGrade.do">
							<input name="id" value="${vo.id }" type="hidden">
							<div class="input-group mb-3">
							  <select class="form-control grade" 
							   name="gradeNo" data-data="${vo.gradeNo }">
							  	<option value="1" ${(vo.gradeNo == 1)?"selected":"" }>일반회원</option>
							  	<option value="5" ${(vo.gradeNo == 5)?"selected":"" }>판매자</option>
							  	<option value="9" ${(vo.gradeNo == 9)?"selected":"" }>관리자</option>
							  </select>
							  <div class="input-group-append">
							    <button class="MemberListBtn" type="submit" disabled>변경</button>
							  </div>
							</div>
						</form>
					</td>
					
				<td>
						<form action="changeMemeberShip.do">
							<input name="id" value="${vo.id }" type="hidden">
							<div class="input-group mb-3">
							  <select class="form-control ship" 
							   name="shipNo" data-data="${vo.shipNo }">
							  	<option value="1" ${(vo.shipNo == 1)?"selected":"" }>Bronze</option>
							  	<option value="2" ${(vo.shipNo == 2)?"selected":"" }>Gold</option>
							  	<option value="3" ${(vo.shipNo == 3)?"selected":"" }>Diamond</option>
							  </select>
							  <div class="input-group-append">
							    <button class="MemberListBtn" type="submit" disabled>변경</button>
							  </div>
							</div>
						</form>
				</td>	
					
					<td>
						<form action="changeStatus.do">
							<input name="id" value="${vo.id }" type="hidden">
							<div class="input-group mb-3">
							  <select class="form-control status"
							   name="status" data-data="${vo.status }">
							  	<option ${(vo.status == "정상")?"selected":"" }>정상</option>
							  	<option ${(vo.status == "탈퇴")?"selected":"" }>탈퇴</option>
							  	<option ${(vo.status == "휴면")?"selected":"" }>휴면</option>
							  	<option ${(vo.status == "강퇴")?"selected":"" }>강퇴</option>
							  </select>
							  <div class="input-group-append">
							    <button class="MemberListBtn" type="submit" disabled>변경</button>
							  </div>
							</div>
						</form>
					</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>
</div>
</body>
</html>