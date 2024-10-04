/**
 * 배송지 관련 js
 */

$(function() {
	//모달 관련 이벤트
	//배송지 변경 버튼 클릭시 이벤트 - 아작스를 이용해 모달에 배송지 정보 띄우기
	$("#dlvyBtn").click(function() {
		$("#dlvyList").load("/dlvy/list.do");
	});			
	
	
	//배송지 선택 버튼 이벤트
	$("#dlvySelModal").on("click", ".dlvySelBtn" , function() {
		//배송지 정보 가져오기
		let $listItem = $(this).closest(".list-group-item");
		dlvySelect($listItem);		
	});	
	//배송지 alert 등록 링크 클릭 이벤트
	$("#dlvyPrintDiv").on("click", "#dlvyAlertLink",function() {
		//배송지 모달 등장
		$("#dlvySelModal").modal("show");
		//아작스를 이용해 배송지 등록 폼 출력
		$("#dlvyList").load("/dlvy/writeForm.do" , function() {
			//기본 배송지를 체크된 상태로 바꾼후 숨겨 무조건 기본 배송지 만든다.
			$("#basic").attr('checked',true);
			$("#basicDiv").hide();
			$(".backBtn").hide();
			//fristDlvyWrite 전역 변수로 사용해 다른 위치에서도 체크 가능하게 한다.
			fristDlvyWrite = true;			
		});
	});
	
	//배송지 신규입력 버튼 클릭 이벤트
	$("#dlvySelModal").on("click", "#dlvyWriteBtn",function() {	
		//아작스를 이용해 배송지 등록 폼 출력
		$("#dlvyList").load("/dlvy/writeForm.do");		
	});
	
	//배송지 입력 폼에서 등록 버튼 클릭
	$("#dlvySelModal").on("click","#dlvyWriteFormBtn" , function() {
		//dlvyWriteForm 입력된 데이터를 배열로 가져온다.
		let formData = $("#dlvyWriteForm").serializeArray();
		//ajax에 데이터로 보내기 위해 json타입으로 변환
		let form = {};		
		$.each(formData, function() {
			form[this.name] = this.value;
		});	
		//ajax에 form 데이터를 보내 배송지를 등록한다. - 등록후 dlvyList에 dlvylist 출력
		$("#dlvyList").load("/dlvy/write.do", form,  function() {
			//만약 처음으로 배송지 등록하는 경우
			if(fristDlvyWrite) {
				//등록된 배송지를 바로 가져와 결제폼에 입력한다.
				let $listItem = $("#dlvySelModal").find(".list-group-item");
				dlvySelect($listItem);
				//배송지 alert를 지우고 배송지 변경 버튼 보이게 한다.
				$("#dlvyAlert").remove();
				$("#dlvyBtn").show();
				fristDlvyWrite = false;
			}
		});
	});
	//배송지 수정 버튼 클릭 이벤트
	$("#dlvySelModal").on("click", ".dlvyUpdateFormBtn",function() {
		//바꿀 배송지의 번호를 가져온다.
		let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");
		let dlvyLength = $(".dlvyListItem").length;
		//ajax를 사용해 수정할 배송지를 번호를 넘겨 배송지 수정 폼을 출력한다.
		$("#dlvyList").load("/dlvy/updateForm.do?dlvyAddrNo="+dlvyAddrNo+"&length="+dlvyLength);		
	});
	//배송지 수정 폼에서 수정 버튼 클릭
	$("#dlvySelModal").on("click","#dlvyUpdateBtn" , function() {
		//dlvyUpdateForm 입력된 데이터를 배열로 가져온다.
		let formData = $("#dlvyUpdateForm").serializeArray();
		//ajax에 데이터로 보내기 위해 json타입으로 변환
		let form = {};		
		$.each(formData, function() {
			form[this.name] = this.value;
		});	
		//ajax에 form 데이터를 보내 배송지를 등록한다. 등록후 dlvyList에 dlvylist 출력
		$("#dlvyList").load("/dlvy/update.do", form);
	});
	
	//배송지 삭제 버튼 이벤트
	$("#dlvySelModal").on("click",".dlvyDeleteBtn", function() {		
		//만약 삭제하려는 배송지가 기본 배송지라서 alert를 띄우고 삭제하지 않는다.
		if($(this).closest(".list-group-item").find(".basicAddr").length == 1) {
			alert("다른 배송지를 기본 배송지로 변경하고 삭제해주세요.");
			//해당 배송지 번호의 배송지를 삭제하고 배송지 리스트로 돌아온다.
		} else {
			let dlvyAddrNo = $(this).closest(".list-group-item").data("dlvyaddrno");			
			$("#dlvyList").load("/dlvy/delete.do?dlvyAddrNo="+dlvyAddrNo);			
		}
	});
	
});
	//배송지 선택시 호출되는 함수
	function dlvySelect($dlvyListItem) {		
		let dlvyAddrNo = $dlvyListItem.data("dlvyaddrno");
		let recipient = $dlvyListItem.find(".recipientModal").text();
		let dlvyName = $dlvyListItem.find(".dlvyNameModal").text();
		let tel = $dlvyListItem.find(".telModal").text();
		let addr = $dlvyListItem.find(".addrModal").text();
		let addrDetail = $dlvyListItem.find(".addrDetailModal").text();
		let postNo = $dlvyListItem.find(".postNoModal").text();
		
		//배송지 정보 출력
		$("#recipientPrint").text(recipient+"("+dlvyName+")");
		$("#telPrint").text(tel);
		$("#addrPrint").text(addr+" "+addrDetail+"("+postNo+")");
		//배송지 정보 input 입력
		$("#dlvyAddrNoInput").val(dlvyAddrNo);
		
		
		$("#dlvySelModal").modal("hide");
	}