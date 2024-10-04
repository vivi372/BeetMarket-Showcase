<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 글등록</title>
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
</head>
<body>
<div class="container">
	<h1>이벤트 수정</h1>
	<form action="update.do" method="post">
			<!-- tr : table row - 테이블 한줄 -->
			<!-- 게시판 데이터의 제목 -->
			<div class="form-group">
				<label for="no">번호</label>
				<input id="no" name="no" required readonly class="form-control" value="${param.no}">
			</div>
			<div class="form-group">
				<label for="title">제목</label>
				<input id="title" name="title" required class="form-control" value="${vo.title}">
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" id="content" name="content" rows="7" >${vo.content }</textarea>
			</div>
			<div class="form-group">
				<label for="pw">비밀번호</label>
				  <input class="form-control" name="pw" id="pw" required type="password">
			</div>
			<div>
				<!-- a tag : 데이터를 클릭하면 href의 정보를 가져와서 페이지 이동시킨다. -->
				<button class="btn btn-primary">수정</button>
				<button type="reset" class="btn btn-secondary">다시입력</button>
				<button type="button" onclick="history.back();" class="btn btn-warning">취소</button>
			</div>
	</form>
</div>
</body>
</html>