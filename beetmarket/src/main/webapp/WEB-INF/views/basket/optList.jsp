<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
select:disabled {
	background-color: white !important;
}
</style>


<script type="text/javascript">
$(function() {
	$("#itemGoodsNo").val(goodsNo);
	
	const list = [
        <c:forEach var="item" items="${list.getOptNames()}">
        	"${item}"<c:if test="${!status.last}">,</c:if>
    	</c:forEach>
	];	
	jsonList = ${jsonList};
	
	let optList = getOptList(0,list,'',jsonList);
	let optListArray = Array.from(optList);
	//console.log(typeof optListArray[0]);
	if(typeof optListArray[0] == 'object')			
		$("#optSelect"+1).addClass("opt");
 	createOptTag(optList,"#optSelect"+1);
 	
 	$("#optSelect1").nextAll().hide(); 
 	
	$(".optSelect").change(function() {
		if(!$(this).hasClass("opt")){
			//선택된 값 가져오기
			let selectValue = "";		
			$($(this).prevAll(".optSelect").get().reverse()).each(function() {
				let optSelectValue = $(this).val();
				if(optSelectValue != "undefined" && optSelectValue != ""){
					//console.log(optSelectValue);
					selectValue += $(this).val()+"/";				
				}
			});
			selectValue += $(this).val();
			console.log(selectValue);
			//선택된 select 태그의 순서 가져오기 0부터 시작
			let selectIndex = $(".optSelect").index(this)+1;		
			console.log(selectIndex);
			//현재 선택된 값에 해당하는 다음 옵션 값 가져오기
			let optList = getOptList(selectIndex,list,selectValue,jsonList);	
			//console.log(optList);
			//다음 select 태그만 disabled 제거
			let $nextSelect = $(this).nextAll();		
			//다음 select 태그의 옵션 태그 생성
			$nextSelect.each(function() {			
				$(this).find(".option").remove();
				$(this).hide();			
				$(".optSelect").removeClass("opt");
			});
			let optListArray = Array.from(optList);
			if(typeof optListArray[0] == 'object')			
				$(this).next().addClass("opt");
			$(this).next().show();
			createOptTag(optList,"#optSelect"+(Number(selectIndex)+1));
		}
		
	});
 	
	

});

function getOptList(index,list,preOptValue,jsonList) {
	let optList = new Set();
	
	if(index == 0){
		list.forEach(function(item) {
			let parts = item.split('/');
			if(parts[index+1]===undefined) {
				jsonItem = getJsonListData(item,jsonList);					
				optList.add(jsonItem);
			} else
				optList.add(parts[index]);			
		});
	} else {
		list.forEach(function(item) {
			let parts = item.split('/');
			let jsonItem = "";			
			if(parts.slice(0,index).join('/') == preOptValue) {							
				if(parts[index+1]===undefined) {
					jsonItem = getJsonListData(item,jsonList);					
					optList.add(jsonItem);
				} else
					optList.add(parts[index]);
			}
		});
	}
	
	
	return optList;
}



function createOptTag(optList,selectId) {
	//console.log(typeof optList[0]);
	let OptSelectTag = ``;
	optList.forEach(function(opt) {
		if(typeof opt === "object") {
			let optName = opt.optNames[opt.optNames.length-1];
			OptSelectTag += 
				`<option value="\${opt.optNo }"
					data-optPrice="\${opt.optPrice+opt.goodsPrice}" class="optList option"
					data-optName="\${opt.optName }">\${optName }
					(+\${opt.optPrice })</option>`;
		} else {
			OptSelectTag += 
				`<option class="option" value="\${opt }">\${opt }</option>`;
		}
	});
	
	$(selectId).append(OptSelectTag);
}

function getJsonListData(item,jsonList) {
	let result;
	//console.log(jsonList);
	jsonList.forEach(function(jsonItem,i) {		
		if(item == jsonItem.optName) {			
			result = jsonItem;
		}
	});
	return result;
}




</script>

<div id="jsonList" style="display: none;">${jsonList }</div>

<!-- 리스트가 비어있지 않을 때 옵션을 선택할 수 있는 드롭다운 메뉴를 생성 -->
<c:if test="${!empty list[0].optNo }">
	<c:forEach begin="1" end="${list.getMaxOptSize() }" varStatus="vs">
		<select class="form-control optSelect" id="optSelect${vs.index }">
			<!-- 기본 옵션 항목, 초기 선택 상태이며 표시되지 않음 -->
			<option value="" selected style="display: none;">옵션</option>
		</select>
	</c:forEach>
</c:if>

<!-- 리스트가 비어 있을 때, 수량을 선택할 수 있는 UI를 생성 -->
<c:if test="${empty list[0].optNo }">
	<div class="optListItem">
		<!-- 옵션 번호, 옵션 이름 및 관련 주문을 숨김 필드로 설정 -->
		<input type="hidden" id="itemGoodsNo" name="goodsNo">	
		<input type="hidden" name="optNo" value="0"> 		

		<div class="optPrice" style="display: none"></div>
		<!-- 수량 선택 인터페이스 (숫자 증가/감소 버튼과 입력 필드) -->
		<div class="input-group mb-3 optAmount" style="width: 150px;">
			<div class="input-group-prepend">
				<!-- 마이너스 버튼 -->
				<button class="btn btn-primary minusBtn" type="button">
					<i class="fa fa-minus"></i>
				</button>
			</div>
			<input type="text" name="amount" class="amount form-control"
				value="0">
			<div class="input-group-append">
				<!-- 플러스 버튼 -->
				<button class="btn btn-primary plusBtn" type="button">
					<i class="fa fa-plus"></i>
				</button>
			</div>
		</div>
	</div>
</c:if>
