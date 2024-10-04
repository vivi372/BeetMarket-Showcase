<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅목록</title>
<script>
$(function(){
	
	function loadroomlist(){
		$("#roomlist").load("/chatajax/roomlist.do");
	}
	
	loadroomlist();
	setInterval(loadroomlist, 5000);
	
	$("#roomlist").on("click", ".roomrow", function(){
		let roomno=$(this).data("roomno");
		let partner=$(this).find(".partner").text();
		location="history.do?roomno="+roomno+"&partner="+partner;
	});
	
// 	$("#addroom").click(function(){
// 		//모달을 새로 열 때마다 초기 화면이 떠야 함
// 	});
	
	$("#searchbtn").click(function(){
		let idinfo=$("#idinfo").val();
		//검색한 상대의 존재여부 판단
		$(".modal-body").load("/chatajax/searchid.do?idinfo="+idinfo, function(response){
			let isexist=$(response).find("#isexist").val();
			// 중복 등록 방지
	        $("#addroombtn").off("click"); // 기존 이벤트 핸들러 제거
			
			if(isexist=="true") {
				let accepter=$(response).find("#accepter").val();
				$("#addroombtn").prop("disabled", false);
				$("#addroombtn").click(function(){
					location="addroom.do?partner="+accepter;
				});
			}
		});
	});
	
	$("#roomlist").on("click", ".dltbtn", function(){
		let roomno=$(this).closest(".roomrow").data("roomno");
		location="roomdelete.do?roomno="+roomno;
		return false;
	});
});
</script>
</head>

<body>
<div class="container">
	<div class="card">
		<div class="card-header"><h3>채팅목록</h3></div>
		<div class="card-body">
			<div id="roomlist">
			<c:if test="${!empty roomlist }">
			<c:forEach items="${roomlist }" var="vo">
				<div class="roomrow border p-3" data-roomno="${vo.roomno }">
					<p>
					<!-- c.chatno, c.roomno, c.content, c.sender, user_id -->
					<span class="partner">${vo.partner }</span>
					<c:if test="${empty vo.acceptdate && !empty vo.content && vo.sender!=id }"><i class="fa fa-circle" style="font-size:10px;color:red"></i></c:if>
					<small class="float-right dltbtn">삭제하기</small>
					</p>
					<p>${vo.content }</p>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty roomlist }">
				<h4>현재 채팅 중인 상대가 없습니다.</h4>
			</c:if>
			</div>
			<br/>
			<i class="material-icons float-right" id="addroom" data-toggle="modal" data-target="#myModal" style="font-size:36px;color:#3e83fa">add_circle_outline</i>
		</div>
	</div>
</div>

<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">채팅 초대하기</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
        	<div class="input-group mb-3">
			    <input class="form-control" id="idinfo" placeholder="아이디를 입력하시오">
			    <div class="input-group-append">
			    	<button class="btn btn-outline-primary" id="searchbtn">검색</button>  
			    </div>
			</div>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" id="addroombtn" disabled class="btn btn-primary">채팅하기</button>
        </div>
        
      </div>
    </div>
  </div>

</body>
</html>