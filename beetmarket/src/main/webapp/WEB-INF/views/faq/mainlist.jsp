<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FAQ Main</title>
<script>
$(function(){
	$(".faqlist").load("/faqajax/list.do?cateno=1&ismain=1");
	
	$(".btn-circle").click(function(){
		let cateno=$(this).data("cateno");
		$(".faqlist").load("/faqajax/list.do?cateno="+cateno+"&ismain=1");
	});
	
	$(".faqlist").on("click", ".viewallbtn", function(){
		let cateno=$(this).data("cateno");
		location="faqlist.do?cateno="+cateno+"&ismain=0";
	});
	
	$(".faqlist").on("click", ".datarow", function(){
		let faqno=$(this).data("faqno");
		location="view.do?faqno="+faqno+"&hit=1";
	});
	
	$("#key").val("${(empty searchvo.searchkey)?'qa':searchvo.searchkey }");
	$("#word").val("${(empty searchvo.searchword)?'':searchvo.searchword }");
	
});
</script>
<style>
.faqlist{
	background-color:#4e73df;
}
.mr-4{
cursor:pointer
}
.answerline{
   text-overflow: ellipsis;
   overflow: hidden;
   word-break: break-word;
    
   display: -webkit-box;
   -webkit-line-clamp: 3;
   -webkit-box-orient: vertical
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
			id="word" name="searchword" value="${searchvo.word }">
			<div class="input-group-append">
				<button class="btn btn-outline-primary">
			      	<i class="fa fa-search"></i>
		   		</button>
		  	</div>
	</div>
  </form>
  
  <div class="card">
  	<div class="card-body mx-auto">
		<button class="btn btn-lg btn-outline-primary btn-circle mr-4" data-cateno="1">
			<i class="fa fa-user" style="font-size:36px"></i>
		</button>
		<button class="btn btn-lg btn-outline-primary btn-circle mr-4 ml-3" data-cateno="2">
			<i class="material-icons" style="font-size:36px">local_shipping</i>
		</button>
		<button class="btn btn-lg btn-outline-primary btn-circle mr-4 ml-3" data-cateno="3">
			<i class="fa fa-credit-card" style="font-size:36px"></i>
		</button>
		<button class="btn btn-lg btn-outline-primary btn-circle mr-4 ml-3" data-cateno="4">
			<i class="fa fa-refresh" style="font-size:36px"></i>
		</button>
		<button class="btn btn-lg btn-outline-primary btn-circle ml-3" data-cateno="5">
			<i class="fa fa-lock" style="font-size:36px"></i>
		</button>
    </div>
    <div class="faqlist">
    </div>
  </div>
  <div>
  	<c:if test="${login.gradeNo==9 }">
  		<a href="writeform.do" type="button" class="btn btn-lg float-right btn-primary">등록</a>
  	</c:if>
  </div>
</div>
</body>
</html>