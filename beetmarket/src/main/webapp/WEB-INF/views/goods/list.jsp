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

.imageDiv {
	background: black;
}

.title {
	text-overflow: ellipsis;
	overflow: hidden;
	display: -webkit-box;
	-webkit-box-orient: vertical;
	-webkit-line-clamp: 2;
}
</style>

<script type="text/javascript">
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

		// 이미지 사이즈 조정 5:4
		let imgWidth = $(".imageDiv:first").width();
		let imgHeight = $(".imageDiv:first").height();
		console.log("image width=" + imgWidth + ", height=" + imgHeight)
		// 높이 계산 - 너비는 동일하다. : 이미지와 이미지를 감싸고 있는 div의 높이로 사용
		let height = imgWidth / 5 * 4;
		// 전체 imageDiv의 높이를 조정한다.
		$(".imageDiv").height(height);
		// 이미지 배열로 처리하면 안된다. foreach 사용 - jquery each()
		$(".imageDiv > img").each(function(idx, image) {
			//alert(image);
			//alert(height);
			//alert($(image).height());
			// 이미지가 계산된 높이 보다 크면 줄인다.
			if ($(image).height() > height) {
				let image_width = $(image).width();
				let image_height = $(image).height();
				let width = height / image_height * image_width;

				console.log("chaged image width = " + width);

				// 이미지 높이 줄이기
				$(image).height(height);
				// 이미지 너비 줄이기
				$(image).width(width);

			}
		});

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
			// alert("change perPageNum");
			// page는 1페이지 + 검색 데이터를 전부 보낸다.
			$("#searchForm").submit();
		});

		// 검색 버튼
		$("#searchBtn").click(
				function() {
					//alert("검색");
					// 검색 내용이 없으면 검색으로 가지 않는다.
					if ($("#cateHighNo").val() == 0
							&& $("#goodsName").val().trim() == "") {
						// alert("검색 - 안 넘어감");
						return false;
					}

				});

		$("#rank").click(function() {
			$("#desc").val(1)
			$("#searchForm").submit();

		});
		$("#nomal").click(function() {
			$("#desc").val(0)
			$("#searchForm").submit();
		});

		// 검색 데이터 세팅
		$("#cateHighNo").val(
				"${(empty searchVO.cateHighNo)?0:searchVO.cateHighNo}");
		$("#cateMidNo").val(
				"${(empty searchVO.cateMidNo)?0:searchVO.cateMidNo}");
		$("#cateLowNo").val(
				"${(empty searchVO.cateLowNo)?0:searchVO.cateLowNo}");
		$("#goodsName").val("${searchVO.goodsName}");
		$("#desc").val("${searchVO.desc}");
	});
</script>

</head>
<body>
	<div class="container">
		<h2>상품 리스트</h2>
		<form action="list.do" id="searchForm">
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
						<button class="btn btn-primary" id="rank" type="button">랭킹순</button>
						<button class="btn btn-primary" id="nomal" type="button">일반</button>
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
				</div>
				<!-- col-md-4의 끝 : 한페이지당 표시 데이터 개수 -->
			</div>
		</form>
		<c:if test="${empty list }">
			<div class="jumbotron">
				<h4>데이터가 존재하지 않습니다.</h4>
			</div>
		</c:if>
		<c:if test="${!empty list }">
			<div class="row">
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
				<c:forEach items="${list }" var="vo" varStatus="vs">
					<!-- 줄바꿈처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
					<c:if test="${(vs.index != 0) && (vs.index % 3 == 0) }">
	  			${"</div>"}
	  			${"<div class='row'>"}
	  		</c:if>
					<!-- 데이터 표시 시작 -->
					<div class="col-md-4 dataRow">
						<div class="card" style="width: 100%">
							<div class="imageDiv text-center align-content-center">
								<img class="card-img-top" src="${vo.goodsMainImage }" alt="image">
							</div>
							<div class="card-body">
								<strong class="card-title"> <span class="float-right">${vo.goodsHit }</span> ${vo.goodsName }
								</strong>
								<p class="card-text title">
								<div>
									상품 번호 : <span class="goodsNo">${vo.goodsNo }</span>
								</div>
								<div>
									판매가 :
									<fmt:formatNumber value="${vo.goodsPrice }" />
									원
								</div>
								</p>
							</div>
						</div>
					</div>
					<!-- 데이터 표시 끝 -->
				</c:forEach>
				<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
			</div>

			<!-- 페이지 네이션 처리 -->
			<div>
				<pageNav:pageNav listURI="list.do" pageObject="${pageObject }" />
			</div>

		</c:if>
		<!-- 리스트 데이터 표시의 끝 -->
		<c:if test="${ !empty login && login.sell_no >= 1}">
			<!-- 로그인이 되어있으면 보이게 하자. -->
			<a href="writeForm.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">등록</a>
		</c:if>
	</div>
</body>
</html>