<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 보기</title>
<%-- <jsp:include page="../jsp/webLib.jsp"/>
 --%>
<style type="text/css">
#smallImageDiv img {
	width: 80px;
	height: 80px;
	margin: 3px;
}

#smallImageDiv img:hover {
	opacity: 70%;
	cursor: pointer;
}

#goodsDetailDiv div {
	padding: 5px;
	border-bottom: 1px solid #ccc;
}

.carousel-inner img {
	width: 100%;
	height: 600px;
	margin: 3px;
	object-fit: contain;
}

.ContentImage img {
	width: 100%;
	margin: 3px;
	object-fit: contain;
}
</style>

<script type="text/javascript">
	$(function() {
		// 이미지 보기 작 클릭 ->큰 보이기
		$("#smallImageDiv img").click(function() {
			$("#bigImageDiv img").attr("src", $(this).attr("src"));
		});

		// 글수정 버튼
		$("#updateBtn").click(function() {
			location = "updateForm.do?goodsNo=${vo.goodsNo}";
		});

		// 좋아요 버튼
		$("#likeBtn").click(function() {
			location = "/ajax/getLike.do?goodsNo=${vo.goodsNo}&id=${login.id}";
		});

		// 좋아요 해제 버튼
		$("#unLikeBtn")
				.click(
						function() {
							location = "/ajax/getUnLike.do?goodsNo=${vo.goodsNo}&id=${login.id}";
						});

		// 글삭제 버튼
		$("#deleteBtn").click(function() {
			location = "delete.do?goodsNo=${vo.goodsNo}";
		});

		// 리스트 버튼
		$("#listBtn")
				.click(
						function() {
							location = "list.do?page=${param.page}&perPageNum=${param.perPageNum}";
						});

	});
</script>

</head>
<body>
	<div class="container">
		<div class="card">
			<div class="card-header">
				<c:if test="${vo.id == login.id}">
					<button class="btn btn-primary" id="updateBtn">상품정보수정</button>
					<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">판매중지신청</button>
					<button class="btn btn-danger" id="updateOptionBtn" data-toggle="modal" data-target="#deleteModal">상품옵션수정</button>
				</c:if>
				<c:if test="${login.gradeNo == 9 }">
					<button class="btn btn-primary" id="updateBtn">상품정보수정</button>
					<button class="btn btn-danger" id="deleteBtn" data-toggle="modal" data-target="#deleteModal">판매중지신청</button>
					<button class="btn btn-danger" id="updateOptionBtn" data-toggle="modal" data-target="#deleteModal">상품옵션수정</button>
				</c:if>
				<button class="btn btn-warning" id="listBtn">돌아가기</button>
				<c:if test="${login.id != null}">
					<c:if test="${empty likeCheck }">
						<button class="btn btn-success" id="likeBtn" style="float: right">좋아요</button>
					</c:if>
					<c:if test="${!empty likeCheck }">
						<button class="btn btn-danger" id="unLikeBtn" style="float: right">좋아요취소</button>
					</c:if>
				</c:if>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-md-6">
						<div id="demo" class="carousel slide" data-ride="carousel">

							<!-- The slideshow -->
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img src="${vo.goodsMainImage }" class="img-thumbnail">
								</div>
								<c:if test="${!empty imageList}">
									<c:forEach items="${imageList }" var="imageVO">
										<div class="carousel-item">
											<img src="${imageVO.goodsImageName }" class="img-thumbnail">
										</div>
									</c:forEach>
								</c:if>
							</div>

							<!-- Left and right controls -->
							<a class="carousel-control-prev" href="#demo" data-slide="prev">
								<span class="carousel-control-prev-icon"></span>
							</a>
							<a class="carousel-control-next" href="#demo" data-slide="next">
								<span class="carousel-control-next-icon"></span>
							</a>
						</div>
					</div>

					<div class="col-md-6">
						상품 설명
						<div>
							<i class="fa fa-check"></i>
							상품명 : ${vo.goodsName }
						</div>
						<div>
							<i class="fa fa-check"></i>
							분류 : ${vo.categoryName }
						</div>
						<div>
							<i class="fa fa-check"></i>
							상품번호 : ${vo.goodsNo }
						</div>
						<div>
							<i class="fa fa-check"></i>
							정가 :
							<fmt:formatNumber value="${vo.goodsOriPrice }" />
							원
						</div>
						<div>
							<i class="fa fa-check"></i>
							고정할인가 :
							<fmt:formatNumber value="${vo.goodsDiscount }" />
							원
						</div>
						<div>
							<i class="fa fa-check"></i>
							할인률 :
							<fmt:formatNumber value="${vo.goodsDiscRate }" />
							%
						</div>
						<div>
							<i class="fa fa-check"></i>
							판매가 :
							<fmt:formatNumber value="${vo.goodsPrice }" />
							원
						</div>
						<div>
							<i class="fa fa-check"></i>
							고정적립금 :
							<fmt:formatNumber value="${vo.goodsSavings }" />
							비트
						</div>
						<div>
							<i class="fa fa-check"></i>
							적립비율 :
							<fmt:formatNumber value="${vo.goodsSaveRate }" />
							%
						</div>
						<div>
							<i class="fa fa-check"></i>
							기본배송비 :
							<fmt:formatNumber value="${vo.merchant_delivery }" />
							원
						</div>
						<div>
							<i class="fa fa-check"></i>
							총 주문금액 :
							<fmt:formatNumber value="${vo.free_ship_limit }" />
							원 이상이면 무료배송!
						</div>
						<div>
							<i class="fa fa-check"></i>
							판매자 : ${vo.store_name }
						</div>
						<c:if test="${login.gradeNo == 9 }">
							<div>
								<i class="fa fa-check"></i>
								상태 : ${vo.goodsStatusName }
							</div>
						</c:if>
						<hr>
						<jsp:include page="/WEB-INF/views/basket/write.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<div class="card-footer">
				<div id="accordion">

					<div class="card">
						<div class="card-header">
							<a class="card-link" data-toggle="collapse" href="#collapseOne"> 상품 정보 </a>
							<c:if test="${vo.id == login.id}">
								<button class="btn btn-success" id="updateInfoBtn">정보수정</button>
							</c:if>
							<c:if test="${login.gradeNo == 9 }">
								<button class="btn btn-success" id="updateInfoBtn">정보수정</button>
							</c:if>
						</div>
						<div id="collapseOne" class="collapse" data-parent="#accordion">
							<div class="card-body">
								<div class="row">
									<h2>상품 정보 리스트</h2>

									<table class="table table-bordered">
										<thead>
										</thead>
										<tbody>
											<tr>
												<c:if test="${!empty infoList}">
													<c:forEach items="${infoList }" var="infoVO" varStatus="vs">
														<c:if test="${vs.index != 0 && vs.index%2 == 0 }">
															${"</tr>"}
															${"<tr>"}
														</c:if>
														<td>${infoVO.goodsInfoName }</td>
														<td>${infoVO.goodsInfoCon }</td>
													</c:forEach>
												</c:if>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header">
							<a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo"> 상세 이미지 </a>
							<c:if test="${vo.id == login.id}">
								<button class="btn btn-success" id="updateInfoBtn">정보수정</button>
							</c:if>
							<c:if test="${login.gradeNo == 9 }">
								<button class="btn btn-success" id="updateInfoBtn">정보수정</button>
							</c:if>
						</div>
						<div id="collapseTwo" class="collapse show" data-parent="#accordion">
							<div class="card-body">
								<div class="ContentImage">
									<img src="${vo.goodsConImage }">
								</div>
								<div class="card-body">${vo.goodsContent }</div>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header">
							<a class="collapsed card-link" data-toggle="collapse" href="#collapseThree"> 댓글 / 리뷰 </a>
						</div>
						<div id="collapseThree" class="collapse show" data-parent="#accordion">
							<jsp:include page="/WEB-INF/views/review/reviewList.jsp" />
						</div>
					</div>

				</div>
			</div>
		</div>


	</div>


</body>
</html>