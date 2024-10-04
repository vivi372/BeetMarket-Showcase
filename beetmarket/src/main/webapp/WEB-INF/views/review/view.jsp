<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>

<!-- Font Awesome for star icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style type="text/css">
.dataRow>.card-header {
	background: #e0e0e0;
}
.dataRow:hover {
	border-color: orange;
	cursor: pointer;
}
.imageDiv {
    width: 100%;
    text-align: center;
    overflow: hidden;
}

.imageDiv img {
    width: 80%;
    height: 200px;
    object-fit: cover;
}

.starscore {
    color: gold;
    font-size: 20px;
}

.star-rating {
    display: inline-block;
    font-size: 0; /* to remove spacing between stars */
    direction: ltr; /* 왼쪽에서 오른쪽으로 방향 지정 */
}

.star-rating .fa-star {
    font-size: 24px; /* set star size */
    color: lightgray; /* default star color (empty stars) */
    float: left; /* 왼쪽에서부터 채워지도록 float 사용 */
}

.star-rating .fa-star.checked {
    color: gold; /* color for filled stars */
}

.star-rating {
    display: inline-block;
    font-size: 0;
}

.star-rating .fa-star {
    font-size: 24px;
    color: lightgray;
    position: relative;
    display: inline-block;
}

.star-rating .fa-star.checked {
    color: yellow; /* 완전히 채워진 별 */
}

.star-rating .fa-star.partially-filled {
    background: linear-gradient(90deg, yellow var(--percent), lightgray var(--percent));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
</style>



<script type="text/javascript">
$(function() {



	
	
	// 리뷰 수정 모달창
	$(function() {
	    // 리뷰 수정 모달창
	    $(".btn-primary#reviewUpdateBtn").click(function() {
	        $("#reviewupdateModal").modal("show");
	    });
	});


	
	// 리뷰 삭제 처리
	$(".deleteBtn").click(function() {
		let reviewNo = $(this).data("reviewno");
		if (confirm("리뷰를 삭제하시겠습니까?")) {
			$.ajax({
				type: "POST",
				url: "delete.do",
				data: { reviewNo: reviewNo },
				success: function(result) {
					alert("리뷰가 삭제되었습니다.");
					location.reload(); // 삭제 후 페이지를 새로고침
				},
				error: function() {
					alert("리뷰 삭제 중 오류가 발생했습니다.");
				}
			});
		}
	});

	
	
	
	// perPageNum 처리
	$("#perPageNum").change(function() {
		$("#searchForm").submit();
	});


});



//좋아요 토글 함수 수정
function toggleLike(reviewNo, userId) {
    $.ajax({
        type: 'POST',
        url: '/reviewlike/toggle',  // 수정된 토글 메서드 사용
        contentType: 'application/json',
        dataType: 'json',  // 응답을 JSON으로 받도록 설정
        data: JSON.stringify({ reviewNo: reviewNo, id: userId }),
        success: function(response) {
        location.reload(); // 새로고침하여 좋아요 개수 갱신
        	
            // 서버로부터 변경된 좋아요 개수를 반환받음
            let likeCount = response;

            // 좋아요 개수 업데이트
            $('#likeCount-' + reviewNo).text(likeCount);

            // 버튼 스타일 변경
            let likeButton = $('.like-button[data-reviewno="' + reviewNo + '"]');
            if (likeButton.hasClass('liked')) {
                likeButton.removeClass('liked');
                likeButton.text('좋아요');
            } else {
                likeButton.addClass('liked');
                likeButton.text('좋아요 취소');
            }
        },
        error: function(error) {
            console.log(error);
            alert("좋아요 처리 중 오류가 발생했습니다.");
        }
    });
}



//좋아요 버튼 클릭 이벤트 수정
$(document).on('click', '.like-button', function() {
    var reviewNo = $(this).data('reviewno');
    var userId = '${login.id}';
    console.log("좋아요 토글: 리뷰번호 = " + reviewNo + ", 사용자ID = " + userId);
    toggleLike(reviewNo, userId);
});

</script>
</head>



<div class="container">
            <h2>작성가능한 리뷰</h2>

</html>