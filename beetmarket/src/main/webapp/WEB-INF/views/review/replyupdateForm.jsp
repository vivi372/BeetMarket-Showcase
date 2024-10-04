<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>


<script>
$(function() {
    // 리뷰 수정 버튼 클릭 이벤트 핸들러
    $(document).on("click", ".replyreviewUpdateBtn", function() {
        // 리뷰 수정 모달을 보여줌
        $("#replyreviewupdateModal").modal("show");

        // 클릭된 리뷰 항목에서 데이터 추출
        let reviewReplyNo = $(this).data("reviewreplyno"); // 답변 번호
        let reviewNo = $(this).data("reviewno"); // 리뷰 번호
        let replyContent = $(this).closest(".dataRow").find(".replyContent").text(); // 리뷰 내용
        console.log(reviewReplyNo);
        let scroll = $(window).scrollTop();

        // 모달의 폼 필드에 데이터 설정
        $("#replyreviewupdateModal #reviewReplyNo").val(reviewReplyNo); // 리뷰 번호 설정
        $("#replyreviewupdateModal #reviewNo").val(reviewNo); // 리뷰 번호 설정
        $("#replyreviewupdateModal #replyContent").val(replyContent); // 리뷰 내용 설정
        $("#replyreviewupdateModal #scroll").val(scroll); // 스크롤 위치
    });
});
</script>

    
    
    <!-- 리뷰 수정 모달 -->
<div class="modal" id="replyreviewupdateModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <form id="reviewForm" action="/review/replyupdate.do" method="post" enctype="multipart/form-data">
            	<input type="hidden" name="scroll" id="scroll">
            	
              
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #f8f9fa;">
                    <h5 class="modal-title" id="reviewupdateModalLabel">답변수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                    
                    
		         <input type="hidden" name="goodsNo" value="${param.goodsNo }" >
                   <input type="hidden" name="reviewReplyNo" id="reviewReplyNo" >
<!--                    <input type="hidden" name="reviewNo" id="reviewNo" > -->
                    
                    
                    
                    <!-- 리뷰 내용 입력 -->
                    <div class="form-group">
                        <label for="replyContent">답변 내용</label>
                        <textarea class="form-control" id="replyContent" name="replyContent" rows="4" required></textarea>
                    </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-primary">등록</button>
                </div>
            </form>
        </div>
    </div>
</div>