<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty roomlist }">
			<c:forEach items="${roomlist }" var="vo">
				<div class="roomrow border p-3" data-roomno="${vo.roomno }">
					<p>
					<!-- c.chatno, c.roomno, c.content, c.sender, user_id -->
					<span class="partner">${vo.partner }</span>
					<c:if test="${empty vo.acceptdate && !empty vo.content && vo.sender!=id }"><i class="fa fa-circle" style="font-size:10px;color:red"></i></c:if>
					<small class="float-right dltbtn">삭제하기</small>
					</p>
					<p>${vo.content }</p>
				</div>
			</c:forEach>
			</c:if>
			<c:if test="${empty roomlist }">
				<h4>현재 채팅 중인 상대가 없습니다.</h4>
			</c:if>