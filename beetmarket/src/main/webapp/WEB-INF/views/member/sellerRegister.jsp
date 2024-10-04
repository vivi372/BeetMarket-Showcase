<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 신청</title>
</head>
<body>
<div class="container" style="width: 800px;">
 <h2>BitMarket</h2>
 <form action="seller.do" method="post">
	<div class="form-group">
      <label for="pw">기본 배송비 지정</label>
      <input id="merchant_delivery" name="merchant_delivery" required 
       class="form-control" maxlength="5" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
       placeholder="기본 배송비 지정"
      >
	</div>
	<div class="form-group">
      <label for="pw">무료 배송 최소 금액</label>
      <input id="free_ship_limit" name="free_ship_limit" required 
       class="form-control" maxlength="6" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"
       placeholder="무료 배송 최소 금액"
      >
	</div>
	<div class="form-group">
      <label for="pw">상점이름</label>
      <input id="store_name" name="store_name" required 
       class="form-control" maxlength="10" 
       placeholder="상점이름"
      >
	</div>
	<button class="btn btn-dark" >신청하기</button>
 </form>
</div>
</body>
</html>