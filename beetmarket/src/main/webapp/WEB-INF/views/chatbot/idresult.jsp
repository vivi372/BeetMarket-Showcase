<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
	<div>
		<input type="hidden" id="isexist" value="${isexist }">
		<input type="hidden" id="accepter" value="${membervo.id }">
		<c:if test="${!empty membervo }">
			<p>[ ${membervo.id } ]님을 채팅으로 초대하시겠습니까?</p>
		</c:if>
		<c:if test="${empty membervo }">
			<p>일치하는 회원이 없습니다. 확인 후 다시 시도해주세요.</p>
		</c:if>
	</div>