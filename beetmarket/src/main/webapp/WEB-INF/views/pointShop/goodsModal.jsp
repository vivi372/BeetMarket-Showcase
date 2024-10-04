<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.custom-file-upload {
  border: 2px solid #ccc;
  display: inline-block;
  padding: 10px 20px;
  cursor: pointer;
  border-radius: 5px;
  text-align: center;
  transition: 0.3s;
}

.custom-file-upload:hover {
  background-color: #f1f1f1;
  border-color: #aaa;
}

.custom-file-upload input[type=file] {
  display: none;
}
</style>



	<!-- The Modal -->
	<div class="modal" id="goodsModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">상품 등록</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>					
						
				<div class="modal-body">
					<div id="goodsWriteDiv">					
						<jsp:include page="writeForm.jsp"/>
					</div>	
					<div id="goodsUpdateDiv">					
						<jsp:include page="updateForm.jsp"/>
					</div>
				</div>

				
				<div class="modal-footer">
					<button type="button" id="goodsSubmitBtn" class="btn btn-primary">등록</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
				
				
			</div>
		</div>
	</div>

