<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>

<script type="text/javascript">
	$(function() { // HTML 문서가 로딩이 다 되면 실행해 주세요.

		/// -------------- 이벤트(동작) 처리 --------------
		/// 대분류를 바꾸면 중분류도 바꿔야한다.
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

		let appendImageTag = "";
		appendImageTag += "<div class=\"input-group mb-3\" id=\"imageFilesDiv\">";
		appendImageTag += "<input class=\"form-control imageFiles\" type=\"file\" name=\"imageFiles\">";
		appendImageTag += "<div class=\"input-group-append\">";
		appendImageTag += "	<button type=\"button\" class=\"btn btn-danger removeImageBtn\">";
		appendImageTag += "		<i class=\"fa fa-close\"></i>";
		appendImageTag += "	</button>";
		appendImageTag += "</div>";
		appendImageTag += "</div>";

		let imageCnt = 1;

		// 첨부 이미지 추가 처리
		$("#addImageBtn").click(function() {
			// alert("이미지 추가");
			// alert(appendImageTag);
			if (imageCnt >= 5) {
				alert("첨부 이미지는 최대 5개까지만 가능합니다.");
				return false;
			}
			$("#imageFieldSet").append(appendImageTag);
			imageCnt++;
		});

		// 첨부 이미지 제거 처리
		$("#imageFieldSet").on("click", ".removeImageBtn", function() {
			$(this).closest(".input-group").remove();
			imageCnt--;
		});

		let appendOptionTag = "";
		appendOptionTag += "<div class=\"input-group mb-3\" >";
		appendOptionTag += "<input class=\"form-control option_name\" name=\"option_names\">";
		appendOptionTag += "<div class=\"input-group-append\">";
		appendOptionTag += "	<button type=\"button\" class=\"btn btn-danger removeOptionBtn\">";
		appendOptionTag += "		<i class=\"fa fa-close\"></i>";
		appendOptionTag += "	</button>";
		appendOptionTag += "</div>";
		appendOptionTag += "</div>";

		let optionCnt = 1;

		// 옵션 추가 처리
		$("#addOptionBtn").click(function() {
			// alert("옵션 추가");
			if (optionCnt >= 20) {
				alert("상품의 옵션은 최대 20개까지만 가능합니다.");
				return false;
			}
			$("#optionFieldSet").append(appendOptionTag);
			optionCnt++;
		});

		// 옵션 제거 처리
		$("#optionFieldSet").on("click", ".removeOptionBtn", function() {
			$(this).closest(".input-group").remove();
			optionCnt--;
		});

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
		<h2>상품 등록</h2>
		<form action="write.do" method="post" enctype="multipart/form-data">
			<input type="hidden" name="perPageNum" value="${param.perPageNum }">

			<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:p-#,pl-#,pr-#,pt-#,pb-#,px-#,py-#) -->
			<fieldset class="border p-4">
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[상품 기본 정보 입력]</b>
				</legend>
				<!-- 상품 기본 정보 입력 시작 -->
				<div class="form-inline">
					<div class="form-group">
						<label for="cateHighNo">대분류</label>
						<select class="form-control" name="cateHighNo" id="cateHighNo" style="margin: 0 10px;">
							<option value="0">대분류 선택</option>
							<c:forEach items="${bigList }" var="vo">
								<option value="${vo.cateHighNo }">${vo.categoryName }</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="cateMidNo">중분류</label>
						<select class="form-control" name="cateMidNo" id="cateMidNo" style="margin: 0 10px;">
							<!-- ajax를 이용한 중분류 option 로딩하기 -->
						</select>
					</div>
					<div class="form-group">
						<label for="cateLowNo">소분류</label>
						<select class="form-control" name="cateLowNo" id="cateLowNo" style="margin: 0 10px;">
							<!-- ajax를 이용한 중분류 option 로딩하기 -->
						</select>
					</div>
				</div>
				<div class="form-group">
					<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
					<label for="imageFile">대표 이미지</label>
					<input class="form-control" name="imageFile" id="imageFile" required type="file">
				</div>
				<div class="form-group">
					<label for="goodsName">상품명</label>
					<input class="form-control" name="goodsName" id="goodsName" required>
				</div>
				<div class="form-group">
					<label for="goodsOriPrice">정가(원)</label>
					<input class="form-control" name="goodsOriPrice" id="goodsOriPrice" required>
				</div>
				<div class="form-group">
					<label for="goodsDiscount">고정할인가(원)</label>
					<input class="form-control" name="goodsDiscount" id="goodsDiscount" required>
				</div>
				<div class="form-group">
					<label for="goodsDiscRate">할인율(%)</label>
					<input class="form-control" name="goodsDiscRate" id="goodsDiscRate" required>
				</div>
				<div class="form-group">
					<label for="goodsPrice">판매가(원) / 정가, 할인가, 할인율 입력시 자동 계산됩니다.</label>
					<input class="form-control" name="goodsPrice" id="goodsPrice" required readonly>
				</div>
				<div class="form-group">
					<label for="goodsSavings">고정적립금(원) = 미지정시 0원 / 기본 적립률 1% 고정, 회원 등급에 따라 변동합니다.</label>
					<input class="form-control" name="goodsSavings" id="goodsSavings" required>
				</div>
				<div class="form-group">
					<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
					<label for="detailImageFile">상세 설명 이미지</label>
					<input class="form-control" name="detailImageFile" id="detailImageFile" type="file">
				</div>
				<div class="form-group">
					<label for="goodsContent">상세 설명</label>
					<textarea class="form-control" name="goodsContent" id="goodsContent" rows="7"></textarea>
				</div>
				<div class="form-group">
					<input class="sell_no" type="hidden" value="${login.sell_no }" name="sell_no" id="sell_no">
				</div>

				<!-- 상품 기본 정보 입력 끝 -->
			</fieldset>

			<!-- p-# : padding 상대적인 설정 -->
			<fieldset class="border p-4">
				<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[상품 옵션 정보 입력]</b>
				</legend>

				<fieldset class="border p-4" id="optionFieldSet">
					<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
					<legend class="w-auto px-2">
						<b style="font-size: 14pt;">[옵션]</b>
						<button type="button" id="addOptionBtn" class="btn btn-primary btn-sm">add Option</button>
					</legend>
					<div id="optionDiv">
						<div class="input-group mb-3">
							<input name="goodsOptName" class="form-control" />
						</div>
					</div>
				</fieldset>
			</fieldset>

			<!-- p-# : padding 상대적인 설정 -->
			<fieldset class="border p-4" id="imageFieldSet">
				<!-- px-# : padding 왼쪽 오른쪽 상대적인 설정 (참고:pl-#,pr-#,pt-#,pb-#,py-#) -->
				<legend class="w-auto px-2">
					<b style="font-size: 14pt;">[상품 첨부 이미지 입력]</b>
					<button type="button" id="addImageBtn" class="btn btn-primary btn-sm">add Image</button>
				</legend>
				<div class="input-group mb-3">
					<!-- VO객체의 프로퍼티와 이름이 다르다. 파일 자체이므로 DB에는 이름만 저장 -->
					<input class="form-control imageFiles" type="file" name="imageFiles">
				</div>

			</fieldset>

			<button type="submit" class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-warning">새로입력</button>
			<button type="button" class="cancelBtn btn btn-success">취소</button>
		</form>
	</div>
</body>
</html>