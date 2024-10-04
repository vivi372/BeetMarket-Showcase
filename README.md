# BeetMarket
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fvivi372%2FBeetMarket-Showcase&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)


<div align="center">
  <img src="readmeAssets/beetmarketLogo.png" width="300" style="">
</div>



# 프로젝트 소개

이 프로젝트는 포트폴리오 목적으로 제작된 각종 상품을 다양한 판매자가 판매하는 가상 오픈 마켓입니다. 

실제 서비스를 염두에 두기보다는, 다양한 기능을 구현하고 풀스택 개발 역량을 보여주기 위해 개발되었습니다.

프로젝트는 Spring과 JSP를 사용하여 프론트엔드와 백엔드를 전반적으로 개발하였으며, 

2024년 9월 11일부터 2024년 9월 30일까지 20일간 진행되었습니다.

# 팀원 소개

+ 팀장(황문성) : 상품 관리 개발
+ PM(안아현) : FAQ / 챗봇 개발
+ PM(안도현) : 공지사항 / 이벤트 개발
+ __PL(박근태) : 장바구니 / 주문관리 / 포인트샵 개발__
+ PL(문상훈) : 모의투자 개발
+ DBA(전희원) : 회원 관리 / 포인트 관리 개발
+ 서기(이이섭) : 리뷰 / 상품QNA 개발

# 개발 환경

| 자원분류 | 자원 이름 |
| :---: | :---: |
| OS | window 10/11 |
| IDE | Eclipse |
| DBSM | Oracle 11g |
| WAS | Tomcat9 |
| JAVA Version | JAVA11 |

# 기술 스택

<div align=center>
  <img src="https://img.shields.io/badge/java-ff1a1a?style=for-the-badge&logo=JAVA&logoColor=white">
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
  <img src="https://img.shields.io/badge/maven-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white">
  <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white">
  <img src="https://img.shields.io/badge/tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
  <img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=white">  
  <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">  
</div>

# 화면 구성

<details>
  
<summary>장바구니</summary>

+ 장바구니 리스트
<img src="readmeAssets/장바구니 리스트.png" width="600" style="">

+ 장바구니 등록
<img src="readmeAssets/장바구니 등록.png" width="600" style="">

</details>

<details>
  
<summary>주문관리</summary>

+ 주문 관리 페이지
<img src="readmeAssets/주문 관리.png" width="600" style="">

+ 주문 등록
<img src="readmeAssets/주문 등록.png" width="600" style="">

</details>

<details>
  
<summary>포인트샵</summary>

+ 포인트샵
<img src="readmeAssets/포인트샵 리스트.png" width="600" style="">

+ 포인트샵 장바구니
<img src="readmeAssets/포인트샵 장바구니.png" width="600" style="">

+ 포인트샵 주문 리스트
<img src="readmeAssets/포인트샵 주문 리스트.png" width="600" style="">

+ 포인트샵 주문 관리 페이지
<img src="readmeAssets/포인트샵 주문 관리.png" width="600" style="">


</details>

# 주요 기능

+ 상품의 적립율과 등급에 따른 적립율을 DB에서 가져와 계산하여 적립율이 달라져도 달라진 적립율로 계산이 가능
+ 카드 간편 결제 시스템에서 BIN API를 이용해 입력한 카드 번호를 기반으로 카드에 대한 정보를 GUI로 출력이 가능
+ 토스 결제 위젯 기반의 결제 시스템 도입

---

+ Ajax와 Modal을 활용해 사이트 어디에서도 페이지 이동없이 포인트샵에 접근이 가능
+ 포인트샵의 상품 리스트와 장바구니에 각각의 스크롤을 위치시켜 서로 독립

# 중요 코드

### 장바구니 다중 옵션 등록

```xml
<insert id="optWrite">  	
  	insert into basketOpt(basketOptNo,goodsoptNo,amount,basketNo)
  		select basketOpt_seq.nextval,goodsoptNo,amount,(select max(basketNo) from basket)
  		from(
  			<trim prefixOverrides="union all">
	  			<foreach collection="list" item="vo">
	  				union all select <if test="vo.optNo != 0">	  					
		  					#{vo.optNo,jdbcType=BIGINT} 
	  					</if>
	  					<if test="vo.optNo == 0">	  					
		  					null
	  					</if>
	  					 goodsoptNo , #{vo.amount} amount from dual
	  			</foreach>
  			</trim>
  		)
</insert>

```

장바구니의 옵션 등록시 다중 등록이 필요하다. 다중 등록을 위해 sql union all과 마이바티스의 foreach를 사용해서 다중 등록을 구현.
또한 상품에 옵션이 없는 경우 null을 입력하되 수량은 입력하여 장바구니에서 수량이 입력되게 구현.

### 카드 간편 결제 출력

```html

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

```

```css

.payCard.active{
    border: 3px solid #03c75a;
}
.payCard.BC{
    background-color: #f5f5f5;
    color: #ffffff;
}
.payCard.HANA{
    background-color: #98ff98;
    color: #ffffff;
}
.payCard.HYUNDAI{
    background-color: #2f4f4f;
    color: #ffffff;
}
.payCard.KB{
    background-color: #f0e68c;
    color: #ffffff;
}
.payCard.LOTTE{
    background-color: #f5deb3;
    color: #000000;
}
.payCard.NH{
    background-color: #add8e6;
    color: #ffffff;
}
.payCard.SAMSUNG{
    background-color: #dcdcdc;
    color: #000000;
}
.payCard.SHINHAN{
    background-color: #87ceeb;
    color: #ffffff;
}
.payCard.WOORI{
    background-color: #40e0d0;
    color: #ffffff;
}

```

간편 결제에 등록된 카드를 출력시 해당 카드의 정보를 가져와 div의 클래스와 이미지의 src에 입력한다.

입력후 css와 업로드 되어있던 이미지를 이용해 카드의 디자인을 정보에 맞게 출력한다. 

### 포인트샵 상품 등록

```js

	//이미지 파일을 가져온다.
	let goodsImageFile = document.getElementById('goodsImageInput').files[0];
	
	
	
	//console.log(goodsImageFile);
	
	//form에 입력된 데이터를 가져와 formData1에 저장
	formData1.append("goodsName",$("#goodsNameInput").val());
	formData1.append("goodsImageFile",goodsImageFile);
	formData1.append("pointAmount",$("#pointAmountInput").val());
	formData1.append("goodsStock",$("#goodsStockInput").val());
	formData1.append("category",$("#cateInput").val());
	formData1.append("shipNo",$("#goodsGradeInput").val());
	formData1.append("discountRate",$("#discountRateInput").val());			
	
	
	let keys = formData1.values();
	for(let i of keys) {
		console.log(i);
	}
	//상품을 등록
	service.write(function(data) {
		alert(data);	
		let goodsName =  $("#pointShopSearch").val();	
		let cate = $(".modal-sidebar .cateActive").data("category");	
		//등록후 리스트 출력
		service.list(showList,goodsName,cate);
		//등록후 모달창 닫기
		$("#goodsModal").modal("hide");
	}
	,formData1);

```

포인트샵에 아작스를 이용해 상품 등록할때 이미지 파일도 함께 업로드해야 한다. 
files[0]을 이용해 input 태그의 이미지를 가져와 FormData에 넣어 아작스를 이용해 서버에 보낸다. 

