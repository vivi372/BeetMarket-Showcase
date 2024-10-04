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



</details>

<details>
  
<summary>주문관리</summary>


</details>

# 주요 기능

+ ajax를 사용해 비동기 방식으로 배송지 관련 CRUD를 구현해 결제시 입력한 데이터를 유지시킨 상태로 배송지 등록,수정,삭제가 가능
+ 책 같은 경우 ISBN이 존재하고 티켓은 관람일이 필요하기 때문에 주문 데이터 출력시 다른 정보를 출력이 가능
+ 상품의 옵션이 존재할 경우 여러개의 옵션이 선택이 가능

# 중요 코드

```
//basketOpt 테이블의 데이터를 수정하는 퀴리문을 가져오는 메서드
	private String getOptUpdateSql(List<OptVO> optList) {
		//옵션 테이블에서 수정할 장바구니의 번호를 가져온다.
		long basketNo = optList.get(0).getBasketNo();
		//MERGE INTO targetTable using(sourceTable) on 조건 WHEN MATCHED THEN update/delete  WHEN NOT MATCHED THEN insert
		//- targetTable과  sourceTable 테이블을 조건을 통해 비교하여 조건에 맞으면 업데이트나 삭제를 진행하고 틀리면 등록한다.
		String sql ="MERGE INTO basketOpt t "
				+ "		USING ( ";
		//가져온 옵션 리스트로 sourceTable 생성
		for(int i=0;i<optList.size();i++) {
			OptVO opt = optList.get(i);
			if(i==0) sql += "select "+(i+1)+" rnum, "+opt.getOptNo()+" optNo, "+opt.getAmount()+" amount, "+basketNo+" basketNo from dual ";
			else sql += " union all select "+(i+1)+", "+opt.getOptNo()+", "+opt.getAmount()+", "+basketNo+" from dual ";
		}
		sql +=" ) s "
				//입력된 basketNo인 타겟 테이블의 순서번호가 소스테이블에 존재하면 소스테이블에 데이터를 타켓 테이블에 집어넣고
			+ " ON (s.rnum = (select rnum from(select rownum rnum,basketOptno from basketOpt where basketNo = "+basketNo+") where basketOptno = t.basketOptNo) and t.basketNo = "+basketNo+") "
			+ " WHEN MATCHED THEN "
			+ "    UPDATE SET t.optNo = s.optNo, t.amount = s.amount "
			//존재하지 않으면 소스테이블에 데이터를 basketOpt에서 새로 등록한다.
			+ " WHEN NOT MATCHED THEN "
			+ "    INSERT (basketOptNo, optNo, amount, basketNo) "
			+ "    VALUES (basketOpt_seq.nextval, s.optNo, s.amount, "+basketNo+")";
		
		return sql;
	}

```

장바구니의 옵션 수정시 기존의 테이블의 옵션 데이터와 입력된 옵션 테이블의 행의 수를 비교하여 

입력된 테이블의 행이 더 많으면 그만큼 새로 insert하고 존재하는 행들은 update한다.
