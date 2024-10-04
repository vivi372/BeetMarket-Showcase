<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>미니게임 - 가위 바위 보</title>
    <style>
        .container {
            text-align: center;
            margin-top: 50px;
        }
        .btn {
            border: none;
            background-color: transparent;
            cursor: pointer;
        }
        .btn img {
            width: 100px;
            height: 100px;
            margin: 10px;
        }
        .result {
            font-size: 24px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>가위 바위 보 미니게임</h1>

         <form action="minigame.do" method="post">
            <button type="submit" class="btn" name="userChoice" value="가위">
                <img src="/upload/event/Scissors.png" alt="가위">
            </button>
            <button type="submit" class="btn" name="userChoice" value="바위">
                <img src="/upload/event/Rock.jpg" alt="바위">
            </button>
            <button type="submit" class="btn" name="userChoice" value="보">
                <img src="/upload/event/cloth.jpg" alt="보">
            </button>
        </form>

        <div class="result">
            <strong>현재 포인트: ${points}</strong><br>
            <c:if test="${not empty msg}">
                <strong>${msg}</strong>
            </c:if>
        </div>
    </div>
</body>
</html>