<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좋아요 리스트</title>
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

	});
</script>
</head>
<body>
	<div class="container">
		<h2>좋아요 내역</h2>
		<c:if test="${empty likeList }">
			<div class="jumbotron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty likeList }">
			<div class="container">
				<table class="table">
					<thead>
						<tr>
							<th>프로필</th>
							<th>번호</th>
							<th>카테고리명</th>
							<th>상품명</th>
							<th>판매가(원)</th>
							<th>판매처</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${!empty likeList }">
							<c:forEach items="${likeList }" var="vo" varStatus="vs">
								<c:if test="${vs.index != 0 && vs.index%1 == 0 }">
                       				 ${"</tr>"}
                       				 ${"<tr>"}
                   				 </c:if>
								<tr class="dateRow" onclick="rowClickHandler(${vo.goodsNo})">
									<td>
										<img src="${vo.goodsMainImage }" alt="상품 이미지" style="width: 100px; height: auto;">
									</td>
									<td>${vo.goodsNo }</td>
									<td>${vo.categoryName }</td>
									<td>${vo.goodsName }</td>
									<td>${vo.goodsPrice }</td>
									<td>${vo.goodsStatusName }</td>
									<td>${vo.store_name }</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>

		</c:if>
	</div>
</body>
</html>