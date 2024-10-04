<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
	
	
	
    //판매자에게만 리뷰답변 등록 수정 삭제 버튼 보이게 하는 소스
    let sellerId = $(".reviewList").data("sellid");	
    let id = "${login.id}";
    if(id != null && sellerId==id ){
        $(".reviewList").find(".replyreviewWriteBtn, .replyreviewUpdateBtn, .repltdeleteBtn").show();
       // console.log($(".reviewList").find(".replyreviewWriteBtn"));
    }else{
        $(".reviewList").find(".replyreviewWriteBtn, .replyreviewUpdateBtn, .repltdeleteBtn").hide();
       // console.log($(".reviewList").find(".replyreviewWriteBtn"));
	}
	
	
	if(${scroll != null}) {
		$('html, body').animate({ scrollTop: $(document).height()  }, 'smooth'); 		
	}
	
	

	
	
	     // 리뷰 수정 모달창
	     $(".reviewUpdateBtn").click(function() {
	         $("#reviewupdateModal").modal("show");
	     });
	
	
	
	    // 리뷰답변 수정 모달창
	    $(".replyreviewUpdateBtn").click(function() {
	        $("#replyreviewupdateModal").modal("show");
	    });
	
	    
	
		// 리뷰답변 등록 모달창
		$(".replyreviewWriteBtn").click(function() {
			let reviewNo = $(this).data("reviewno");
			$("#inputno").val(reviewNo);
			console.log("log");
			$("#replyModal").modal("show");
		});
		
		
		// 글삭제 버튼
		$(".repltdeleteBtn").click(function() {
		    var reviewReplyNo = $(this).data("reviewreplyno");
		    var goodsNo = $(this).data("goodsno");
		    if(confirm("답변 삭제할까요?"))
		   	location = `/review/replydelete.do?reviewReplyNo=\${reviewReplyNo}&goodsNo=\${goodsNo}`;
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
<h2>리뷰 ${totalReviewCount}</h2>
<div class="star-rating">
	<c:set var="integerPart"
		value="${fn:substringBefore(averageRating, '.')}" />
	<c:set var="decimalPart"
		value="${fn:substring(fn:substringAfter(averageRating, '.'), 0, 1)}" />

	<h4>
		사용자 총 평점:
		<fmt:formatNumber value="${averageRating}" type="number"
			maxFractionDigits="2" />/ 5
 	</h4>

	<c:forEach begin="1" end="5" varStatus="status">
		<c:choose>
			<c:when test="${status.index <= integerPart}">
				<!-- 완전히 채워진 별 -->
				<i class="fa fa-star checked"></i>
			</c:when>
			<c:when test="${status.index == integerPart + 1}">
				<!-- 소수점 값을 바탕으로 부분적으로 채워진 별 -->
				<i class="fa fa-star partially-filled"
					style="--percent: ${decimalPart * 10}%"></i>
			</c:when>
			<c:otherwise>
				<!-- 빈 별 -->
				<i class="fa fa-star"></i>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</div>



<div class="card-body">
	<c:forEach items="${list}" var="vo">
		<div class="card dataRow" data-reviewno="${vo.reviewNo}"
			data-goodsno="${vo.goodsNo}" data-starscore="${vo.starscore}"
			data-reviewcontent="${fn:escapeXml(vo.reviewContent)}"
			data-reviewimage="${vo.reviewImage}">

			<div class="card-header">작성자: ${vo.id}</div>
			

			<div class="card-body">
				<div class="star-rating">
					<c:forEach begin="1" end="5" varStatus="status">
						<i
							class="fa fa-star ${status.index <= vo.starscore ? 'checked' : ''}"></i>
					</c:forEach>
				</div>
				<pre>${vo.reviewContent}</pre>
				<div class="imageDiv text-center align-content-center">
					<img class="card-img-top"
						src="${pageContext.request.contextPath}${vo.reviewImage}"
						alt="image">
				</div>
			</div>

			<div class="card-footer">
				<span class="float-right"> <fmt:formatDate
						value="${vo.writeDate}" pattern="yyyy-MM-dd" />
				</span>

				<!-- 좋아요 버튼 및 좋아요 개수 표시 -->
				<c:if test="${ !empty login && login.gradeNo == 5}">
					<button type="button" class="btn btn-primary replyreviewWriteBtn" data-reviewno="${vo.reviewNo}">답변하기</button>
				</c:if>
				
				<!-- 좋아요버튼 -->
				<button class="btn btn-success like-button"
					data-reviewno="${vo.reviewNo}" ><i class="fa fa-heart"></i>
			     </button>
				
				<span id="likeCount-${vo.reviewNo}">${vo.likeCount}</span>



				<c:if test="${not empty vo.replyId}">
					<button type="button" class="btn btn-primary replyreviewUpdateBtn" data-reviewno="${vo.reviewNo}" 
					data-reviewReplyNo="${vo.reviewReplyNo}">답변수정하기</button>
					
					<button type="button" class="btn btn-danger repltdeleteBtn"
					    data-reviewreplyno="${vo.reviewReplyNo}" data-reviewno="${vo.reviewNo}"
					    data-goodsno="${vo.goodsNo}">삭제</button>
					<div class="reply-list">
						<div class="reply"
							style="border-top: 1px solid #ddd; padding-top: 10px; margin-top: 10px;">
							<div class="card-header">답변자: ${vo.replyId}</div>
							<div class="card-body">
								<pre class="replyContent">${vo.replyContent}</pre>
							</div>
							<div class="card-footer">
								<span class="float-right"> <fmt:formatDate
										value="${vo.replyWriteDate}" pattern="yyyy-MM-dd" />
								</span>
							</div>
						</div>
					</div>
				</c:if>
				
				
				
				<!-- The Modal -->
				<div class="modal fade" id="replydeleteModal">
				    <div class="modal-dialog modal-dialog-centered">
				        <div class="modal-content">
				        
				            <form action="/review/replydelete.do" method="post">
				                <input type="hidden" name="reviewReplyNo" value="">
				                <input type="hidden" name="reviewNo" value="">
				                <input type="hidden" name="goodsNo" value="">
				                <!-- Modal body -->
				                <div class="modal-body">
				                    정말로 삭제하시겠습니까?
				                </div>
				                
				                <!-- Modal footer -->
				                <div class="modal-footer">
				                    <button type="submit" class="btn btn-danger">삭제</button>
				                    <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				                </div>
				            </form>
				        
				        </div>
				    </div>
				</div>
       



				<!-- 삭제 & 수정 버튼 추가 -->
				<c:if test="${!empty login && login.id == vo.id}">
					<button type="button" class="btn btn-primary deleteBtn"
						data-reviewno="${vo.reviewNo}" data-orderno=${vo.orderNo }>리뷰삭제</button>

					<button type="button" class="btn btn-primary reviewUpdateBtn"
						data-reviewno="${vo.reviewNo}" data-goodsno="${vo.goodsNo}"
						data-starscore="${vo.starscore}"
						data-reviewcontent="${fn:escapeXml(vo.reviewContent)}"
						data-reviewimage="${vo.reviewImage}">리뷰수정</button>
				</c:if>
			</div>
		</div>
	</c:forEach>

</div>

<jsp:include page="replyupdateForm.jsp"></jsp:include>

<div class="card-footer">
	<div>
		<pageNav:pageNavReview listURI="" pageObject="${pageObject}" />
	</div>
</div>
