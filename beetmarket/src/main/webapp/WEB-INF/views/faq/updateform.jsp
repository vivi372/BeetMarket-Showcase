<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ writeform</title>
<script>
$(function(){
	$("#cateno").val()
	
	$("#catelist").change(function(){
		let cateno=$(this).val();
		$("#cateno").val(cateno);
	});
});
</script>
</head>

<body>
<div class="container">
	<div class="card">
		<div class="card-body">
		<form action="update.do" method="post">
		  <input type="hidden" name="faqno" value="${vo.faqno }">
		  <input type="hidden" name="cateno" id="cateno" value="${vo.cateno }">
			<!-- 카테고리 선택 시작 -->
			<select id="catelist" class="custom-select">
				<option value="0">카테고리 선택</option>
				<c:if test="${!empty catelist }">
					<c:forEach items="${catelist }" var="catevo">
						<option value="${catevo.cateno }" ${(vo.cateno==catevo.cateno)?'selected':'' }>${catevo.catename }</option>
					</c:forEach>
				</c:if>
			</select>
			<!-- 카테고리 선택 끝 -->
			<div class="form-group pt-3">
				<label for="question">질문:</label>
				<textarea class="form-control" rows="5" name="question" id="question">${vo.question }</textarea>
			</div>
			<div class="form-group">
				<label for="answerline">답변 요약:</label>
				<input class="form-control" name="answerline" id="answerline" value="${vo.answerline }">
			</div>
			<div class="form-group">
				<label for="answer">답변:</label>
				<textarea class="form-control" rows="5" name="answer" id="answer">${vo.answer }</textarea>
			</div>
			<div class="float-right">
				<button class="btn btn-primary">적용</button>
				<button class="btn btn-secondary" type="button" onclick="history.back()">이전</button>
				<button class="btn btn-danger" type="reset">초기화</button>
			</div>
		</form>
		
			
		</div>
	</div>
</div>
</body>
</html>