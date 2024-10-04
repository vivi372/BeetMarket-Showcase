<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<script type="text/javascript">
	$(function() { // HTML 문서가 로딩이 다 되면 실행해 주세요.

		// 판매가 계산하는 처리 이벤트
		$("#goodsOriPrice, #goodsDiscount, #goodsDiscRate").keyup(
				function() {
					let goodsOriPrice = 0;
					let goodsDiscount = 0;
					let goodsDiscRate = 0;
					let goodsPrice = 0;
					goodsOriPrice = Number($("#goodsOriPrice").val());
					goodsDiscount = Number($("#goodsDiscount").val());
					goodsDiscRate = Number($("#goodsDiscRate").val());

					goodsPrice = goodsOriPrice - goodsDiscount
							- (goodsOriPrice / 100 * goodsDiscRate);

					$("#goodsPrice").val(goodsPrice);

				});

	});
</script>

</head>
<body>
	<div class="container">
		<h2>상품 수정</h2>
		<form action="update.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">

			<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:p-#,pl-#,pr-#,pt-#,pb-#,px-#,py-#) -->
			<fieldset class="border p-4">
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[상품 기본 정보 입력]</b>
				</legend>
				<!-- 상품 기본 정보 입력 시작 -->
				<div class="form-group">
					<label for="goodsNo">상품번호</label>
					<input class="form-control" name="goodsNo" id="goodsNo" required readonly value="${vo.goodsNo }">
				</div>
				<div class="form-group">
					<label for="goodsName">상품명</label>
					<input class="form-control" name="goodsName" id="goodsName" required value="${vo.goodsName }">
				</div>
				<div class="form-group">
					<label for="goodsOriPrice">정가(원)</label>
					<input class="form-control" name="goodsOriPrice" id="goodsOriPrice" required value="${vo.goodsOriPrice }">
				</div>
				<div class="form-group">
					<label for="goodsDiscount">고정할인가(원)</label>
					<input class="form-control" name="goodsDiscount" id="goodsDiscount" required value="${vo.goodsDiscount }">
				</div>
				<div class="form-group">
					<label for="goodsDiscRate">할인율(%)</label>
					<input class="form-control" name="goodsDiscRate" id="goodsDiscRate" required value="${vo.goodsDiscRate }">
				</div>
				<div class="form-group">
					<label for="goodsPrice">판매가(원) / 정가, 할인가, 할인율 입력시 자동 계산됩니다.</label>
					<input class="form-control" name="goodsPrice" id="goodsPrice" required readonly value="${vo.goodsPrice }">
				</div>
				<div class="form-group">
					<label for="goodsSavings">고정적립금(원) = 미지정시 0원 / 기본 적립률 1% 고정, 회원 등급에 따라 변동합니다.</label>
					<input class="form-control" name="goodsSavings" id="goodsSavings" required value="${vo.goodsSavings }">
				</div>
				<div class="form-group">
					<label for="goodsContent">상세 설명</label>
					<textarea class="form-control" name="goodsContent" id="goodsContent" rows="7">"${vo.goodsContent }"</textarea>
				</div>
				<!-- 상품 기본 정보 입력 끝 -->
			</fieldset>

			<button type="submit" class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-warning">새로입력</button>
			<button type="button" class="cancelBtn btn btn-success">취소</button>
		</form>
	</div>
</body>
</html>