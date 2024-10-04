<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 폼</title>
<style type="text/css">
a.btn, button.btn {
   display: inline-block; /* Inline-block to place them in a row */
   background-color: #222;
   color: #fff;
   padding: 10px 20px;
   text-align: center;
   text-decoration: none;
   border-radius: 5px;
   margin-right: 10px; /* Add margin between the elements */
   border: none; /* Remove border from button */
}

</style>

</head>
<body>
<div class="container">
	<h3>BeetMarKet</h3>
	<form action="login.do" method="post">
	  <div class="form-group">
	    <label for="id">ID</label>
	    <input type="text" class="form-control" placeholder="ID 입력"
	     id="id" name="id" autocomplete="none" required>
	  </div>
	  <div class="form-group">
	    <label for="pw">Password</label>
	    <input type="password" class="form-control"
	     placeholder="password 입력" id="pw" name="pw" required>
	  </div>
	  <button type="submit" class="btn btn-primary">로그인</button>
	  <a href="searchForm.do" class="btn">아이디 찾기</a>
	  <a href="pwSearchForm.do" class="btn">비밀번호 찾기</a>
	</form>
</div>
</body>
</html>