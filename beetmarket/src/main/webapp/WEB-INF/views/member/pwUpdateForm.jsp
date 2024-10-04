<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<style type="text/css">
.card {
    margin: 0 auto;
    float: none;
    margin-bottom: 10px;
}
#btn-Yes{
    background-color: #C0C0C0;
    border: none;
}
.login .form-control {
    position: relative;
    height: auto;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    padding: 10px;
    font-size: 16px;
}
.checkbox {
    margin-right: 20px;
    text-align: right;
}
.card-title {
    margin-left: 30px;
}
.links {
    text-align: center;
    margin-bottom: 10px;
}
a {
    color: #000080;
    text-decoration: none;
}
#error-message {
    color: red;
    margin-top: 10px;
    display: none;
}
</style>
<script>
function checkPasswords() {
    const pw = document.getElementById("pw").value;
    const pw2 = document.getElementById("pw2").value;
    const errorMessage = document.getElementById("error-message");
    const btnYes = document.getElementById("btn-Yes");

    if (pw !== pw2) {
        errorMessage.style.display = "block"; // Show the error message
        btnYes.disabled = true; // Disable the button
    } else {
        errorMessage.style.display = "none"; // Hide the error message
        btnYes.disabled = false; // Enable the button
    }
}
</script>
</head>
<body>
<div class="card align-middle" style="width:25rem;">
    <div class="card-title" style="margin-top:30px;">
        <h2 class="card-title" style="color:#f58b34;"><img src="/upload/image/image.jpg"/></h2>
    </div>
    <div class="card-body">
        <form action="pwUpdate.do" class="form-signin" method="POST">
            <input type="hidden" value="${pwSearch.id}" name="id" id="id">
            <input name="pw" id="pw" class="form-control" placeholder="비밀번호 입력" required autofocus oninput="checkPasswords()"><br>
            <input name="pw2" id="pw2" class="form-control" placeholder="비밀번호 확인" required oninput="checkPasswords()"><br>
            <div id="error-message">비밀번호가 일치하지 않습니다.</div>
            <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit" disabled>변경</button>
        </form>
    </div>
    <div class="links">
        <a href="memberPw">아이디 찾기</a> | <a href="loginForm.do">로그인</a> | <a href="writeForm.do">회원가입</a>
    </div>
</div>
</body>
</html>
