<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추첨 결과</title>
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
                </tr>
            </thead>
            <tbody>
                <!-- 참여자 리스트 반복 출력 -->
                <c:forEach var="participant" items="${participantList}" varStatus="status">
                    <tr>
                        <td>${status.index + 1}</td> <!-- 참여자 순번 -->
                        <td>${participant}</td>        <!-- 참여자 ID -->
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>