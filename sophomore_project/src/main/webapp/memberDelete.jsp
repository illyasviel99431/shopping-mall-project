<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
String userID =
        (String) session.getAttribute("userID");

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

    <title>계정 삭제</title>

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

    <style>

        body {
            background-color: #f5f5f5;
        }

        .delete-container {

            width: 500px;

            margin: 100px auto;

            background: white;

            padding: 40px;

            border-radius: 10px;

            box-shadow: 0 3px 15px rgba(0,0,0,0.1);

            text-align: center;
        }

        .warning {

            color: #dc3545;

            font-weight: bold;

            margin-bottom: 20px;
        }

        .button-box {

            display: flex;

            gap: 10px;

            margin-top: 25px;
        }

        .button-box button,
        .button-box a {

            flex: 1;
        }

    </style>

</head>

<body>

<div class="delete-container">

    <h2>
        계정 삭제
    </h2>

    <p class="warning">
        계정을 삭제하면 회원정보를 사용할 수 없습니다.
    </p>

    <p>
        정말 계정을 삭제하시겠습니까?
    </p>

    <form action="processMemberDelete.jsp"
          method="post">

        <div class="mb-3">

            <input type="password"
                   name="password"
                   class="form-control"
                   placeholder="현재 비밀번호"
                   required>

        </div>

        <div class="button-box">

            <button type="submit"
                    class="btn btn-danger">
                계정 삭제
            </button>

            <a href="mypage.jsp"
               class="btn btn-secondary">
                취소
            </a>

        </div>

    </form>

</div>

</body>

</html>
