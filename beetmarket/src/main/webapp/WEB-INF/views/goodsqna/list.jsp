<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE html>



<html>
<head>
    <title>Goods QnA</title>
    <!-- 필요한 CSS 및 JS 파일 포함 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script type="text/javascript">

    </script>
</head>
<body>

    <!-- goodsno 값을 숨겨진 필드로 전달 -->
    <input type="hidden" id="goodsno" value="${goodsno}" />

    <!-- 디버깅용: goodsno 값 출력 (필요시 주석 해제) -->
    <div>
      <button type="button" class="btn btn-primary"	
         data-toggle="modal" data-target="#GQWModal" id="Goods_Qna_OpenWriteBtn">
          질문등록
      </button>
    </div>

    <c:forEach items="${list}" var="vo">
        <div class="row" style="margin: 40px -10px 0 -10px">
            <div class="col-lg-12">
                <!-- card -->
                <div class="card">
                    <!-- 댓글 제목 -->
                    <div class="card-header" style="background: #e0e0e0;">
                        <i class="fa fa-comments fa-sw"></i> goodsqna ${vo.status }
                        
                        <!-- Button to Open the Modal -->
                       
                       <c:if test="${ !empty login && login.gradeNo == 5}">
                       <button type="button" class="btn btn-primary btn-sm pull-right answeran_update_Btn"
				    data-toggle="modal" data-target="#answeranupdateModal" data-goodsqna="${vo.goodsQNA }" data-answerdate="${vo.answer }"
				    data-answerdate="${vo.answerDate }">
						  답변등록
				   </button>
				   
				   
				   
				    <button type="button" class="btn btn-primary btn-sm pull-right answeran_dlete_Btn"
				    data-toggle="modal" data-target="#answerandeleteModal" data-goodsqna="${vo.goodsQNA }" data-answerdate="${vo.answer }"
				    data-answerdate="${vo.answerDate }">
						  답변삭제
				   </button>
                       </c:if>
                       
                       <c:if test="${!empty login && login.id == vo.id}">
                       <button type="button" class="btn btn-primary btn-sm pull-right goods_Qna_UpdateBtn"
				    data-toggle="modal" data-target="#GQUModal" data-goodsqna="${vo.goodsQNA }" data-question="${vo.question }" data-id="${vo.id }">
						  질문수정
				   </button>
				   
					<button type="button" class="btn btn-primary btn-sm pull-right goods_Qna_DeleteBtn" style="margin-right: 10px;"
					    data-toggle="modal" data-target="#GQDModal" data-goodsqna="${vo.goodsQNA }" data-question="${vo.question }" data-id="${vo.id }">
					    질문삭제
					</button>
				   </c:if>
                    </div>
                    
                    
                    <!-- 댓글 리스트 데이터 출력 -->
                    <div class="card-body">
                        <ul class="chat">
                            <!-- 데이터 한개 당 li 태그가 생긴다. - foreach -->
                            <li class="left clearfix" data-rno="12">
                                <div>
                                    <div class="header">
                                        <strong class="primary-font">${vo.id}</strong>
                                        <small class="pull-right text-muted">
                                            <fmt:formatDate value="${vo.writeDate}" pattern="yyyy-MM-dd"/>
                                        </small>
                                    </div>
                                    <pre>${vo.question}</pre>
                                </div>
                                
                                <c:if test="${not empty vo.answer}">
                                <div>
                                    <div class="header">
                                        <strong class="primary-font">${param.store_name}</strong>
                                        <small class="pull-right text-muted">
                                            <fmt:formatDate value="${vo.answerDate}" pattern="yyyy-MM-dd"/>
                                        </small>
                                    </div>
                                    <p><pre>${vo.answer}</pre></p>
                              </div>
                          	</c:if>
                            
                            </li>
                        </ul>
                    </div>

                    
                </div>
            </div>
        </div>
    </c:forEach>
                        <div class="card-footer">
                        
                    </div>


    <!-- 질문등록-->
    <div class="modal" id="GQWModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
		
		<input type="hidden" name="goodsNo" id="GQ_WriteModal" value="${param.goodsNo }">
          
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">질문등록</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
              <textarea rows="4" class="form-control" id="goods_Qnaquestion" maxlength="1000"></textarea>
              
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
              <button class="btn btn-primary" id="goods_QnaWriteBtn">등록</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          </div>

        </div>
      </div>
    </div>
    
    
    
    <!-- 질문수정 -->
    <div class="modal" id="GQUModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
		
		<input type="hidden" name=goodsQNA id="GQ_UpdateModal">
		<input type="hidden" id="goodsUpdate_Qnaid" value="">
		
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">질문 수정</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
              <textarea rows="4" class="form-control" id="goodsUpdate_Qnaquestion"></textarea>
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
              <button class="btn btn-success" id="goods_QnaUpdateBtn">수정</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>
    
    
    
    <!-- 질문삭제 -->
    <div class="modal" id="GQDModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
		
		<input type="hidden" name=goodsQNA id="GQ_DeleteModal">
		<input type="hidden" id="goodsDelete_Qnaid" value="">
		
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">질문 삭제</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
              <button class="btn btn-success" id="goods_QnaDeleteBtn">삭제</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>




   <!-- 답변등록 -->
    <div class="modal" id="answeranupdateModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
		
		<input type="hidden" name=goodsQNA id="GQ_answeranupdateModal">
		<input type="hidden" id="answeranupdate_answer" value="">
		<input type="hidden" id="answeranupdate_answerDate" value="">
		<input type="hidden" id="answeranupdate_status" value="">
		
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">답변등록</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
              <textarea rows="4" class="form-control" id="goodsUpdate_answer"></textarea>
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
              <button class="btn btn-success" id="answeran_update_ModalBtn">답변하기</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>



    <!-- 답변삭제 -->
    <div class="modal" id="answerandeleteModal">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
		
		<input type="hidden" name=goodsQNA id="GQ_answeran_DeleteModal">
		<input type="hidden" id="answerandelete_answer" value="">
		<input type="hidden" id="answerandelete_answerDate" value="">
		<input type="hidden" id="answerandelete_status" value="">
		
          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">답변삭제</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
              <button class="btn btn-success" id="answeran_Delete_ModalBtn">삭제</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>    
    

    <!-- 메시지 모달 -->
    <div class="modal" id="msgModal">
      <div class="modal-dialog">
        <div class="modal-content">

          <!-- Modal Header -->
          <div class="modal-header">
            <h4 class="modal-title">알림</h4>
            <button type="button" class="close" data-dismiss="modal">&times;</button>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
            <!-- 메시지가 여기에 표시됩니다. -->
          </div>

          <!-- Modal footer -->
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
          </div>
        </div>
      </div>
    </div>


</body>
</html>
