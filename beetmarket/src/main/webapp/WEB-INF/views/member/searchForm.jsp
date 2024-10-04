<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<script type="text/javascript" src="/js/member/telInput.js"></script>
<style type="text/css">
	
    .card {
        margin: 0 auto; /* Added */
        float: none; /* Added */
        margin-bottom: 10px; /* Added */
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
    .checkbox{
        margin-right: 20px;
        text-align: right;
    }
    .card-title{
        margin-left: 30px;
    }

    .links{
        text-align: center;
        margin-bottom: 10px;
    }
    a{ 
    	color: #000080; text-decoration: none; 
    }
</style>
</head>
<body >
<div class="card align-middle" style="width:25rem;">
	<div class="card-title" style="margin-top:30px;">
		<h2 class="card-title" style="color:#f58b34;"><img src="/upload/image/image.jpg"/></h2>
	</div>
        
		<div class="card-body">
      <form action="idSearch.do" class="form-signin" method="POST">
        <input  name="name" id="name" class="form-control" placeholder="이름" required autofocus><BR>
        <input class="txtPhone form-control "  placeholder="000-0000-00000"  pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}"	
         name="tel" id="tel" placeholder="전화번호" required ><br>
        <button id="btn-Yes" class="btn btn-lg btn-primary btn-block" type="submit">아 이 디 찾 기</button>
      </form>
		</div>
        <div class="links">
            <a href="pwSearchForm.do">비밀번호 찾기</a> | <a href="loginForm.do">로그인</a> | <a href="writeForm.do">회원가입</a>
        </div>
</div>
</body>
</html>