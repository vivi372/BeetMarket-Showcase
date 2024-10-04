<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach items="${histroylist}" var="vo">
		<c:if test="${vo.sender == id}">
			<div class="row">
				<div class="col-5"></div>
				<div class="message-box pt-2 pr-3 border text-right col-7"
					style="float: right;">
					<div>
						<c:if test="${empty vo.acceptdate }">
							<p class="float-left dltbtn font-weight-bold"
								data-chatno="${vo.chatno }" style="color: red">X</p>
						</c:if>
						<small>${vo.sender}</small>
						<p>${vo.content}</p>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${vo.sender != id}">
			<div class="row">
				<div class="message-box pt-2 pl-3 border text-left col-7">
					<small>${vo.sender}</small>
					<p>${vo.content}</p>
				</div>
				<div class="col-5"></div>
			</div>
		</c:if>
</c:forEach>