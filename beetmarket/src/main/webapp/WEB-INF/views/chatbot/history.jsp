<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅내역</title>

<script>
$(function(){
	
	function loadhistory(){
		$(".chathistory").load("/chatajax/history.do?roomno="+${param.roomno}+"&partner=${param.partner}");
	}
	
	loadhistory();
	setInterval(loadhistory, 5000);
	
	function sendchat(){
		let roomno=$("#roomno").val();
		let sender=$("#sender").val();
		let partner=$("#accepter").val();
		let contentval=$("#contentval").val();
		alert(contentval);
		$.post("/chatajax/chating.do?roomno="+roomno+"&sender="+sender+"&partner="+partner+"&content="+contentval, function(){
			$(".chathistory").load("/chatajax/history.do?roomno="+${param.roomno}+"&partner="+partner);
			$("#contentval").val("");
		});
	}
	
	$("#submitbtn").click(function(){
		sendchat();
	});
	
	$("#contentval").keyup(function(key) {
		if(key.keyCode == 13) {
			sendchat();
		}
	});
	
	$("#historyajax").on("click", ".dltbtn", function(){
		let chatno=$(this).data("chatno");
		let roomno=$("#roomno").val();
		$(".chathistory").load("/chatajax/delete.do?chatno="+chatno+"&roomno="+roomno);
	});
});
</script>
<style>
.message-box {
	width:50%;
    margin-bottom: 10px;
    border-radius: 5px;
}

.text-right {
    background: #3e83fa; /* 예: 오른쪽 메시지 배경색 */
    text-align: right;
    color:#fcfbf7;
}

.text-left {
    background: #eeeeee; /* 예: 왼쪽 메시지 배경색 */
    text-align: left;
    
}
</style>
</head>

<body>
<div class="container">
	<div id="historyajax">
		<div class="card">
		    <div class="card-header">
		    	<h3>${param.partner }</h3>
		    </div>
		    <div class="card-body">
		    	<div class="chathistory">
		    	
		    	</div>
		    </div>
	    </div>
	</div>
	<input type="hidden" id="roomno" name="roomno" value="${param.roomno }">
	<input type="hidden" id="sender" name="sender" value="${id }">
	<input type="hidden" id="accepter" name="accepter" value="${param.partner }">
		<div class="input-group mb-3">
		    <input class="form-control" id="contentval" placeholder="채팅을 입력하세요">
		    <div class="input-group-append">
		      <button id="submitbtn" class="btn btn-outline-secondary input-group-text"><i class="material-icons">send</i></button>
		    </div>
	  	</div>
</div>
</body>
</html>