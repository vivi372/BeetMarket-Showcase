<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.custom-control-input:checked ~ .custom-control-label::before {
    background-color: #02c75b; /* 중간 회색 */
    border-color: #02c75b; /* 중간 회색 */
}
.backBtn {
	cursor: pointer;
} 
</style>

<script type="text/javascript" src="/js/order/telInput.js"></script>
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>
<script>
$(function() {
	if(${param.length == 1}) {
		$("#basicDiv").hide();
	}
	if(${vo.dlvyName=='집'||vo.dlvyName=='회사'||vo.dlvyName=='학교'||vo.dlvyName=='친구'||vo.dlvyName=='가족'}){
		$("#selfInput").hide();	
		$("#dlvyName").val('${vo.dlvyName}');
	} else {
		$("#selfInput").show();	
		$("#dlvyName").val("직접 입력");
		$("#selfInput").val('${vo.dlvyName}');
	}
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
	
	$("#dlvyUpdateBtn").click(function() {		
		if(reg("#modalPhone","올바른 번호 형식이 아닙니다.",/^(010-\d{4}-\d{4}|0\d{1,2}-\d{3,4}-\d{4})$/)){
			return false;
		}
		if(isEmpty($("#sample4_postcode"),"우편 번호",true)||isEmpty($("[name='dlvyName']"),"배송지 별명",true)||isEmpty($("#recipient"),"받는 사람",true))
			return false;
	});
	
	//뒤로 가기 버튼 클릭 이벤트
	$(".backBtn").click(function() {
		$("#dlvyList").load("/dlvy/list.do");
	});
});
</script>

<form method="post" id="dlvyUpdateForm">
	<i class="material-icons float-right backBtn">arrow_back</i>
	<jsp:include page="postApi.jsp"></jsp:include>
	<div class="form-group">
		<label for="dlvyName">배송지 별명</label> <br>
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
		<input type="text" id="recipient" name="recipient" maxlength="10" value="${vo.recipient }">
	</div>
	<div class="form-group">
		<label for="phone">연락처</label> 
		<input type="text" class="txtPhone" id="modalPhone" name="tel" value="${vo.tel }">
	</div>
	
	<div class="custom-control custom-switch mb-3" id="basicDiv">
	    <input type="checkbox" class="custom-control-input" ${(vo.basic == 1)?'checked':'' } id="basic" name="basic" value="1">
	    <label class="custom-control-label" for="basic">기본 배송지로 설정</label>
  	</div>
  	
  	<input type="hidden" value="${param.dlvyAddrNo }" name="dlvyAddrNo">
  	<div class="text-right">
		<button type="button" id="dlvyUpdateBtn" class="btn btn-primary">수정</button>	
	</div>
</form>