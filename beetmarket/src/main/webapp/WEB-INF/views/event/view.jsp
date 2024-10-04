<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글보기</title>
<style>
img.responsive {
    max-width: 50%;  /* 부모 요소의 너비에 대해 최대 50%로 조정 */
    height: auto;    /* 비율을 유지하며 높이 자동 조정 */
    max-height: 300px; /* 최대 높이 설정 (필요에 따라 변경 가능) */
    object-fit: cover; /* 이미지가 잘리지 않도록 비율을 유지하며 화면에 맞춤 */
}
</style>
<script type="text/javascript">
$(function() {	
	// 페이지 로딩 시 날짜 표시 (필요한 경우 사용)
	console.log('현재 날짜: ' + dateStr);
	
	$("#updateBtn").click(function(){
		location = "updateForm.do?no=${vo.no}";
	});
	// 글삭제 버튼
	$("#deleteBtn").click(function(){
		$("#pw").val("");
	});
	// 리스트 버튼
	$("#listBtn").click(function(){
		location = "list.do?page=${param.page}&perPageNum=${param.perPageNum}"
				+ "&key=${param.key}&word${param.word}";
	});
	// 이미지 사이즈 조정 5:4
	let imgWidth = $(".imageDiv:first").width();
	let height = imgWidth * 0.8;  // 5:4 비율로 계산
	$(".imageDiv").height(height);

	$(".imageDiv > img").each(function(idx, image) {
		// 이미지가 계산된 높이보다 크면 줄인다.
		if ($(image).height() > height) {
			let image_width = $(image).width();
			let image_height = $(image).height();
			let width = height / image_height * image_width;

			// 이미지 높이 줄이기
			$(image).height(height);
			// 이미지 너비 줄이기
			$(image).width(width);
		}
	});
});
</script>
</head>
<body>
<div class="container">
   <div class="card-body">
    <div class="card" data-no="${vo.no}" >
     <div class="card-header">
        <span class="float-left">    작성일:
            <fmt:formatDate pattern="yyyy-MM-dd" value="${vo.writeDate}"/><!-- 작성일을 yyyy-MM-dd 형식으로 표시 -->
        </span>
        <span class="float-right">  ~종료일:
            <fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd" /><!-- 시작일을 yyyy-MM-dd 형식으로 표시 -->
        </span>
         <span class="float-right">  시작일:
            <fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd" /><!-- 종료일을 yyyy-MM-dd 형식으로 표시 -->
        </span>
      <div style="clear: both;"><!-- float 요소 정리 -->
      ${vo.no }. ${vo.title }
      </div>
     </div>
    <div class="card-body">
    <!-- 이미지 태그에 'responsive' 클래스를 추가 -->
    <a href="ApplyForm.do?event_no=${param.no }" class="btn btn-primary float-right">신청</a>
    <a href="subscriberList.do?event_no=${vo.no }" class="btn btn-primary float-right">신청자 목록</a>
      <button type="button" class="btn btn-primary float-right" data-toggle="modal" data-target="#myModal">
    ID 추첨하기
  	</button>
    
    <img src="${vo.image }" class="responsive">
    <pre>${vo.content }</pre>
	</div>
    <div class="card-footer">
    <c:if test="${!empty login && login.gradeNo == 5  }">
		<a href="updateForm.do?no=${vo.no }" class="btn btn-primary">수정</a>
		<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">삭제</button>
	</c:if>
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
 
 <!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">당첨자 수 입력</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <form action="drowWinner.do">
        <input type="hidden" value="${param.no }" name="event_no"> 
        <!-- Modal body -->
        <div class="modal-body">
         <input type="number" class="form-control" name="numWinners"> 
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
        <button type="submit" class="btn btn-warning float-right" >추첨하기</button>
         <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
        </form>
      </div>
    </div>
  </div>
 
</body>
</html>