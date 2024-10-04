<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>리뷰 답변 리스트</title>
</head>
<body>
    <h2>리뷰 답변 리스트</h2>
    <table border="1">
        <tr>
            <th>답변 번호</th>
            <th>리뷰 번호</th>
            <th>작성자 ID</th>
            <th>내용</th>
            <th>작성일</th>
        </tr>
        <c:forEach var="reply" items="${replyList}">
            <tr>
                <td>${reply.reviewReplyNO}</td>
                <td>${reply.reviewNo}</td>
                <td>${reply.id}</td>
                <td>${reply.content}</td>
                <td>${reply.writeDate}</td>
            </tr>
        </c:forEach>
    </table>

    <!-- 답변 작성 폼 -->
    <h3>답변 작성</h3>
    <form action="writeReply.do" method="post">
        <input type="hidden" name="reviewNo" value="${param.reviewNo}">
        <textarea name="content" rows="4" cols="50"></textarea>
        <br>
        <input type="submit" value="답변 등록">
    </form>
</body>
</html>
