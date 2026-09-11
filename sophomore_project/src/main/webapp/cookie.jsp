<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>로그인 | ILLYA</title>
    <style>
        .signin-page { min-height: calc(100vh - 290px); padding: 72px 20px 84px; background: #f6f7f8; }
        .signin-wrap { width: 100%; max-width: 456px; margin: 0 auto; }
        .signin-card { overflow: hidden; border: 1px solid #e5e8eb; border-radius: 14px; background: #fff; box-shadow: 0 18px 42px rgba(31, 36, 43, .08); }
        .signin-card-head { padding: 34px 36px 27px; border-bottom: 1px solid #eceef0; background: #1d2025; color: #fff; }
        .signin-card-head h1 { margin: 0; color: #fff; font-size: 27px; font-weight: 900; letter-spacing: -1px; }
        .signin-card-body { padding: 31px 36px 35px; }
        .signin-field { margin-bottom: 19px; }
        .signin-field label { display: block; margin-bottom: 8px; color: #32373d; font-size: 13px; font-weight: 800; }
        .signin-input-wrap { position: relative; }
        .signin-input-wrap > i { position: absolute; top: 50%; left: 15px; z-index: 1; color: #939aa3; transform: translateY(-50%); }
        .signin-input-wrap input { width: 100%; height: 50px; padding: 0 43px; border: 1px solid #d9dee3; border-radius: 7px; background: #fff; color: #252a30; font-size: 14px; outline: 0; transition: .2s; }
        .signin-input-wrap input:focus { border-color: #f04452; box-shadow: 0 0 0 3px rgba(240, 68, 82, .12); }
        .signin-input-wrap input::placeholder { color: #a6adb5; }
        .signin-password-toggle { position: absolute; top: 0; right: 0; width: 46px; height: 50px; border: 0; background: transparent; color: #858d96; cursor: pointer; }
        .signin-submit { display: flex; align-items: center; justify-content: center; width: 100%; min-height: 50px; border: 1px solid #e23a48; border-radius: 7px; background: #e23a48; color: #fff; font-size: 14px; font-weight: 900; cursor: pointer; transition: .2s; }
        .signin-submit:hover { border-color: #c92d3a; background: #c92d3a; box-shadow: 0 8px 17px rgba(226, 58, 72, .2); transform: translateY(-1px); }
        .signin-divider { display: flex; align-items: center; gap: 12px; margin: 25px 0 19px; color: #a1a8af; font-size: 11px; font-weight: 700; }
        .signin-divider::before, .signin-divider::after { flex: 1; height: 1px; background: #eceff1; content: ""; }
        .signin-signup { display: flex; align-items: center; justify-content: center; width: 100%; min-height: 46px; border: 1px solid #cfd5da; border-radius: 7px; background: #fff; color: #30363d !important; font-size: 14px; font-weight: 800; text-decoration: none !important; transition: .2s; }
        .signin-signup:hover { border-color: #22272d; background: #f7f8f9; color: #22272d !important; }
        @media (max-width: 480px) { .signin-page { padding: 44px 15px 58px; } .signin-card-head, .signin-card-body { padding-right: 24px; padding-left: 24px; } }
    </style>
</head>
<body>
    <%@ include file="menu.jsp" %>

    <main class="signin-page">
        <div class="signin-wrap">
            <section class="signin-card" aria-labelledby="signinTitle">
                <div class="signin-card-head">
                    <h1 id="signinTitle" data-i18n data-ko="로그인" data-en="Sign in">로그인</h1>
                </div>
                <div class="signin-card-body">
                    <form action="cookie_process.jsp" method="post">
                        <div class="signin-field">
                            <label for="id" data-i18n data-ko="아이디" data-en="User ID">아이디</label>
                            <div class="signin-input-wrap">
                                <i class="fa fa-user" aria-hidden="true"></i>
                                <input type="text" id="id" name="id" autocomplete="username" placeholder="아이디를 입력하세요" data-i18n-placeholder data-ko-placeholder="아이디를 입력하세요" data-en-placeholder="Enter your user ID" required>
                            </div>
                        </div>
                        <div class="signin-field">
                            <label for="passwd" data-i18n data-ko="비밀번호" data-en="Password">비밀번호</label>
                            <div class="signin-input-wrap">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                                <input type="password" id="passwd" name="passwd" autocomplete="current-password" placeholder="비밀번호를 입력하세요" data-i18n-placeholder data-ko-placeholder="비밀번호를 입력하세요" data-en-placeholder="Enter your password" required>
                                <button type="button" class="signin-password-toggle" id="loginPasswordToggle" aria-label="비밀번호 표시"><i class="fa fa-eye" aria-hidden="true"></i></button>
                            </div>
                        </div>
                        <button type="submit" class="signin-submit" data-i18n data-ko="로그인" data-en="Sign in">로그인</button>
                    </form>
                    <div class="signin-divider" data-i18n data-ko="아직 회원이 아니신가요?" data-en="New to ILLYA?">아직 회원이 아니신가요?</div>
                    <a href="register.jsp" class="signin-signup" data-i18n data-ko="회원가입" data-en="Create account">회원가입</a>
                </div>
            </section>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
    <script>
        document.getElementById("loginPasswordToggle").addEventListener("click", function () {
            var passwordInput = document.getElementById("passwd");
            var isHidden = passwordInput.type === "password";
            passwordInput.type = isHidden ? "text" : "password";
            this.querySelector("i").className = isHidden ? "fa fa-eye-slash" : "fa fa-eye";
            this.setAttribute("aria-label", isHidden ? "비밀번호 숨기기" : "비밀번호 표시");
        });
    </script>
</body>
</html>
