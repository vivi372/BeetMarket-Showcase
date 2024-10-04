<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<div class="row">
	<div class="message-box pt-2 pl-3 border text-left col-7">
		<p>카테고리를 선택하시오.</p>
		<div class="btn-group">
			<button class="btn btn-primary catebtn orderbtn">주문정보 변경</button>
		</div>
		<div class="btn-group">
			<button class="btn btn-primary catebtn refundbtn">취소/반품</button>
		</div>
		<div class="btn-group">
			<button class="btn btn-primary catebtn eventbtn">이벤트</button>
		</div>
		<div class="btn-group">
			<button class="btn btn-primary catebtn chatingbtn">상담원 연결</button>
		</div>
	</div>
	<div class="col-5"></div>
</div>