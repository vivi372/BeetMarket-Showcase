<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
  
  
  <script>
$(function() {
    // 리뷰 수정 버튼 클릭 이벤트 핸들러
    $(document).on("click", ".reviewUpdateBtn", function() {
        // 리뷰 수정 모달을 보여줌
        $("#reviewupdateModal").modal("show");

        // 클릭된 리뷰 항목에서 데이터 추출
        let reviewNo = $(this).data("reviewno"); // 리뷰 번호
        let goodsNo = $(this).data("goodsno"); // 상품 번호
        let starScore = $(this).data("starscore"); // 평점
        let reviewContent = $(this).data("reviewcontent"); // 리뷰 내용
        let reviewImage = $(this).data("reviewimage"); // 리뷰 이미지 파일
        let scroll = $(window).scrollTop();

        // 모달의 폼 필드에 데이터 설정
        $("#reviewupdateModal #reviewNo").val(reviewNo); // 리뷰 번호 설정
        $("#reviewupdateModal #goodsNo").val(goodsNo); // 상품 번호 설정
        $("#reviewupdateModal #reviewContent").val(reviewContent); // 리뷰 내용 설정
        $("#reviewupdateModal #scroll").val(scroll); // 스크롤 위치

        // 평점 설정
        $(`#reviewupdateModal input[name='starscore'][value='${starScore}']`).prop("checked", true);

        // 리뷰 이미지 파일이 있는 경우 파일명 설정 (필요시 파일 선택 창 초기화)
        if (reviewImage) {
            $("#reviewupdateModal #reviewFileName").text(reviewImage); // 예시로 파일명을 표시
        } else {
            $("#reviewupdateModal #reviewFileName").text(''); // 이미지가 없는 경우 초기화
        }
    });
});

</script>

<!-- 리뷰 수정 모달 -->
<div class="modal" id="reviewupdateModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <form id="reviewForm" action="/review/update.do" method="post" enctype="multipart/form-data">
            	<input type="hidden" name="scroll" id="scroll">
              
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #f8f9fa;">
                    <h5 class="modal-title" id="reviewModalLabel">리뷰 수정</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <!-- Modal Body (Form) -->
                <div class="modal-body">
                    <!-- 리뷰 번호 입력 -->
                    <div class="form-group">
                        <label for="reviewNo">리뷰 번호</label>
                        <input class="form-control" id="reviewNo" name="reviewNo" readonly>
                    </div>
                    
                    <!-- 상품 번호 입력 -->
                    <div class="form-group">
                        <label for="goodsNo">상품 번호</label>
                        <input class="form-control" id="goodsNo" name="goodsNo" readonly>
                    </div>
                    
                    <!-- 리뷰 내용 입력 -->
                    <div class="form-group">
                        <label for="reviewContent">리뷰 내용</label>
                        <textarea class="form-control" id="reviewContent" name="reviewContent" rows="4" required></textarea>
                    </div>

				<!-- 평점 입력 -->
				<link href="${pageContext.request.contextPath}/css/reviewStyle.css" rel="stylesheet"/>
				<div class="form-group">
				    <label for="starscore">상품은 만족하셨나요?</label>
				    <div class="star-rating">
				        <input type="radio" name="starscore" value="5" id="rate5">
				        <label for="rate5">★</label>
				        <input type="radio" name="starscore" value="4" id="rate4">
				        <label for="rate4">★</label>
				        <input type="radio" name="starscore" value="3" id="rate3">
				        <label for="rate3">★</label>
				        <input type="radio" name="starscore" value="2" id="rate2">
				        <label for="rate2">★</label>
				        <input type="radio" name="starscore" value="1" id="rate1">
				        <label for="rate1">★</label>
				    </div>
				</div>

                    <!-- 리뷰 이미지 미리보기 (필요한 경우) -->
                    <div class="form-group">
                        <label for="reviewFile">리뷰 이미지</label>
                        <span id="reviewFileName"></span>
                        <input type="file" class="form-control" id="reviewFile" name="reviewFile">
                    </div>
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


