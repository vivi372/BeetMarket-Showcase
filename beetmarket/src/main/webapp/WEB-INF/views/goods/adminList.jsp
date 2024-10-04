<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리스트</title>
<style type="text/css">
/* 이곳을 주석입니다. Ctrl + Shift + C로 자동 주석 가능. 그러나 푸는 건 안된다.
	선택자 {스타일 항목 : 스타일 값;스타일 항목 : 스타일 값;...}
	기본 선택자 : a - a tag, .a - a라는 클래스(여러개), #a - a라는 아이디(한개)
	다수 선택자 : ","로 선택. a, #a : a tag와 a라는 아이디
	상태 선택자 : ":". ":hover" - 마우스가 올라갔을 때.
				 "a:hover" - a tag 위에 마우스가 올라갔을 때
	선택의 상속 : a .data - a tag 안에 data class의 태그를 찾는다.
 */
.dataRow:hover {
	opacity: 70%; /* 투명도 */
	cursor: pointer;
}

/* 테이블 행에 마우스가 올려졌을 때 배경색 변경 및 커서 변경 */
tr:hover {
	background-color: #f0f0f0; /* 배경색을 원하는 색상으로 변경 */
	cursor: pointer; /* 마우스를 올리면 커서를 손 모양으로 변경 */
}

.goodsCheckbox {
	transform: scale(2); /* 크기를 2배로 확대 */
	margin-right: 10px; /* 체크박스와 텍스트 간의 간격 조절 */
}
</style>

<script type="text/javascript">
function rowClickHandler(goodsNo) {
    // goodsNo를 이용하여 view 페이지로 이동
    location.href = "/goods/view.do?goodsNo=" + goodsNo + "&inc=0";
}
	$(function() {

		// 제목 해당 태그 중 제일 높은 것을 이용하여 모두 맞추기
		// console.log($(".title"));
		let titleHeights = [];

		$(".title").each(function(idx, title) {
			console.log($(title).height());
			titleHeights.push($(title).height());
		});
		console.log(titleHeights.join(", "));

		let maxTitleHeight = Math.max.apply(null, titleHeights);
		console.log(maxTitleHeight);

		$(".title").height(maxTitleHeight);

		// 이벤트 처리
		$(".dataRow")
				.click(
						function() {
							// alert("click");
							// 글번호 필요 - 수집
							let goodsNo = $(this).find(".goodsNo").text();
							console.log("goodsNo = " + goodsNo);
							location = "view.do?goodsNo=" + goodsNo + "&inc=1"
									+ "&${pageObject.pageQuery}"
									+ "&${searchVO.query}";
						});

		// 대분류를 바꾸면 중분류도 바꿔야한다.
		$("#cateHighNo").change(
				function() {
					let cateHighNo = $(this).val();
					if (cateHighNo != 0)
						// 바로 중분류의 데이터를 세팅한다.
						$("#cateMidNo").load(
								"/ajax/getMidList.do?cateHighNo=" + cateHighNo
										+ "&mode=l");
				});

		// 중분류를 바꾸면 소분류도 바꿔야한다.
		$("#cateMidNo").change(
				function() {
					// 바로 소분류의 데이터를 세팅한다.
					$("#cateLowNo").load(
							"/ajax/getLowList.do?cateHighNo="
									+ $("#cateHighNo").val() + "&cateMidNo="
									+ $("#cateMidNo").val() + "&mode=l");
				});

		// 중분류를 바꾸면 소분류도 바꿔야한다.
		$("#cateLowNo").change(function() {
			$("#searchForm").submit();
		});

		// perPageNum 처리
		$("#perPageNum").change(function() {
			// page는 1페이지 + 검색 데이터를 전부 보낸다.
			$("#searchForm").submit();
		});

		// 검색 버튼
		$("#searchBtn").click(
				function() {
					// 검색 내용이 없으면 검색으로 가지 않는다.
					if ($("#cateHighNo").val() == 0
							&& $("#goodsName").val().trim() == "") {
						return false;
					}

				});

		// 검색 데이터 세팅
		$("#cateHighNo").val(
				"${(empty searchVO.cateHighNo)?0:searchVO.cateHighNo}");
		$("#cateMidNo").val(
				"${(empty searchVO.cateMidNo)?0:searchVO.cateMidNo}");
		$("#cateLowNo").val(
				"${(empty searchVO.cateLowNo)?0:searchVO.cateLowNo}");
		$("#goodsName").val("${searchVO.goodsName}");

	});
	
	$(document).ready(function() {

		 // tr 클릭 시 페이지 이동 처리
	    $(".dataRow").click(function() {
	        let goodsNo = $(this).find(".goodsNo").text();
	        rowClickHandler(goodsNo);
	    });

	    // 체크박스 클릭 시 이벤트 전파 중지
	    $(".goodsCheckbox").click(function(event) {
	        event.stopPropagation();  // 클릭 이벤트가 tr로 전파되지 않게 함
	    });
		
	    // 상태 변경 버튼 클릭 시 이벤트
	    $("#updateStatusBtn").click(function() {
	        // 체크된 항목들의 goodsNo 수집
	        let selectedGoodsNos = [];
	        $(".goodsCheckbox:checked").each(function() {
	            selectedGoodsNos.push($(this).val());
	        });

	        if (selectedGoodsNos.length === 0) {
	            alert("선택된 상품이 없습니다.");
	            return;
	        }

	        // 드롭다운에서 선택된 상태 가져오기
	        let selectedStatusNo = $("#statusDropdown").val();

	        // AJAX로 서버에 상태 변경 요청
	        $.ajax({
	            type: "POST",
	            url: "/ajax/getStatusUpdate.do",
	            data: {
	                goodsNos: selectedGoodsNos.join(","),  // 선택된 goodsNo들을 콤마로 구분하여 전송
	                goodsStatusNo: selectedStatusNo
	            },
	            success: function(response) {
	                if (response === "Success") {
	                    alert("상태가 성공적으로 변경되었습니다.");
	                    location.reload();  // 페이지 새로고침
	                } else {
	                    alert("상태 변경에 실패했습니다.");
	                }
	            },
	            error: function() {
	                alert("서버 오류가 발생했습니다.");
	            }
	        });
	    });

	});
</script>

</head>
<body>
	<div class="container">
		<h2>상품 리스트</h2>
		<form action="adminList.do" id="searchForm">
			<input name="page" value="1" type="hidden">
			<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden">
			<!-- 검색 항목 처리 -->
			<!-- p-# : padding 상대적인 설정 -->
			<fieldset class="border pt-1 pb-2 px-3 mb-2">
				<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[상품 검색]</b>
				</legend>
				<div class="row">
					<div class="col-md-12 form-inline">
						<div class="form-group mb-2">
							<label for="cateHighNo">대분류</label>
							<select class="form-control" name="cateHighNo" id="cateHighNo" style="margin: 0 10px;">
								<option value="0">대분류 선택</option>
								<c:forEach items="${bigList }" var="vo">
									<option value="${vo.cateHighNo }">${vo.categoryName }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group mb-2">
							<label for="cateMidNo">중분류</label>
							<select class="form-control" name="cateMidNo" id="cateMidNo" style="margin: 0 10px;">
								<option value="0">중분류 선택</option>
								<!-- ajax를 이용한 중분류 option 로딩하기 -->
							</select>
						</div>
						<div class="form-group mb-2">
							<label for="cateLowNo">소분류</label>
							<select class="form-control" name="cateLowNo" id="cateLowNo" style="margin: 0 10px;">
								<option value="0">소분류 선택</option>
								<!-- ajax를 이용한 중분류 option 로딩하기 -->
							</select>
						</div>
						<div class="form-group mb-2">
							<label for="goodsName">상품명</label>
							<input class="form-control mx-3" name="goodsName" id="goodsName">
						</div>
						<input type="hidden" name="desc" id="desc">
					</div>
					<!-- col-md-12의 끝 : 검색 -->
				</div>
			</fieldset>
			<div class="row">
				<div class="col-md-12">
					<!-- 너비를 조정하기 위한 div 추가. float-right : 오른쪽 정렬 -->
					<div style="width: 200px;" class="float-right">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">Rows/Page</span>
							</div>
							<select id="perPageNum" name="perPageNum" class="form-control">
								<option>6</option>
								<option>9</option>
								<option>12</option>
								<option>15</option>
							</select>
						</div>
					</div>

					<!-- 드롭다운 추가 -->
					<div style="width: 400px;" class="float-right mr-2">
						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<span class="input-group-text">상태 변경</span>
							</div>
							<select id="statusDropdown" class="form-control">
								<option value="1">등록대기</option>
								<option value="2">판매중</option>
								<option value="3">입고예정</option>
								<option value="4">수정확인</option>
								<option value="5">수정지시</option>
								<option value="6">판매중지신청</option>
								<option value="7">판매중지</option>
								<option value="9">기타</option>
							</select>
							<button class="btn btn-primary ml-2" id="updateStatusBtn">상태 변경</button>
						</div>
					</div>

					<!-- col-md-4의 끝 : 한페이지당 표시 데이터 개수 -->
				</div>
		</form>
		<c:if test="${empty adminList }">
			<div class="jumbotron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty adminList }">
			<div class="container">
				<table class="table">
					<thead>
						<tr>
							<th>체크</th>
							<th>번호</th>
							<th>카테고리명</th>
							<th>상품명</th>
							<th>원가(원)</th>
							<th>고정할인가(원)</th>
							<th>할인율(%)</th>
							<th>판매가(원)</th>
							<th>고정적립(포인트)</th>
							<th>판매자ID</th>
							<th>쇼핑몰명</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty adminList }">
							<c:forEach items="${adminList }" var="vo" varStatus="vs">
								<c:if test="${vs.index != 0 && vs.index%1 == 0 }">
									${"</tr>"}
									${"<tr>"}
								</c:if>
								<tr class="dateRow" onclick="rowClickHandler(${vo.goodsNo})">
									<td>
										<input type="checkbox" class="goodsCheckbox" value="${vo.goodsNo}">
									</td>
									<td>${vo.goodsNo }</td>
									<td>${vo.categoryName }</td>
									<td>${vo.goodsName }</td>
									<td>${vo.goodsOriPrice }</td>
									<td>${vo.goodsDiscount }</td>
									<td>${vo.goodsDiscRate }</td>
									<td>${vo.goodsPrice }</td>
									<td>${vo.goodsSavings }</td>
									<td>${vo.id }</td>
									<td>${vo.store_name }</td>
									<td>${vo.goodsStatusName }</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>

			<!-- 페이지 네이션 처리 -->
			<div>
				<pageNav:pageNav listURI="adminList.do" pageObject="${pageObject }" />
			</div>

		</c:if>
	</div>
</body>
</html>