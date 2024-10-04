<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- CSS 스타일 정의 -->
<style type="text/css">
/*수량 입력 태그 중앙 정렬*/
.amount {
	text-align: center;
}
</style>

<!-- 옵션 수정 모달 창 -->
<div class="modal fade" id="optUpdateModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
      
			<!-- 모달 헤더 -->
			<div class="modal-header">
				<h4 class="modal-title">옵션 수정</h4>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			
			<!-- 옵션 수정 폼 -->
			<form action="/basket/update.do" method="post" id="updateForm">
				<!-- 숨김 필드: 장바구니 번호와 주문 가격 -->
				<input type="hidden" name="basketNo" id="basketNo">
				<input type="hidden" name="orderPrice" id="orderPrice">
				
				<!-- 모달 본문 -->
				<div class="modal-body">
					<!-- 상품 정보: 이미지와 제목 -->
					<div class="media border p-3">	          				 
						<img src="" alt="상품 이미지" id="updateModalImage" class="mr-3" style="width:60px;">
						<input type="hidden" id="freedeliveryModal">
						<div class="media-body"> 
							<p id="updateModalTitle"></p>
						</div>
					</div>        			
					
					<hr>
					
				
	
					<div id="selDiv">
					</div>
					
					<!-- 옵션 카드 리스트 -->
					<ul class="list-group my-2" id="optCard">
					</ul>
					
					<hr>
					<!-- 총 상품 금액과 배송비 정보 -->
					<div class="row">
						<div class="col">
							<b>총 상품 금액</b>
							<br><span id="updateDlvyPrint">배송비</span>
						</div>
						<div class="col text-right mr-1">
							<b id="totalPrice">0</b><b>원</b>
							<br><span id="updateModalCharge"></span><span id="dlvyWon">원</span>
						</div>
					</div>
				</div>
	        
				<!-- 모달 푸터 -->
				<div class="modal-footer">
					<!-- 수정 버튼 -->
					<div class="col">
						<button type="submit" class="btn btn-primary btn-block" id="updateSubmitBtn">수정</button>				
					</div>
					<!-- 취소 버튼 -->
					<div class="col">
						<button type="button" class="btn btn-secondary btn-block" data-dismiss="modal">취소</button>		
					</div>	     			
				</div>
			</form>
		</div>
	</div>
</div>
