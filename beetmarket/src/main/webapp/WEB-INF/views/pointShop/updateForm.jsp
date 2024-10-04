<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Nav tabs -->
<ul class="nav nav-tabs">
	<li class="nav-item"><a class="nav-link active" data-toggle="tab"
		href="#updateMenu">상품 수정</a></li>
	<li class="nav-item"><a class="nav-link" data-toggle="tab"
		href="#stockUpdateMenu">재고 수정</a></li>
</ul>


<div class="tab-content">
	<div id="updateMenu" class="container tab-pane active mt-2">
		<input type="hidden" id="goodsIdUpdate">
		<div class="form-group">
			<label for="goodsNameUpdate">상품 이름:</label> <input type="text"
				class="form-control" id="goodsNameUpdate">
		</div>
		<div class="custom-control custom-switch">
    		<input type="checkbox" class="custom-control-input" id="imageCheckBox">
    		<label class="custom-control-label" for="imageCheckBox">상품 이미지 수정</label>
  		</div>
  		
		
		<div class="goodsImageDiv">
			<label for="goodsImageUpdate" class="custom-file-upload"> <i
				class="fas fa-cloud-upload-alt"></i> <span>이미지 업로드</span> <input
				id="goodsImageUpdate" type="file" accept="image/*"
				style="display: none;">
			</label>
			<div class="text-truncate">
				이미지 이름 : <span class="modalImageNamePrint"></span>
			</div>
	  		<input id="imageDeleteFile" type="hidden">
		</div>
		<div class="form-group">
			<label for="pointAmountUpdate">상품 금액:</label> <input type="text"
				class="form-control" id="pointAmountUpdate"
				oninput="this.value = this.value.replace(/[^0-9]/g, '')">
		</div>
			
		
		<div class="form-group">
			<label for="cateUpdate">카테고리:</label> <select class="form-control"
				id="cateUpdate">
				<option value="" style="display: none;">카테고리를 선택해주세요.</option>
				<option>쿠폰</option>
				<option>상품권</option>
				<option>음식</option>
			</select>
		</div>
		<div class="form-group" style="display: none;">
			<label for="discountRateUpdate">쿠폰 할인률:</label> <input type="text"
				class="form-control" id="discountRateUpdate"
				oninput="this.value = this.value.replace(/[^0-9]/g, '')"
				maxlength="3">
		</div>
		<div class="form-group">
			<label for="goodsGradeUpdate">상품 등급:</label> <select
				class="form-control" id="goodsGradeUpdate">
				<option value="" style="display: none;">상품 등급을 선택해주세요.</option>
				<option value="1">브론즈</option>
				<option value="2">골드</option>
				<option value="3">다이아</option>
			</select>
		</div>
	</div>
	
	<div id="stockUpdateMenu" class="container tab-pane fade mt-2">	
		<div class="media shadow-sm p-4 my-3">
			<img src="" class="mr-3 mt-3 img-thumbnail" id="goodsImageStock" style="width:60px;">
			<div class="media-body">
				<h5 id="goodsNameStock"></h5>
				현재 재고:<span id="currentStock"></span>
			</div>
		</div>
		
		<label for="goodsStockUpdate">재고:</label>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<button class="btn btn-primary minusBtn" type="button">
					<i class="fa fa-minus"></i>
				</button>
			</div>
			<input type="text"
			class="form-control" id="goodsStockUpdate" style="text-align: center;"
			oninput="this.value = this.value.replace(/[^0-9]/g, '')">
			<div class="input-group-append">
				<button class="btn btn-primary plusBtn" type="button">
					<i class="fa fa-plus"></i>
				</button>
			</div>
		</div> 
	</div>
	
</div>


