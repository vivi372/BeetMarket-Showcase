<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 참여 리스트</title>
</head>
<body>
 <div class="container">
  <!-- 참여자 리스트 테이블 출력 -->
        <h3>참여자 리스트</h3>
        <table>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>참여자 ID</th>
                    <th>전화번호</th>
                    <th>주소</th>
                </tr>
            </thead>
            <tbody>
                <!-- 참여자 리스트 반복 출력 -->
                <c:forEach var="subscriber" items="${subscriberList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td> <!-- 참여자 순번 -->
                        <td>${subscriber.id}</td>    <!-- 참여자 ID -->
                        <td>${subscriber.tel}</td> <!-- 전화번호 -->
                        <td>${subscriber.address}</td> <!-- 주소 -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    <a href="list.do" class="btn btn-success">리스트</a>
 </div>
</body>
</html>