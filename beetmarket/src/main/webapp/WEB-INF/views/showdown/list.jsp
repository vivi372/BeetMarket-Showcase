<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 발표 리스트</title>
<style type="text/css">
.dataRow >.card-header{
	background: #e0e0e0
}
.dataRow:hover{
	opacity: 70%;
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function() {
	$(".dataRow").click(function() {
// 	alert("클릭");
	let no = $(this).data("no");
	location = "view.do?no=" + no + "&${pageObject.pageQuery}";
	});
});
</script>
</head>
<body>
	<div class="container">	
		<div class="card">
			<div class="card-header">이벤트 발표 리스트</div>
			<div class="card-body">
				<c:forEach items="${list }" var="vo">
					<div class="card dataRow" data-no="${vo.no }">
						<div class="card-header">
							<span class="${vo.no }">번호 ${vo.no }</span>
							<span class="float-right">작성일: 
							<fmt:formatDate value="${vo.writeDate }" pattern="yyyy-MM-dd"/>
							</span>
						</div>
						<div class="card-body">
							<pre>제목: ${vo.title }</pre>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<a href="writeForm.do" class="btn btn-primary">등록</a>
	</div>
</body>
</html>