<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<style>


.nav-tabs .active {
 	cursor: default !important; 
}
</style>    

<script type="text/javascript">
$(function() {
	
	$(".reviewList_btn").click(function (){
		if($(this).hasClass("active")) return false;
		$(".reviewList").load(`/review/list.do?goodsNo=${param.goodsNo}&scroll=${param.scroll}`);
		$(".Goods_Qna_List_btn").removeClass("active");
		$(this).addClass("active");
		
	})
	
	
	$(".Goods_Qna_List_btn").click(function (){
		if($(this).hasClass("active")) return false;
		$(".reviewList").load("/goods_qna/list.do?goodsNo=" + ${param.goodsNo}+"&store_name="+"${vo.store_name}");
		$(".reviewList_btn").removeClass("active");
		$(this).addClass("active");
	})
	
	
	$(".reviewList").load(`/review/list.do?goodsNo=${param.goodsNo}&scroll=${param.scroll}`);
	

	$(".reviewList").on("click",".pagination .page-item", function() {
	    let page = $(this).data("page");
	    let scroll = $(window).scrollTop();
	    $(".reviewList").load(`/review/list.do?page=\${page}&goodsNo=${param.goodsNo}&scroll=\${scroll}`);
	});

	$(".Goods_Qna_List").on("click",".pagination .page-item", function() {
	    let page = $(this).data("page");
	    let scroll = $(window).scrollTop();
	    $(".Goods_Qna_List").load(`/goods_qna/list.do?page=${page}&goodsNo=${goodsNo}&scroll=${scroll}`);
	});
	
    // 질문 등록 모달 창에서의 등록 처리
    $(".reviewList").on("click", "#goods_QnaWriteBtn", function(){
    		// 회색 화면과 마우스 클릭 문제 복구
        $('.modal-backdrop').remove();
        // goodsno 변수 선언 및 초기화
        var goodsno = $("#GQ_WriteModal").val(); // JSP에서 숨겨진 필드로 전달
        
        console.log("goodsno:", goodsno); // 디버깅용 로그

        if (!goodsno) {
            alert("상품 번호(goodsno)가 정의되지 않았습니다.");
            return;
        }

        var question = $("#goods_Qnaquestion").val();
        
        if (!question.trim()) {
            alert("질문 내용을 입력해주세요.");
            return;
        }

        // 질문 등록에 필요한 데이터(no, content) 수정
        let goodsQna = {
            goodsNo: parseInt(goodsno), // 숫자형으로 변환
            question: question
        };

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "/goods_qna/write.do",
            data: JSON.stringify(goodsQna), // goodsQna로 변경
            contentType: "application/json",
            dataType: "json",
            success: function(response){
                if(response.status === "success"){
                       $("#GQWModal").modal("hide");
                    // 댓글 리스트 데이터가 변경되었으므로 리스트를 다시 불러온다.
                   $(".reviewList").load("/goods_qna/list.do?goodsNo=${param.goodsNo}", function() {
//                        $("#msgModal .modal-body").text(response.message);
//                        $("#msgModal").modal("show");
                    });
                } else {
                    alert("오류: " + response.message);
                }
            },
            error: function(xhr, status, error){
                console.error("AJAX Error:", status, error);
                alert("댓글 등록 중 오류가 발생했습니다.");
            }
        });
        });
	
	
    
    // 질문 수정
    $(".reviewList").on("click",".goods_Qna_UpdateBtn", function() {
        let goodsQNA = $(this).data("goodsqna");
        let question = $(this).data("question");
        let id = $(this).data("id");

        $("#GQUModal #GQ_UpdateModal").val(goodsQNA);
        $("#GQUModal #goodsUpdate_Qnaquestion").val(question);
        $("#GQUModal #goodsUpdate_Qnaid").val(id);
    });
    
    
 	// 모달 창의 수정 버튼에 이벤트 바인딩
    $(document).on("click", "#goods_QnaUpdateBtn", function(){

        // 'goodsQNA' 변수 선언 및 초기화
        let goodsQNA = $("#GQ_UpdateModal").val();
        console.log("goodsQNA:", goodsQNA); // 디버깅용 로그

        if (!goodsQNA) {
            alert("(goodsQNA)가 정의되지 않았습니다.");
            return;
        }

        // 'id' 변수 선언 및 초기화
        let id = $("#goodsUpdate_Qnaid").val();
        console.log("id:", id);
        if (!id) {
            alert("사용자 ID가 정의되지 않았습니다.");
            return;
        }

        // 'question' 변수 선언 및 초기화
        let question = $("#goodsUpdate_Qnaquestion").val();
        console.log("question:", question);

        if (!question.trim()) {
            alert("질문을 입력해주세요.");
            return;
        }

        // 댓글 수정에 필요한 데이터 수정
        let goodsQna = {
        	  goodsQNA: parseInt(goodsQNA), // 숫자형으로 변환
            question: question,
            id: id
        };

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "/goods_qna/update.do",
            data: JSON.stringify(goodsQna),
            contentType: "application/json",
            success: function(response){
            	alert(response);
                    $("#GQUModal").modal("hide");
                    // 댓글 리스트를 다시 불러옵니다.
                    $(".reviewList").load("/goods_qna/list.do?goodsNo=" + ${param.goodsNo});
                
              
            },
            error: function(xhr, status, err){
            	console.log("xhr" + xhr);
    			console.log("status" + status);
    			console.log("err" + err);
                alert("수정 중 오류가 발생했습니다.");
            }
        });
    });

 
 
 	// 질문 삭제
    $(".reviewList").on("click",".goods_Qna_DeleteBtn", function() {
        let goodsQNA = $(this).data("goodsqna");
        let id = $(this).data("id");

        $("#GQDModal #GQ_DeleteModal").val(goodsQNA);
        $("#GQDModal #goodsDelete_Qnaid").val(id);
    });
 
 
	// 질문 삭제 처리
	var goodsNo = "${param.goodsNo}";
	
	$(document).on("click", "#goods_QnaDeleteBtn", function() {
	    let goodsQNA = $("#GQ_DeleteModal").val();
	    console.log("goodsQNA", goodsQNA);
	    
	    if (!goodsQNA) {
            alert("(goodsQNA)가 정의되지 않았습니다.");
            return;
        }
	    
        // 댓글 삭제에 필요한 데이터 수정
        let goosQna = {
        	  goodsQNA: parseInt(goodsQNA), // 숫자형으로 변환
            id: "${login.id}"
        };
	    if (confirm("질문을 삭제하시겠습니까?")) {
	        $.ajax({
	            type: "POST",
	            url: "/goods_qna/delete.do",
	            data: goosQna,
	            success: function(result) {
	                alert("리뷰가 삭제되었습니다.");
	                $("#GQDModal").modal("hide");
	                $(".reviewList").load("/goods_qna/list.do?goodsNo=" + goodsNo);
	            },
	            error: function() {
	                alert("삭제 중 오류가 발생했습니다.");
	            }
	        });
	    }
	});
	
	
	
	
    // 답변 등록
    $(".reviewList").on("click",".answeran_update_Btn", function() {
        let goodsQNA = $(this).data("goodsqna");
        let answer = $(this).data("answer");

        $("#answeranupdateModal #GQ_answeranupdateModal").val(goodsQNA);
        $("#answeranupdateModal #answeranupdate_answer").val(answer);
    });
    
    
 // 모달 창의 답장 버튼에 이벤트 바인딩
    $(document).on("click", "#answeran_update_ModalBtn", function(){

        // 'goodsQNA' 변수 선언 및 초기화
        let goodsQNA = $("#GQ_answeranupdateModal").val();
        console.log("goodsQNA:", goodsQNA); // 디버깅용 로그

        if (!goodsQNA) {
            alert("(goodsQNA)가 정의되지 않았습니다.");
            return;
        }

        // 'answer' 변수 선언 및 초기화
        let answer = $("#goodsUpdate_answer").val();
        console.log("answer:", answer);
        if (!answer) {
            alert("사용자 answer가 정의되지 않았습니다.");
            return;
        }

        // 댓글 수정에 필요한 데이터 수정
        let goodsQna = {
        	  goodsQNA: parseInt(goodsQNA), // 숫자형으로 변환
        	  answer: answer,
        };

        // AJAX 요청
        $.ajax({
            type: "POST",
            url: "/goods_qna/answeranupdate.do",
            data: JSON.stringify(goodsQna),
            contentType: "application/json",
            success: function(response){
            	alert(response);
                    $("#answeranupdateModal").modal("hide");
                    // 댓글 리스트를 다시 불러옵니다.
                    $(".reviewList").load("/goods_qna/list.do?goodsNo=" + ${param.goodsNo}+"&store_name="+"${vo.store_name}");
            },
            error: function(xhr, status, err){
            	console.log("xhr" + xhr);
    			console.log("status" + status);
    			console.log("err" + err);
                alert("수정 중 오류가 발생했습니다.");
            }
        });
    });
 
 
 
 
	// 답변 삭제 (답변 데이터 값 null로 변경 )
	   $(".reviewList").on("click",".answeran_dlete_Btn", function() {
	       let goodsQNA = $(this).data("goodsqna");
	
	       $("#answerandeleteModal #GQ_answeran_DeleteModal").val(goodsQNA);
	   });
	   
	   
	// 모달 창의 답장삭제 확인 버튼
	   $(document).on("click", "#answeran_Delete_ModalBtn", function(){
	
	       // 'goodsQNA' 변수 선언 및 초기화
	       let goodsQNA = $("#GQ_answeran_DeleteModal").val();
	       console.log("goodsQNA:", goodsQNA); // 디버깅용 로그
	
	       if (!goodsQNA) {
	           alert("(goodsQNA)가 정의되지 않았습니다.");
	           return;
	       }
	
	       // 댓글 수정에 필요한 데이터 수정
	       let goodsQna = {
	       	  goodsQNA: parseInt(goodsQNA) // 숫자형으로 변환
	       };
	
	       // AJAX 요청
	       $.ajax({
	           type: "POST",
	           url: "/goods_qna/answerdelete.do",
	           data: JSON.stringify(goodsQna),
	           contentType: "application/json",
	           success: function(response){
	           	alert(response);
	                   $("#answerandeleteModal").modal("hide");
	                   // 댓글 리스트를 다시 불러옵니다.
	                   $(".reviewList").load("/goods_qna/list.do?goodsNo=" + ${param.goodsNo}+"&store_name="+"${vo.store_name}");
	           },
	           error: function(xhr, status, err){
	           	console.log("xhr" + xhr);
	   			console.log("status" + status);
	   			console.log("err" + err);
	               alert("삭제 중 오류가 발생했습니다.");
	           }
	       });
	   });
    
	
	
	
	
	// 리뷰 삭제 처리
	$(".reviewList").on("click",".deleteBtn",function() {
		let reviewNo = $(this).data("reviewno");
		let orderNo = $(this).data("orderno");
		console.log(reviewNo);
		console.log(orderNo);
		if (confirm("리뷰를 삭제하시겠습니까?")) {
			$.ajax({
				type: "GET",
				url: "/review/delete.do?reviewNo="+reviewNo+"&orderNo="+orderNo,
				success: function(result) {
					alert("리뷰가 삭제되었습니다.");
					$(".reviewList").load("/review/list.do?page=1&goodsNo=${vo.goodsNo}");
				},
				error: function() {
					alert("리뷰 삭제 중 오류가 발생했습니다.");
				}
			});
		}
	});
});



</script>
 <ul class="nav nav-tabs">
    <li class="nav-item">
      <a class="nav-link active reviewList_btn" onclick="return false;" href="#">리뷰</a>
    </li>
    
    
    <li class="nav-item">
      <a class="nav-link Goods_Qna_List_btn" onclick="return false;" href="#">qna</a>
    </li>
  </ul>


<div class="reviewList" data-sellid="${vo.id }">

</div>

<!-- </div> -->
<jsp:include page="replyupdateForm.jsp"></jsp:include>
<jsp:include page="replywriteForm.jsp" />
<jsp:include page="updateForm.jsp"></jsp:include>