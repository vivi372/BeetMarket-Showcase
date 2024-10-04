<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글보기</title>
<script type="text/javascript">
$(function() {
	// JavaScript에서 현재 날짜를 yyyy-MM-dd 형식으로 출력
	const date = new Date();
	const year = date.getFullYear();
	const month = ('0' + (date.getMonth() + 1)).slice(-2);
	const day = ('0' + date.getDate()).slice(-2);
	const dateStr = `${year}-${month}-${day}`;
	
	// 페이지 로딩 시 날짜 표시 (필요한 경우 사용)
	console.log('현재 날짜: ' + dateStr);
	
	// 글삭제 버튼
	$("#deleteBtn").click(function(){
		$("#pw").val("");
	});
});
</script>
</head>
<body>
<div class="container">
   <div class="card-body">
    <div class="card" data-no="${vo.no}" >
     <div class="card-header">
        <span class="float-left">작성일: 
            <fmt:formatDate pattern="yyyy-MM-dd" value="${vo.writeDate}"/><!-- 작성일을 yyyy-MM-dd 형식으로 표시 -->
        </span>	
      <div style="clear: both;"></div> <!-- float 요소 정리 -->
      ${vo.no }. ${vo.title }
     </div>
    <div class="card-body">
     <pre>${vo.content }</pre>
    </div>
    <div class="card-footer">
		<a href="updateForm.do?no=${vo.no }" class="btn btn-primary">수정</a>
		<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
		<a href="list.do" class="btn btn-success">리스트</a>
	</div>
    </div>
      <!-- The Modal -->
  <div class="modal fade" id="deleteModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">비밀번호 입력 모달 창</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <form action="delete.do" method="post">
        	<input type="hidden" name="no" value="${vo.no }">
	        <!-- Modal body -->
	        <div class="modal-body">
	           <div class="form-group">
	            	<input class="form-control" name="pw" type="password" id="pw">
	           </div>
	        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button class="btn btn-danger">삭제</button>
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        </form>
      </div>
    </div>
  </div>
   </div>
 </div>
</body>
</html>