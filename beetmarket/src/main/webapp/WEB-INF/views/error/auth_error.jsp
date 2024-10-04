<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- sitemesh 미적요 페이지 - 웹 라이브러리 없음 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 권한 오류</title>
<!-- Bootstrap 4 + jquery 라이브러리 등록 - CDN 방식 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- icon 라이브러리 등록 Awesome4 / google-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<style type="text/css">
	#errorDiv > .row {
		padding: 10px;
		border-top: 1px dotted #ccc;
		margin: 0 10px;
	}
	
</style>
<script type="text/javascript">

$(function() {
	let uri = window.location.pathname;
	//alert(uri);
	$("#uri").text(uri);
});
</script>
</head>
<body>
<div class="container">
	<div class="card mb-2">
  		<div class="card-header"><h3><i class="material-icons">error_outline</i> 페이지 권한 오류</h3></div>
  		<div class="card-body" id="errorDiv">  			
  			<div class="row">
  				<div class="col-md-3"> 요청 uri</div>
  				<div class="col-md-9">
  					<span id="uri"></span>
  				</div>
  			</div>
  			<div class="row">
  				<div class="col-md-3">오류 메세지</div>
  				<div class="col-md-9">
  					이 페이지에 접근하려면 더 높은 권한이 필요합니다.					
  				</div>
  			</div>
  			<div class="row">
  				<div class="col-md-3">조치 사항</div>
  				<div class="col-md-9">
  					요청하신 페이지의 주소를 확인하시고 다시 시도해주세요.
  				</div>
  			</div>  			
			<div class="text-center" style="border-top: 1px dotted #ccc;">
				<img alt="오류 이미지" id="errorImg">
			</div>
  			
  		</div>
  		<div class="card-footer">
  			<a href="/" class="btn btn-dark">메인으로 가기</a>
  		</div>
	</div>	
</div>
</body>
</html>