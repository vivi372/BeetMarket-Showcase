<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<div class="owl-carousel owl-theme p-2" data-isPassword="${(empty list[0].payPassword)?false:true }">
		<c:forEach items="${list }" var="vo" varStatus="vs">
			<div class="beetCard">
				<div class="payCard rounded-lg ${vo.cardCompany } ${(vs.index==0)?active:'' }" 
					data-beetpayno="${vo.beetpayNo }" data-cardcompany="${vo.cardCompany}">
					<img src="/upload/beetpay/${vo.cardCompany }.png" class="cardImage">
					<span class="cardNumber">${vo.cardNumber }</span>
					<img src="/upload/beetpay/${vo.cardBrand }.png" class="cardBrand">
				</div>
				<select class="form-control mt-2 installmentSelect">
					    <option>일시불</option>
						<c:if test="${vo.cardType == '신용 카드' }">
						    <option value="2개월">2개월 무이자</option>
						    <option value="3개월">3개월 무이자</option>
						    <option>4개월</option>
						    <option>5개월</option>
						    <option>6개월</option>
						    <option>7개월</option>
						    <option>8개월</option>
						    <option>9개월</option>
						    <option>10개월</option>
						    <option>11개월</option>
						    <option>12개월</option>
						</c:if>
				</select>					
			</div>
		</c:forEach>
		<div class="beetCard">
			<div class="payCard rounded-lg writeCard" style="background-color: #f8f9fc !important">
				<span class="cardNumber">
					<button type="button" id="beetpayWriteBtn" class="mx-auto">+</button>
					<br>
					<b>카드 등록하기</b>
				</span>
			</div>
			<select class="form-control mt-2" id="installmentSelect">
				<option style="display: none">비고</option>						
			</select>
		</div>		
	</div>
