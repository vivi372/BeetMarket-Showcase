<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>추첨 결과</title>
    <style>
        .container {
            width: 50%;
            margin: 0 auto;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: center;
        }
        .result {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>이벤트 추첨</h1>
        <!-- 드롭다운 메뉴로 당첨자 수 선택 -->
        <form action="/event/drowWinner.do" method="post">
            <div class="dropdown-menu">
                <label for="numWinners">당첨자 수 선택:</label>
                <select name="numWinners" id="numWinners" required>
                    <option value="1">1명</option>
                    <option value="2">2명</option>
                    <option value="3">3명</option>
                    <option value="5">5명</option>
                    <option value="10">10명</option>
                </select>
            </div>
            <br>
            <input type="hidden" name="event_no" value="${SubscriberVO.event_no}" /> <!-- 이벤트 번호 전달 -->
            <button type="submit">추첨하기</button>
        </form>
    </div>
</body>
</html>
