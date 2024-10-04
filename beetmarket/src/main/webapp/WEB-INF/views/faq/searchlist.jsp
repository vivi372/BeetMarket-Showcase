<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Search List</title>
<script>
$(function(){
	$(".card-body").on("click", ".datarow", function(){
		let faqno=$(this).data("faqno");
		location="view.do?faqno="+faqno+"&hit=1";
	});
	
	$("#key").val("${(empty searchvo.searchkey)?'qa':searchvo.searchkey }");
	$("#word").val("${(empty searchvo.searchword)?'':searchvo.searchword }");
});
</script>
<style>
#faqtoplist{
	background-color:#4e73df;
}
.mr-4{
cursor:pointer
}
</style>

</head>

<body>
<div class="container">
  <form action="searchlist.do" id="searchForm">
  	<input name="page" value="1" type="hidden">
	  <div class="input-group p-3">
			<div class="input-group-prepend">
		      <select name="searchkey" id="key" class="form-control">
		      	<option value="qa">질문/답변</option>
		      	<option value="q">질문</option>
		      	<option value="a">답변</option>
		      </select>
			</div>
			<input class="form-control" placeholder="검색"
			id="word" name="searchword" value="${searchvo.searchword }">
			<div class="input-group-append">
				<button class="btn btn-outline-primary">
			      	<i class="fa fa-search"></i>
		   		</button>
		  	</div>
	</div>
  </form>
  
  <div class="card">
  	<div class="card-body">
		<c:forEach items="${list }" var="vo">
			<div class="p-3 border">
				<p class="card-text datarow" data-faqno="${vo.faqno }">Q. ${vo.question }</p>
			</div>
		</c:forEach>
		<div>
		  	<c:if test="${login.gradeNo==9 }">
		  		<a href="writeform.do?cateno=${list[0].cateno }" type="button" class="btn float-right btn-outline-primary">등록</a>
		  	</c:if>
		  	<a href="list.do" type="button" class="btn float-right btn-outline-primary">메인</a>
	  	</div>
    </div>
  </div>
</div>
</body>
</html>