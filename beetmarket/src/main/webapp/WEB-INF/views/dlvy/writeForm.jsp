<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.custom-control-input:checked ~ .custom-control-label::before {
    background-color: #02c75b; /* 중간 회색 */
    border-color: #02c75b; /* 중간 회색 */
} 
.backBtn {
	cursor: pointer;
}
</style>


<script type="text/javascript" src="/js/BoardInputUtil.js"></script>
<script type="text/javascript" src="/js/order/telInput.js"></script>
<script>
$(function() {
	$("#selfInput").hide();
	$("#dlvyName").change(function() {		
		if($(this).val()=="직접 입력") {
			$("#selfInput").show();
			$(this).removeAttr("name");
			$("#selfInput").attr("name","dlvyName");
		}
		else {
			$("#selfInput").hide();			
			$("#selfInput").removeAttr("name");
			$(this).attr("name","dlvyName");
		}
			
	});
	$("#dlvyWriteFormBtn").click(function() {		
		if($("#dlvyName").val() == '직접 입력') {
			if(isEmpty("#selfInput","배송지 별명",true))
				return false;
		}
		if(isEmpty("#sample4_postcode","우편 번호",true)||isEmpty("#recipient","받는 사람",true))
			return false;
		if(reg("#modalPhone","올바른 번호 형식이 아닙니다.",/^(010-\d{4}-\d{4}|0\d{1,2}-\d{3,4}-\d{4})$/)){
			return false;
		}
	});
	
	//뒤로 가기 버튼 클릭 이벤트
	$(".backBtn").click(function() {
		$("#dlvyList").load("/dlvy/list.do");
	});
});
</script>

<form method="post" id="dlvyWriteForm">
	<i class="material-icons float-right backBtn">arrow_back</i>
	<jsp:include page="postApi.jsp"></jsp:include>
	<div class="form-group mt-3">
		<label for="dlvyName">배송지 별명</label><br>
		<select class="w-50 mb-2" id="dlvyName" name="dlvyName">
		    <option>집</option>
		    <option>회사</option>
		    <option>학교</option>
		    <option>친구</option>
		    <option>가족</option>
		    <option>직접 입력</option>		    
  		</select>
		<input type="text" id="selfInput" maxlength="10" placeholder="배송지 별명을 입력해주세요">
	</div>
	<div class="form-group">
		<label for="recipient">받는 사람</label> 
		<input type="text" id="recipient" maxlength="10" name="recipient">
	</div>
	<div class="form-group">
		<label for="modalPhone">연락처</label> 
		<input type="text" class="txtPhone" id="modalPhone" name="tel">
	</div>
	<div class="custom-control custom-switch mb-3" id="basicDiv">
	    <input type="checkbox" class="custom-control-input" id="basic" name="basic" value="1">
	    <label class="custom-control-label" for="basic">기본 배송지로 설정</label>
  	</div>
  	<div class="text-right">
		<button type="button" id="dlvyWriteFormBtn" class="btn btn-primary">등록</button>	
	</div>
</form>