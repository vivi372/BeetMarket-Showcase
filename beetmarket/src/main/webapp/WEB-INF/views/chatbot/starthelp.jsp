<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>StartHelp</title>

<style>
.message-box {
	width:50%;
    margin-bottom: 10px;
    border-radius: 5px;
}

.text-right {
    background: #3e83fa; /* 예: 오른쪽 메시지 배경색 */
    text-align: right;
    color:#fcfbf7;
}

.text-left {
    background: #eeeeee; /* 예: 왼쪽 메시지 배경색 */
    text-align: left;
    
}
.table-hover{
cursor:pointer;
}
</style>

<script type="text/javascript" src="/js/dateUtils.js"></script>

<script>
$(function(){
	$(".btn-block").click(function(){
		location="starthelp.do";
	});
	
	$(".card-body").load("/chatajax/starthelp.do");
	
	function restart(){
		$(".card-body").append(`
				<div class="row">
					<div class="message-box pt-2 pl-3 border col-7">
					<p>카테고리를 선택하시오.</p>
					<div class="btn-group">
						<button class="btn btn-primary catebtn orderbtn">주문정보 변경</button>
					</div>
					<div class="btn-group">
						<button class="btn btn-primary catebtn refundbtn">환불/취소</button>
					</div>
					<div class="btn-group">
						<button class="btn btn-primary catebtn eventbtn">이벤트</button>
					</div>
					<div class="btn-group">
						<button class="btn btn-primary catebtn chatingbtn">상담원 연결</button>
					</div>
					</div>
					<div class="col-5"></div>
				</div>
		`);
	}
	
	function getorderlist(orderstate, orderstate2){
		//주문내역 불러오기: 결제완료 건에 대하여
		$.get("/chatajax/getorderlist.do?orderStateSearch="+orderstate+"&orderState2="+orderstate2, function(data){
			let list=data.list; // list 가져오기
			let pageObject=data.pageObject; // po 가져오기
			let searchVO=data.searchVO; // searchvo 가져오기
			
			if(list.length!=0){
			$(".card-body").append(`
					<div class="row">
						<div class="message-box pt-2 pl-3 border text-left col-7">
							<table class="table table-hover">
								<thead>
							      <tr>
							        <th>주문번호</th>
							        <th>상품번호</th>
							        <th>상품명</th>
							        <th>수량</th>
							        <th>주문가격</th>
							        <th>주문상태</th>
							      </tr>
							    </thead>
							    <tbody>
							    </tbody>
						    </table>
						    <small>*주문상태가 <p style="display:inline" class="orderstate"></p>인 주문내역만 포함함</small>
						</div>
						<div class="col-5"></div>
					</div>
			`);
			$(".orderstate").text(orderstate);
			$(".orderstate").append(", ");
			$(".orderstate").append(orderstate2);
			
			let tbody = $(".card-body").find("tbody");
			
			list.forEach(orderVO=> {
				tbody.append(`
					<tr class="datarow" data-orderNo="\${orderVO.orderNo}">
						<td>\${orderVO.orderNo}</td>
						<td>\${orderVO.goodsNo}</td>
						<td>\${orderVO.goodsName}</td>
						<td>\${orderVO.amount}</td>
						<td>\${orderVO.orderPrice}</td>
						<td>\${orderVO.orderState}</td>
					</tr>
				`);
			});
			}else{
				$(".card-body").append(`
					<div class="row">
						<div class="message-box text-left pt-2 pl-3 border col-7">
							<p style="color:red;font:bold"> * * 해당하는 주문내역이 없습니다. 확인 후 다시 시도해주세요. * * </p>
						</div>
						<div class="col-5"></div>
					</div>
				`);
			}
			
			
		}); 
	}
	
	$(".card-body").on("click", ".orderbtn", function(){
		changedelivery();
		$(".card-body .catebtn").prop("disabled", true);
	});
	
	function isend(){
		$(".card-body").append(`
				<div class="row">
					<div class="message-box pt-2 pl-3 border col-7">
						<p>요청이 처리되었습니다.</p>
						<p>상담을 종료하시겠습니까?</p>
						<div class="btn-group">
							<button class="btn btn-primary quit">예</button>
						</div>
						<div class="btn-group">
							<button class="btn btn-danger keep">아니오</button>
						</div>
					</div>
					<div class="col-5"></div>
				</div>
		`);
	}
	
	//주문정보 변경 선택시
	function changedelivery(){
		$(".card-body").append(`
				<div class="row">
				<div class="col-5"></div>
				<div class="message-box pt-2 pr-3 border text-right col-7"
					style="float: right;">
					<div>
						<p>주문정보 변경</p>
					</div>
				</div>
			</div>
		`);
		$(".card-body").append(getorderlist("결제완료"));
			
		$(".card-body").on("click", ".datarow", function(){
				let orderNo=$(this).data("orderno");
				datarowclick(orderNo);
				$(".card-body").append(`
						<div class="row">
							<div class="message-box pt-2 pl-3 border col-7">
								<button class="btn btn-outline-secondary" id="changedlvy">배송지 변경</button>
							</div>
							<div class="col-5"></div>
						</div>
				`);
				$(".card-body").on("click", "#changedlvy", function(){
					$("#dlvySelModal").modal("show");
					$("#dlvyList").load("/dlvy/list.do");
				});
				
				
				// ========== 배송지 선택 버튼 이벤트 시작 ==========
				$(document).on("click", ".dlvySelBtn" , function() {
					//클릭한 버튼이 있는 dlvyListItem에서 dlvyaddrno를 얻은 후 변수에 저장
					let $dlvyListItem = $(this).closest(".dlvyListItem")
					let recipient = $dlvyListItem.find(".recipientModal").text();
					let dlvyName = $dlvyListItem.find(".dlvyNameModal").text();
					let tel = $dlvyListItem.find(".telModal").text();
					let addr = $dlvyListItem.find(".addrModal").text();
					let addrDetail = $dlvyListItem.find(".addrDetailModal").text();
					let postNo = $dlvyListItem.find(".postNoModal").text();
					//주문 번호,배송지 번호,페이지 정보가 입력된 폼 생성
					$.get("/chatajax/dlvyUpdate.do?orderNo="+orderNo+"&dlvyName="+dlvyName+"&recipient="+recipient+
							"&tel="+tel+"&addr="+addr+"&addrDetail="+addrDetail+"&postNo="+postNo,
							function(data){
						$("#dlvySelModal").modal("hide");
						
						isend();
						
						$(".card-body").on("click", ".quit", function(){
							alert("상담을 종료합니다. 이용해주셔서 감사합니다.");
							location="/main/main.do";
						});
						$(".card-body").on("click", ".keep", function(){
							$(".card-body").append(restart);
						});
					});
				});
			
			//배송지 신규입력 버튼 클릭 이벤트
			$(document).on("click", "#dlvyWriteBtn",function() {
				$("#dlvyList").load("/dlvy/writeForm.do");
				
			});		
			//배송지 입력 폼에서 등록 버튼 클릭
			$(document).on("click","#dlvyWriteFormBtn" , function() {
				let formData = $("#dlvyWriteForm").serializeArray();
				let form = {};		
				$.each(formData, function() {
					form[this.name] = this.value;
				});	
				$("#dlvyList").load("/dlvy/write.do", form);
			});
			//배송지 수정 버튼 클릭 이벤트
			$(document).on("click", ".dlvyUpdateFormBtn",function() {
				let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");
				$("#dlvyList").load("/dlvy/updateForm.do?dlvyAddrNo="+dlvyAddrNo);		
			});
			//배송지 수정 폼에서 수정 버튼 클릭
			$(document).on("click","#dlvyUpdateBtn" , function() {
				let formData = $("#dlvyUpdateForm").serializeArray();
				let form = {};		
				$.each(formData, function() {
					form[this.name] = this.value;
				});	
				$("#dlvyList").load("/dlvy/update.do", form);
			});
			$(document).on("click",".dlvyDeleteBtn", function() {		
				if($(this).closest(".list-group-item").find(".basicAddr").length == 1) {
					alert("다른 배송지를 기본 배송지로 변경하고 삭제해주세요.");
				} else {
					let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");			
					$("#dlvyList").load("/dlvy/delete.do?dlvyAddrNo="+dlvyAddrNo);
				}
			});
			// ========== 배송지 모달 관련 처리의 끝 ==========
			
		});
	} //주문정보 변경 함수의 긑

	function datarowclick(orderNo){
		$(".card-body").append(`
				<div class="row">
				<div class="col-5"></div>
				<div class="message-box pt-2 pr-3 border text-right col-7"
					style="float: right;">
					<div>
						주문번호 [ <p style="display:inline" id="orderno"></p> ]번 선택
					</div>
				</div>
			</div>
		`);
		$("#orderno").text(orderNo);
	}
	
	function refund(){
		$(".card-body").append(`
				<div class="row">
				<div class="col-5"></div>
				<div class="message-box pt-2 pr-3 border text-right col-7"
					style="float: right;">
					<div>
						<p>취소/반품</p>
					</div>
				</div>
			</div>
		`);
		//취소 또는 환불 중 선택하도록
		$(".card-body").append(`
				<div class="row">
					<div class="message-box pt-2 pl-3 border col-7">
						<p>취소 또는 반품을 선택하십시오.</p>
						<div class="btn-group">
							<button class="btn btn-outline-primary cancel">취소</button>
						</div>
						<div class="btn-group">
							<button class="btn btn-outline-primary refund">반품</button>
						</div>
					</div>
					<div class="col-5"></div>
				</div>
		`);
		//취소: 결제완료, 배송준비중인 주문내역만
		$(".card-body").on("click", ".cancel", function(){
			$(".card-body .btn-outline-primary").prop("disabled", true);
			
			$(".card-body").append(`
				<div class="row">
					<div class="col-5"></div>
					<div class="message-box pt-2 pr-3 border text-right col-7"
						style="float: right;">
						<div>
							<p>취소</p>
						</div>
					</div>
				</div>
			`);
			
			$(".card-body").append(getorderlist("결제완료", "배송준비"));
			$(".card-body").on("click", ".datarow", function(){
				let orderNo=$(this).data("orderno");
				datarowclick(orderNo);
				$(".card-body").append(`
						<div class="row">
							<div class="message-box pt-2 pl-3 border col-7">
								<button class="btn btn-outline-secondary orderCancleBtn">취소신청</button>
							</div>
							<div class="col-5"></div>
						</div>
				`);
				//취소신청 버튼 클릭시
				$(".card-body").on("click", ".orderCancleBtn", function(){
					let orderState = "취소요청";
					//주문 번호 모달 입력 태그에 입력
					$("#cancleReason").val("");
					$(".request").text("취소 ");
					$("#cancleModal").modal("show");
					
					//모달에서 취소 요청버튼 클릭시
					$(document).on("click", ".crmodalbtn" , function() {
						let cancleReason=$("#cancleReason").val();
						$.get("/chatajax/stateUpdate.do?orderNo="+orderNo+"&orderStateInput="+orderState+
	 							"&cancleReason="+cancleReason+"&orderNos="+orderNo,
	 							function(data){
			 						$("#cancleModal").modal("hide");
			 						
			 						isend();
			 						
			 						$(".card-body").on("click", ".quit", function(){
			 							alert("상담을 종료합니다. 이용해주셔서 감사합니다.");
			 							location="/main/main.do";
			 						});
			 						$(".card-body").on("click", ".keep", function(){
			 							$(".card-body").append(restart);
			 						});
	 					});
					});//취소 요청 모달의 끝
				});//취소 신청 이벤트의 끝
			});
		}) //취소 선택의 끝
		
		//환불: 배송중, 배송완료인 주문내역만
		$(".card-body").on("click", ".refund", function(){
			$(".card-body .btn-outline-primary").prop("disabled", true);
			
			$(".card-body").append(`
					<div class="row">
						<div class="col-5"></div>
						<div class="message-box pt-2 pr-3 border text-right col-7"
							style="float: right;">
							<div>
								<p>반품</p>
							</div>
						</div>
					</div>
				`);
			
			$(".card-body").append(getorderlist("배송중", "배송완료"));
			$(".card-body").on("click", ".datarow", function(){
				let orderNo=$(this).data("orderno");
				datarowclick(orderNo);
				$(".card-body").append(`
						<div class="row">
							<div class="message-box pt-2 pl-3 border col-7">
								<button class="btn btn-outline-secondary orderRefundBtn">반품신청</button>
							</div>
							<div class="col-5"></div>
						</div>
				`);
				$(".card-body").on("click", ".orderRefundBtn", function(){
					let orderState = "반품요청";
					//주문 번호 모달 입력 태그에 입력
					$("#cancleReason").val("");
					$(".request").text("반품 ");
					$("#cancleModal").modal("show");
					
					$(document).on("click", ".crmodalbtn" , function(){
						let cancleReason=$("#cancleReason").val();
						$.get("/chatajax/stateUpdate.do?orderNo="+orderNo+"&orderStateInput="+orderState+
	 							"&cancleReason="+cancleReason+"&orderNos="+orderNo,
	 							function(data){
			 						$("#cancleModal").modal("hide");
			 						
			 						isend();
			 						
			 						$(".card-body").on("click", ".quit", function(){
			 							alert("상담을 종료합니다. 이용해주셔서 감사합니다.");
			 							location="/main/main.do";
			 						});
			 						$(".card-body").on("click", ".keep", function(){
			 							$(".card-body").append(restart);
			 						});
	 					});//모달에서 요청 이벤트 처리의 끝
					});//모달의 끝
				});
			});
		})
	}//취소/환불 함수의 끝
	
	//취소 / 환불 선택시
	$(".card-body").on("click", ".refundbtn", function(){
		refund();
		$(".card-body .catebtn").prop("disabled", true);
	});
	
	
	//이벤트 버튼 클릭시
	function event(){
		$(".card-body").append(`
				<div class="row">
				<div class="col-5"></div>
				<div class="message-box pt-2 pr-3 border text-right col-7"
					style="float: right;">
					<div>
						<p>이벤트</p>
					</div>
				</div>
			</div>
		`);
		$.get("/chatajax/eventlist.do", function(data){
			let list=data.list;
			
			$(".card-body").append(`
				<div class="row">
					<div class="message-box pt-2 pl-3 border text-left col-7">
				    <small>*정확한 일시는 상세 페이지에서 확인해주세요.</small>
						<table class="table table-hover">
							<thead>
						      <tr>
						        <th>이벤트명</th>
						        <th>시작일</th>
						        <th>종료일</th>
						      </tr>
						    </thead>
						    <tbody>
						    </tbody>
					    </table>
					</div>
					<div class="col-5"></div>
				</div>
			`);
			
			let tbody = $(".card-body").find("tbody");
			
			list.forEach(EventVO=> {
				console.log(EventVO);
				let startDate = dateToString(new Date(EventVO.startDate));
				let endDate = dateToString(new Date(EventVO.endDate));
				tbody.append(`
					<tr class="datarow" data-no="\${EventVO.no}">
						<td>\${EventVO.title}</td>
						<td>\${startDate}</td>
						<td>\${endDate}</td>
					</tr>
				`);
			});//forEach의 끝
			
			isend();
			$(".card-body").on("click", ".quit", function(){
				alert("상담을 종료합니다. 이용해주셔서 감사합니다.");
				location="/main/main.do";
			});
			$(".card-body").on("click", ".keep", function(){
				$(".card-body").append(restart);
			});
			
			$(".card-body").on("click", ".datarow", function(){
				let no=$(this).data("no");
				location="/event/view.do?no="+no;
			});
		});//eventlist ajax의 끝
	}
	
	$(".card-body").on("click", ".eventbtn", function(){
		event();
		$(".card-body .catebtn").prop("disabled", true);
	});
	
	function chating(){
		$(".card-body").append(`
				<div class="row">
					<div class="col-5"></div>
					<div class="message-box pt-2 pr-3 border text-right col-7"
						style="float: right;">
						<div>
							<p>상담원연결</p>
						</div>
					</div>
				</div>
			`);
			$(".card-body").append(`
					<div class="row">
						<div class="message-box pt-2 pl-3 border col-7">
							<pre>[ 예 ] 선택시 상담원 연결 화면으로 전환됩니다. 
	연결을 원하지 않으시면 [ 아니오 ]를 눌러주세요.</pre>
							<div class="btn-group">
								<button class="btn btn-outline-primary yes">예</button>
							</div>
							<div class="btn-group">
								<button class="btn btn-outline-primary no">아니오</button>
							</div>
						</div>
						<div class="col-5"></div>
					</div>
			`);
			$(".card-body").on("click", ".yes", function(){
				location="addroom.do?partner=admin";
			});
	}
	
	
	$(".card-body").on("click", ".chatingbtn", function(){
		chating();
		$(".card-body .catebtn").prop("disabled", true);
	});//상담원 연결의 끝
	
});
</script>
</head>

<body>
	<div class="container">
		<div class="card">
			<div class="card-header">
				<h3>상담챗봇</h3>
			</div>
			<div class="card-body">
			</div>
			<div>
			    <button class="btn btn-light btn-block" type="button">초기화</button>
		  	</div>
		</div>
	</div>


<!-- 배송지 변경 모달 -->	    
	<div class="modal fade" id="dlvySelModal">
		<div class="modal-dialog modal-dialog-centered h-50  modal-lg">
	    	<div class="modal-content">		        
		        <div class="modal-header">
		          	<h4 class="modal-title"><b>배송지 목록</b></h4>
		          	<!-- 모달창이 사라지는 아이콘 버튼 -->
		          	<button type="button" class="close" data-dismiss="modal">&times;</button>
		        </div>	        
		        
		        <div class="modal-body">
		        	<div id="dlvyList">
		        	
		        	</div>
		        </div>
		        	
		        
		        <div class="modal-footer">		        
		          	<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
		        </div>	        
	      	</div>
	 	</div>
	 </div>


	<!-- 취소 요청 모달 -->
	<div class="modal fade" id="cancleModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title mx-auto">
						<strong class="request"></strong><strong>사유를 입력하세요</strong>
					</h4>
					<!-- 모달창이 사라지는 아이콘 버튼 -->
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<div class="form-group">
					<input type="text" class="form-control" id="cancleReason"
						name="cancleReason" maxlength="100" placeholder="사유를 입력해주세요.">
				</div>
				<div class="modal-footer">
					<!-- 배송지 변경을 클릭하면 모달창이 닫히고 입력된 데이터로 화면이 변한다. -->
					<button class="btn btn-dark crmodalbtn">요청</button>
					<!-- 모달창이 사라지는 버튼 -->
					<button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</body>

</html>