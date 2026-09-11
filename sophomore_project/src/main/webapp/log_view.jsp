<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>필터 로깅 정보 확인</title>
</head>
<body>

    <h2>웹 필터(LogFilter) 수집 정보</h2>
    <p>요청이 필터를 지나면서 기록된 클라이언트 정보입니다.</p>

    <table>
        <tr>
            <th>항목</th>
            <th>수집된 값</th>
        </tr>
        <tr>
            <td>요청 시간</td>
            <td><%= request.getAttribute("logTime") %></td>
        </tr>
        <tr>
            <td>클라이언트 IP</td>
            <td><%= request.getAttribute("clientIp") %></td>
        </tr>
        <tr>
            <td>요청 URI 경로</td>
            <td><%= request.getAttribute("requestUri") %></td>
        </tr>
        <tr>
            <td>HTTP 요청 방식</td>
            <td><%= request.getAttribute("httpMethod") %></td>
        </tr>
    </table>

</body>
</html>