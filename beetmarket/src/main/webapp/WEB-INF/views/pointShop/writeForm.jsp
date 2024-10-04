<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="form-group">
	<label for="goodsNameInput">상품 이름:</label> <input type="text"
		class="form-control" id="goodsNameInput">
</div>
<div class="goodsImageDiv">
	<label for="goodsImageInput" class="custom-file-upload"> <i
		class="fas fa-cloud-upload-alt"></i> <span>이미지 업로드</span> <input
		id="goodsImageInput" type="file" accept="image/*"
		style="display: none;">
	</label>
	<div class="text-truncate">
		이미지 이름 : <span class="modalImageNamePrint"></span>
	</div>
</div>
<div class="form-row">
	<div class="form-group col">
		<label for="pointAmountInput">상품 금액:</label> <input type="text"
			class="form-control" id="pointAmountInput"
			oninput="this.value = this.value.replace(/[^0-9]/g, '')">
	</div>
	<div class="form-group col">
		<label for="goodsStockInput">상품 재고:</label> <input type="text"
			class="form-control" id="goodsStockInput"
			oninput="this.value = this.value.replace(/[^0-9]/g, '')">
	</div>
</div>
<div class="form-group">
	<label for="cateInput">카테고리:</label> <select class="form-control"
		id="cateInput">
		<option value="" style="display: none;">카테고리를 선택해주세요.</option>
		<option>쿠폰</option>
		<option>상품권</option>
		<option>음식</option>
	</select>
</div>
<div class="form-group" style="display: none;">
	<label for="discountRateInput">쿠폰 할인률:</label> <input type="text"
		class="form-control" id="discountRateInput"
		oninput="this.value = this.value.replace(/[^0-9]/g, '')" maxlength="3">
</div>
<div class="form-group">
	<label for="goodsGradeInput">상품 등급:</label> <select
		class="form-control" id="goodsGradeInput">
		<option value="" style="display: none;">상품 등급을 선택해주세요.</option>
		<option value="1">브론즈</option>
		<option value="2">골드</option>
		<option value="3">다이아</option>
	</select>
</div>
