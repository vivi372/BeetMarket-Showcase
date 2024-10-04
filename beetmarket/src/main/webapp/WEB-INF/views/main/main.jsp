<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Main</title>
<style>
    .carousel-item img {
        height: 500px; /* 이미지의 높이 조절 */
    }

    .carousel-caption {
        background-color: rgba(0, 0, 0, 0.5); /* 배경 색상 */
        padding: 10px;
    }
    
    /* 기본 스타일 */
body {
    font-family: Arial, sans-serif;
    background-color: #f5f5f5;
    
}

/* 공지사항 컨테이너 스타일 */
.notice-container {
    max-width: 600px; /* 컨테이너 최대 너비 */
    margin-right: 0 auto; /* 가운데 정렬 */
    background: #ffffff;
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

/* 공지사항 제목 스타일 */
.notice-container h3 {
    margin-top: 0;
    border-bottom: 2px solid #03c75a;
    padding-bottom: 10px;
    color: #333;
}

/* 태그 스타일 */
.notice-tags {
    margin-bottom: 15px;
}

.notice-tags a {
    display: inline-block;
    margin-right: 10px;
    text-decoration: none;
    color: #666;
    font-size: 14px;
}

.notice-tags a.active,
.notice-tags a:hover {
    color: #03c75a;
    font-weight: bold;
}

/* 공지사항 리스트 스타일 */
.notice-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.notice-item {
    padding: 10px 0;
    border-bottom: 1px solid #e0e0e0;
}

.notice-item:last-child {
    border-bottom: none; /* 마지막 항목의 하단 경계선 제거 */
}

.notice-item span {
    font-size: 12px;
    color: #888;
}

.notice-item a {
    display: block;
    text-decoration: none;
    color: #333;
    font-size: 16px;
}

.notice-item a:hover {
    color: #03c75a;
}

.notice {
    display: block; /* 혹은 display: none;을 제거 */
    margin: 0;
    padding: 0;
}

    
</style>
</head>
<body>
	
    <!-- 이벤트 슬라이더 -->
    <div id="eventCarousel" class="carousel slide" data-ride="carousel">
    <ol class="carousel-indicators">
        <li data-target="#eventCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#eventCarousel" data-slide-to="1"></li>
        <li data-target="#eventCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <div class="carousel-item active">
          <a href="/event/view.do?no=1">
            <img src="/upload/event/Ryzen-9000-R5_Box-683x728.png" class="d-block w-100" alt="Event 1">
           </a>
            <div class="carousel-caption d-none d-md-block">
                <h5>라이젠 9000번대 체험단 모집</h5>
                <p>라이젠 9000번대 체험 할 분들을 모집하고 있습니다.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="/upload/event/e14.png" class="d-block w-100" alt="Event 2">
            <div class="carousel-caption d-none d-md-block">
                <h5>가을 행사</h5>
                <p>이번 가을 행사 ㅇㅁㄴㅇㅁㅁㄴ</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="/upload/event/test.png" class="d-block w-100" alt="Event 3">
            <div class="carousel-caption d-none d-md-block">
                <h5>그래픽 카드 할인 행사 이벤트</h5>
                <p>최대 30% 할인</p>
            </div>
        </div>
    </div>
    <a class="carousel-control-prev" href="#eventCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#eventCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>


<br>
<br>


<div>
    <h3>추천상품</h3>
    <div class="goods" style="display: flex; flex-wrap: wrap; gap: 20px;">
        <!-- goodsList 데이터를 반복하여 출력 -->
        <c:forEach var="vo" items="${goodsList}">
            <div class="card" style="width: 18rem; margin-bottom: 20px;">
                <a href="/goods/view.do?goodsNo=${vo.goodsNo}&inc=1">
                    <!-- 대표 이미지 출력 -->
                    <img src="${vo.goodsMainImage}" class="card-img-top rounded" alt="${vo.goodsName}" width="304" height="236">
                </a>
                <div class="card-body">
                    <!-- 상품명 출력 -->
                    <h5 class="card-title">${vo.goodsName}</h5>
                    <!-- 원가 출력 -->
                    <p class="card-text">원가: ${vo.goodsPrice} 원</p>
                    <a href="/goods/view.do?no=${vo.goodsNo}"></a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

 <div class="notice-container">
        <!-- 공지사항 제목 -->
        <h3>공지사항</h3>
      <div class="notice" style="display: flex; flex-wrap: wrap; gap: 20px;">
	<c:forEach var="vo" items="${noticelist}" >
	<div class="dataRow" data-no="${vo.no }" style="display: flex; justify-content: space-between;">
        <!-- 공지사항 리스트 -->
        <ul class="notice-list">
            <li class="notice-item">
                <a href="/notice/view.do?no=${vo.no }">공지: ${vo.title }</a>
			<span>시작일: 
			<fmt:formatDate value="${vo.startDate }" pattern="yyyy-MM-dd"/>
			</span>
            </li>
        </ul>
    </div>
    </c:forEach>
    </div>
    </div>
</body>
</html>