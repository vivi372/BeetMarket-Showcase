<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${param.mode == 'l' }">
	<option value="0">분류 선택</option>
</c:if>
<c:forEach items="${midList }" var="vo">
	<option value="${vo.cateMidNo }">${vo.categoryName }</option>
</c:forEach>
