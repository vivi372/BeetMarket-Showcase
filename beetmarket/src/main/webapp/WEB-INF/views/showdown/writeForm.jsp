<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 발표 글등록</title>
 <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
 <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
</head>
<body>
<div class="container">
	<h1>이벤트 발표 글등록</h1>
	<form action="write.do" method="post">
		<input name="perPageNum" value = "${param.perPageNum }" type="hidden">
			<div class="form-group">
				<label for="title">제목</label>
				  <input id="title" name="title" required 
						class="form-control" maxlength="100"
						pattern="^[^ .].{2,99}$"
						title="맨앞에 공백문자 불가. 3~100자 입력"
						placeholder="제목 입력 : 3자 이상 100자 이내">
			</div> 
			 <div class="form-group">
				<label for="content">내용</label>
				 <textarea class="form-control" id="content" name="content"  required
					rows="7" placeholder="첫글자는 공백문자나 줄바꿈을 입력할 수 없습니다."></textarea>
			</div>
			<div class="form-group">
				<label for="pw">비밀번호</label>
				  <input class="form-control" name="pw" id="pw" required type="password">
			</div>
			 <div class="form-group">
				<label for="pw2">비밀번호 확인</label>
				  <input class="form-control" id="pw2" required  type="password">
			</div>
			 <div class="form-group">
					<!-- a tag : 데이터를 클릭하면 href의 정보를 가져와서 페이지 이동시킨다. -->
			<button class="btn btn-primary">등록</button>
			<button type="reset" class="btn btn-secondary">다시입력</button>
			<button type="button" onclick="history.back();" class="btn btn-warning">취소</button>
			</div>
	</form>
</div>
</body>
</html>