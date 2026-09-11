<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String userID = (String) session.getAttribute("userID");

if (userID == null || userID.trim().isEmpty()) {
%>

<script>
    alert("로그인이 필요한 서비스입니다.");
    location.href = "cookie.jsp";
</script>

<%
    return;
}
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>회원정보 수정 완료</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>

        body {
            background-color: #f5f5f5;
        }

        .success-container {

            width: 600px;

            margin: 100px auto;

            background-color: white;

            padding: 50px;

            border-radius: 10px;

            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);

            text-align: center;
        }

        .success-icon {

            font-size: 60px;

            margin-bottom: 20px;
        }

        .success-title {

            font-size: 28px;

            font-weight: bold;

            margin-bottom: 20px;
        }

        .success-message {

            color: #666;

            margin-bottom: 30px;

            line-height: 1.8;
        }

        .button-box {

            display: flex;

            gap: 10px;

            justify-content: center;
        }

        .button-box a {

            min-width: 150px;
        }

    </style>

</head>

<body>

<div class="success-container">

    <div class="success-icon">
        ✓
    </div>

    <div class="success-title">
        회원정보 수정 완료
    </div>

    <div class="success-message">

        회원정보가 정상적으로 수정되었습니다.<br>

        변경된 정보가 저장되었습니다.

    </div>

    <div class="button-box">

        <a href="mypage.jsp"
           class="btn btn-primary">
            프로필로 돌아가기
        </a>

        <a href="productsu.jsp"
           class="btn btn-secondary">
            상품 목록
        </a>

    </div>

</div>

</body>

</html>
