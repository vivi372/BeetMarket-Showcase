<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Review Like</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<!-- 필요한 경우 reviewNo와 id 값을 설정합니다. -->
<c:set var="reviewNo" value="${param.reviewNo}"/>
<c:set var="id" value="${param.id}"/>

<h2>리뷰 좋아요 관리</h2>

<!-- 리뷰 좋아요 목록(list) -->
<!-- 해당 리뷰에 좋아요를 누른 유저 목록과 좋아요 개수를 표시합니다. -->
<div id="likeList">
    <h3>좋아요 목록</h3>
    <p>좋아요 개수: <span id="likeCount">${likeCount}</span></p>
    <ul>
        <c:forEach var="like" items="${likeList}">
            <li>${like.id}</li>
        </c:forEach>
    </ul>
</div>

<hr/>

<!-- 좋아요 추가(write) -->
<!-- 사용자가 좋아요를 추가할 수 있는 폼입니다. -->
<div id="addLike">
    <h3>좋아요 추가</h3>
    <form id="likeForm" action="${pageContext.request.contextPath}/reviewlike/write" method="post">
        <input type="hidden" name="reviewNo" value="${reviewNo}"/>
        <input type="hidden" name="id" value="${id}"/> <!-- ${vo.id} 대신 ${id}로 수정 -->
        <button type="submit">좋아요 추가</button>
    </form>
</div>

<hr/>

<!-- 좋아요 삭제(delete) -->
<!-- 사용자가 좋아요를 삭제할 수 있는 폼입니다. -->
<div id="removeLike">
    <h3>좋아요 삭제</h3>
    <form id="dislikeForm" action="${pageContext.request.contextPath}/reviewlike/delete" method="post">
        <input type="hidden" name="reviewNo" value="${reviewNo}"/>
        <input type="hidden" name="id" value="${id}"/> <!-- ${vo.id} 대신 ${id}로 수정 -->
        <button type="submit">좋아요 삭제</button>
    </form>
</div>

<!-- jQuery를 사용하여 AJAX로 좋아요 추가/삭제 처리 -->
<script>
    $(document).ready(function() {
        // 좋아요 추가 버튼 클릭 이벤트
        $("#likeForm").on("submit", function(event) {
            event.preventDefault();

            // reviewNo와 id 값을 확인
            var reviewNo = $('input[name="reviewNo"]').val();
            var id = $('input[name="id"]').val();

            $.ajax({
                type: "POST",
                url: "/reviewlike/write",
                data: {
                    reviewNo: reviewNo, // reviewNo 값 전달
                    id: id // 'id' 값 전달
                },
                success: function(response) {
                    alert("좋아요가 추가되었습니다.");
                },
                error: function() {
                    alert("좋아요 추가에 실패했습니다.");
                }
            });
        });

        // 좋아요 삭제 버튼 클릭 이벤트
        $("#dislikeForm").on("submit", function(event) {
            event.preventDefault();

            var reviewNo = $('input[name="reviewNo"]').val();
            var id = $('input[name="id"]').val();

            $.ajax({
                type: "POST",
                url: $(this).attr("action"),
                data: {
                    reviewNo: reviewNo,
                    id: id
                },
                success: function(response) {
                    // 성공 시 좋아요 개수 갱신
                    $("#likeCount").text(response.likeCount);
                    alert("좋아요가 삭제되었습니다.");
                },
                error: function() {
                    alert("좋아요 삭제에 실패했습니다.");
                }
            });
        });
    });
</script>

</body>
</html>
