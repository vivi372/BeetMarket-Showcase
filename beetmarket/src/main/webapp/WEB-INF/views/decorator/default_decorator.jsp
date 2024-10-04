<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 이영환 -->
<!-- 작성일 : 2017-01-12 -->
<!-- 최종수정일 : 2024-09-10 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>


<!DOCTYPE html>
<html>

<head>

<style type="text/css">
.beetmarket-login-btn {
	background-color: #03C75A !important; /* 초록색 */
	color: white !important; /* 텍스트 색상 */
	font-weight: bold !important; /* 텍스트 두께 */
	font-size: 16px !important; /* 텍스트 크기 */
	border: none !important; /* 테두리 제거 */
	border-radius: 6px !important; /* 둥근 테두리 */
	padding: 10px 20px !important; /* 내부 여백 */
	cursor: pointer !important; /* 커서 스타일 */
	text-align: center !important; /* 텍스트 중앙 정렬 */
	text-decoration: none !important; /* 텍스트 밑줄 제거 */
	display: inline-block;
	transition: background-color 0.3s ease; /* 부드러운 색상 전환 */
}


/* 마우스를 올렸을 때의 스타일 */
.beetmarket-login-btn:hover {
	background-color: #029E4B !important; /* 더 진한 초록색 */
}



.signup-link {
	background-color: #03C75A !important; /* 초록색 */
	color: white !important; /* 텍스트 색상 */
	font-weight: bold !important; /* 텍스트 두께 */
	font-size: 16px !important; /* 텍스트 크기 */
	border: none !important; /* 테두리 제거 */
	border-radius: 6px !important; /* 둥근 테두리 */
	padding: 10px 20px !important; /* 내부 여백 */
	cursor: pointer !important; /* 커서 스타일 */
	text-align: center !important; /* 텍스트 중앙 정렬 */
	text-decoration: none !important; /* 텍스트 밑줄 제거 */
	display: inline-block;
	transition: background-color 0.3s ease; /* 부드러운 색상 전환 */
	margin-right: 20px; 
}

.signup-link:hover {
	background-color: #029E4B !important; /* 더 진한 초록색 */
}
        
        
</style>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>비트마켓:</title>


<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>



<!-- Custom fonts for this template-->
<link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.14.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.js"></script>

<!-- icon 라이브러리 등록 - Font Awesome 4 / google -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<script>
$(function() {
	$('.btn-primary').on('click', function() {
		
	    $(this).blur();  // 클릭 후 포커스 제거
	});	
});
</script>
<!-- Custom styles for this template-->
<link href="/css/sb-admin-2.min.css" rel="stylesheet">
<decorator:head></decorator:head>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- 비트마켓로고  -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center mr-4" href="/">
			    <div class="sidebar-brand-icon rotate-n-15"></div>
			    <img class="sidebar-card-illustration mb-2" src="/img/메인로그3.png" alt="..." style="width: 40px; height: auto;">
			    <div class="sidebar-brand-text ">비트마켓</div>
			</a>
			


			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			
			<!-- 이벤트 -->
			<li class="nav-item">
			<a class="nav-link goods" href="/goods/list.do" style="color:white;">
		     <span>쇼핑</span></a></li>
			

			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- 이벤트 -->
			<li class="nav-item"><a class="nav-link event"
				href="/event/list.do" style="color:white;"> <span>이벤트</span></a></li>


			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- 공지사항  -->
			<li class="nav-item"><a class="nav-link notice"
				href="/notice/list.do" style="color:white;"> <span>공지사항</span></a></li>


			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!--포인트샵 -->
			<li class="nav-item"><a class="nav-link" id="pointshop-btn" style="color:white;">
					<span>포인트샵</span>
			</a></li>


			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- 주식 -->
			<li class="nav-item"><a class="nav-link" href="/stock/stockMain.do" style="color:white;">
					<span>주식</span>
			</a></li>


			<!-- Divider -->
			<hr class="sidebar-divider my-0">


			<!-- faq -->
			<li class="nav-item">
			<a class="nav-link" href="/faq/list.do" style="color:white;">
				<span>faq</span>
			</a></li>
			


			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">


		</ul>
		<!-- End of Sidebar -->



		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>


					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>


						<div class="navbar-nav login">
						<c:if test="${ empty login }">
						    <a href="/member/writeForm.do" class="nav-item nav-link signup-link">회원가입</a>
						    <a href="/member/loginForm.do" class="nav-item nav-link beetmarket-login-btn">BEETMARKET 로그인</a>
						</c:if>

						<!-- 로그인 된 거  -->
						<c:if test="${!empty login}">
							<div class="nav-item dropdown" >
								<a class="nav-link dropdown-toggle" href="#"
									id="profileDropdown" role="button" data-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false"> 
									<c:if test="${empty login.photo}">
										<i class="fa fa-user-circle-o"></i>
									</c:if> 
									<c:if test="${!empty login.photo}">
									
									<div class="name" style="margin-right: 10px;">
									${login.name }
									</div>
										<img src="${login.photo}" class="rounded-circle"
											style="width: 30px; height: 30px;">
									</c:if>
								</a>
									<div class="dropdown-menu" aria-labelledby="profileDropdown">
									<!-- sassaas -->
										<a class="dropdown-item" href="/member/myView.do">내정보보기</a><a
											class="dropdown-item" href="/basket/list.do">장바구니</a><a
											href="/order/list.do" class="dropdown-item">주문내역</a><a
											href="/chatbot/roomlist.do" class="dropdown-item">채팅방</a>
									</div>
								</div>
								
								<div class="nav-item dropdown d-flex align-items-center">
								    <!-- 챗봇 링크 -->
								    <div class="mr-2" id="chatbot">
								        <a class="nav-link chatbot" href="/chatbot/starthelp.do">
								           <i class="material-icons"style="color:green; size: 10px;">&#xe0b7;</i>
								        </a>
								    </div>
								    <!-- 로그아웃 링크 (오른쪽) -->
								    <a href="/member/logout.do" class="nav-item nav-link">
								        <i class="fa fa-sign-out" ></i> Logout
								    </a>
								</div>
							</c:if>
						</div>
					</ul>
					<!-- end of Topbar Navbar -->
				</nav>
				<!-- end of Topbar -->


				<!-- End of Topbar -->
				<div class="container-fluid">
					<decorator:body />
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

	



			<!-- msg를 표시할 모달 창 -->
			<!-- The Modal -->
			<div class="modal" id="msgModal">
				<div class="modal-dialog">
					<div class="modal-content">

						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">처리 결과 모달 창</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">${msg }</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>

					</div>
				</div>
			</div>

			<c:if test="${ !empty msg }">
				<!-- 모달을 보이게하는 javascript -->
				<script type="text/javascript">
					$(function() {
						$("#msgModal").modal("show");
					});
				</script>
			</c:if>

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>


	
	<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>bit market 2024</span>
					</div>
				</div>
			</footer>
	<!-- End of Footer -->

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>
		

	<jsp:include page="/WEB-INF/views/pointShop/pointShopModal.jsp" />

	<!-- Custom scripts for all pages-->
	<script src="/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="/vendor/chart.js/Chart.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/js/demo/chart-area-demo.js"></script>
	<script src="/js/demo/chart-pie-demo.js"></script>

</body>

</html>