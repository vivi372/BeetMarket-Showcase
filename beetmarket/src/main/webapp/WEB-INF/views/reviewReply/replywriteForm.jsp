<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>


<!-- 리뷰 등록 모달 -->
<div class="modal" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="reviewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document" style="max-width: 600px;">
        <div class="modal-content">
            <form id="reviewForm" action="/review/write.do" method="post" enctype="multipart/form-data">
                <!-- Modal Header -->
                <div class="modal-header" style="background-color: #f8f9fa;">
                    <h5 class="modal-title" id="reviewModalLabel">리뷰쓰기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>


                    <!-- 리뷰 내용 입력 -->
                    <div class="form-group">
                        <label for="replyContent">답변 내용</label>
                        <textarea class="form-control" id="reviewContent" name="reviewContent" rows="4" required></textarea>
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