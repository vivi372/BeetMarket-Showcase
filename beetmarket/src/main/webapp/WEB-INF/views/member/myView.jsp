<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BeetMarket</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/memberStyle.css">
</head>
<body>
<div class="container">
 <div class="row">
    <div class="col-sm-5 centered-content">
    	<img src="${homeVO.photo }" style="width: 100px; height: 100px;"> &nbsp;&nbsp;&nbsp; ${homeVO.id }님 
    	<a href="updateForm.do" class="btn_1">내정보 수정</a>
    </div>
    <div class="col-sm-5 centered-content1" >
	  <form action="pointList.do">
	  <img src="/upload/image/image.jpg" style="width: 50px; height: 50px;">
	  	<button class="btn_2">${(empty homeVO.point_delta)? 0: homeVO.point_delta} 원&nbsp;&nbsp; <i class="fa fa-angle-right"></i></button>
	  	<hr class="thick-line">
	  	<a href="/goods/likeList.do" class="btn_3"> 좋아요 <i class="fa fa-angle-right"></i></a>
	  	<a href="/event/list.do" class="btn_3"> EVENT <i class="fa fa-angle-right"></i></a>
	  </form>
    </div>
    <div class="centered-content2" style="width: 940px; position: relative;">
  		<div class="nav-links">
        <a href="/basket/list.do"><i class="fa fa-credit-card"></i> 장바구니</a>
        <a href="/order/list.do"><i class="fa fa-cart-plus"></i> 주문배송</a>
        <a href="/member/couponList.do"><i class="fa fa-copyright"></i> 쿠폰리스트</a>
        <c:if test="${homeVO.gradeNo < 5 }">
	        <a href="/member/sellerRegister.do"><i class="fa fa-copyright"></i> 판매자 신청</a>
        </c:if>
        <img src="/upload/image/image.jpg" style="width: 50px; height: 50px; position: absolute; bottom: 10px; right: 10px; z-index: 100;">
    	</div>
  	</div> 
  	<c:if test="${homeVO.gradeNo >= 5 }">
	    <div class="centered-content3" style="width: 940px; position: relative;">
	  		<div class="nav-links">
	        <a href="/order/adminList.do"><i class="fa fa-credit-card"></i> 주문관리</a>
	        <c:if test="${homeVO.gradeNo == 5 }">
	       	 <a href="/goods/sellList.do"><i class="fa fa-cart-plus"></i> 내상품관리</a>
	        </c:if>
	        <c:if test="${homeVO.gradeNo == 9 }">
	        <a href="/goods/adminList.do"><i class="fa fa-cart-plus"></i> 상품관리</a>
	        	<a href="/member/list.do"><i class="fa fa-copyright"></i> 회원관리</a>
	        	<a href="/member/sellerApplication.do"><i class="fa fa-copyright"></i> 판매자승인대기</a>
	        </c:if>
	        <img src="/upload/image/image.jpg" style="width: 50px; height: 50px; position: absolute; bottom: 10px; right: 10px; z-index: 100;">
	    	</div>
	  	</div> 
  	</c:if>
  </div>
  
  
  
</div>	
</body>
</html>