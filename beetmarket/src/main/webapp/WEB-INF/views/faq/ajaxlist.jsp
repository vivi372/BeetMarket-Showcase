<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty list }">
	<br>
	<h4 class="ml-4" style="color:white">" ${list[0].catename } "에서 자주 묻는 질문입니다.</h4>
	<small class="float-right viewallbtn mr-4" style="color:white" data-cateno="${cateno }">전체보기</small>
	<br>
	<div class="row">
		<c:forEach items="${list }" var="vo">
			<div class="col-lg-3 mx-auto p-3 m-2" style="background:white;">
				<p style="color:#4e73df;font-size:20px" class="card-text datarow font-weight-bold" data-faqno="${vo.faqno }">Q. ${vo.question }</p>
				<p class="answerline">A. ${vo.answerline }</p>
			</div>
		</c:forEach>
	</div>
	<br>
</c:if>
<c:if test="${empty list }">
	<div class="mx-auto p-3 m-4" style="background:white">
		<p>등록된 FAQ가 존재하지 않습니다.</p>
	</div>
</c:if>