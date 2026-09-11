<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.Member" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userID = (String) session.getAttribute("userID");
    if (userID == null || userID.trim().isEmpty()) {
        response.sendRedirect("cookie.jsp");
        return;
    }
    MemberDAO dao = new MemberDAO();
    Member member = dao.getMemberById(userID);
    if (member == null) {
        session.invalidate();
        response.sendRedirect("cookie.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>프로필 수정 | ILLYA</title>
    <style>
        .account-form-wrap { max-width: 790px; margin: 0 auto; }
        .account-form { overflow: hidden; }
        .account-form-head { display: flex; align-items: center; min-height: 84px; padding: 0 34px; border-bottom: 1px solid #e5e9ed; }
        .account-form-head h2 { margin: 0; color: #25292e; font-size: 22px; font-weight: 900; }
        .account-form-head p { display: none; }
        .account-section, .account-form > .account-field { margin: 0; padding: 27px 34px; border-bottom: 1px solid #e5e9ed; }
        .account-section-title { margin: 0 0 11px; color: #353a40; font-size: 15px; font-weight: 900; }
        .account-grid { display: block; }
        .account-field { display: grid; grid-template-columns: 150px minmax(0, 1fr); column-gap: 20px; align-items: center; min-height: 72px; margin: 0; border-bottom: 1px solid #eef1f3; }
        .account-field:last-child { border-bottom: 0; }
        .account-field label { margin: 0; color: #69727c; font-size: 13px; font-weight: 900; }
        .account-field input, .account-field select { width: 100%; height: 46px; padding: 0 13px; border: 1px solid #dce1e5; border-radius: 7px; background: #fff; color: #2c3136; font-size: 14px; outline: none; transition: .2s; }
        .account-field input:focus, .account-field select:focus { border-color: #ffbe33; box-shadow: 0 0 0 3px rgba(255,190,51,.15); }
        .account-field input[readonly] { background: #f7f8fa; color: #747b84; }
        .account-hint { grid-column: 2; margin: -4px 0 8px; color: #858d96; font-size: 12px; }
        .password-input { position: relative; }
        .password-input input { padding-right: 48px; }
        .password-toggle { position: absolute; top: 0; right: 0; width: 45px; height: 46px; border: 0; background: transparent; color: #6d747c; cursor: pointer; }
        .account-actions { display: flex; justify-content: flex-end; gap: 9px; margin: 0; padding: 24px 34px; }
        @media (max-width: 575px) {
            .account-form-head, .account-section, .account-form > .account-field, .account-actions { padding-right: 20px; padding-left: 20px; }
            .account-field { grid-template-columns: 1fr; gap: 8px; padding: 15px 0; }
            .account-hint { grid-column: auto; margin: -2px 0 0; }
            .account-actions { flex-direction: column-reverse; }
            .account-actions a, .account-actions button { width: 100%; }
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="프로필 수정" data-en="Edit profile">프로필 수정</h1>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <div class="account-form-wrap">
                <form action="processMemberEdit.jsp" method="post" class="shop-surface account-form">
                    <div class="account-form-head">
                        <h2 data-i18n data-ko="기본 정보" data-en="Account information">기본 정보</h2>
                        <p data-i18n data-ko="변경한 내용은 저장 버튼을 눌러야 반영됩니다." data-en="Changes are applied when you save them.">변경한 내용은 저장 버튼을 눌러야 반영됩니다.</p>
                    </div>

                    <div class="account-field">
                        <label for="id" data-i18n data-ko="아이디" data-en="User ID">아이디</label>
                        <input type="text" id="id" value="<%=member.getId()%>" readonly>
                        <p class="account-hint" data-i18n data-ko="아이디는 변경할 수 없습니다." data-en="Your user ID cannot be changed.">아이디는 변경할 수 없습니다.</p>
                    </div>

                    <section class="account-section">
                        <h3 class="account-section-title" data-i18n data-ko="비밀번호 변경" data-en="Change password">비밀번호 변경</h3>
                        <div class="account-grid">
                            <div class="account-field">
                                <label for="password" data-i18n data-ko="새 비밀번호" data-en="New password">새 비밀번호</label>
                                <div class="password-input">
                                    <input type="password" id="password" name="password" placeholder="변경하지 않으려면 비워두세요" data-i18n-placeholder data-ko-placeholder="변경하지 않으려면 비워두세요" data-en-placeholder="Leave blank to keep current">
                                    <button type="button" class="password-toggle" data-password-target="password" aria-label="비밀번호 표시"><i class="fa fa-eye" aria-hidden="true"></i></button>
                                </div>
                                <p class="account-hint" data-i18n data-ko="8~20자 영문과 숫자를 사용해 주세요." data-en="Use 8–20 letters and numbers.">8~20자 영문과 숫자를 사용해 주세요.</p>
                            </div>
                            <div class="account-field">
                                <label for="passwordConfirm" data-i18n data-ko="새 비밀번호 확인" data-en="Confirm new password">새 비밀번호 확인</label>
                                <div class="password-input">
                                    <input type="password" id="passwordConfirm" name="passwordConfirm" placeholder="새 비밀번호를 다시 입력하세요" data-i18n-placeholder data-ko-placeholder="새 비밀번호를 다시 입력하세요" data-en-placeholder="Re-enter your new password">
                                    <button type="button" class="password-toggle" data-password-target="passwordConfirm" aria-label="비밀번호 표시"><i class="fa fa-eye" aria-hidden="true"></i></button>
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="account-section">
                        <h3 class="account-section-title" data-i18n data-ko="개인 정보" data-en="Personal details">개인 정보</h3>
                        <div class="account-grid">
                            <div class="account-field">
                                <label for="name" data-i18n data-ko="이름" data-en="Name">이름</label>
                                <input type="text" id="name" name="name" value="<%=member.getName() == null ? "" : member.getName()%>" required>
                            </div>
                            <div class="account-field">
                                <label for="gender" data-i18n data-ko="성별" data-en="Gender">성별</label>
                                <select id="gender" name="gender" required>
                                    <option value="남" <%= "남".equals(member.getGender()) ? "selected" : "" %> data-i18n data-ko="남" data-en="Male">남</option>
                                    <option value="여" <%= "여".equals(member.getGender()) ? "selected" : "" %> data-i18n data-ko="여" data-en="Female">여</option>
                                </select>
                            </div>
                            <div class="account-field">
                                <label for="birth" data-i18n data-ko="생년월일" data-en="Date of birth">생년월일</label>
                                <input type="date" id="birth" name="birth" value="<%=member.getBirth() == null ? "" : member.getBirth()%>" required>
                            </div>
                            <div class="account-field">
                                <label for="phone" data-i18n data-ko="전화번호" data-en="Phone">전화번호</label>
                                <input type="tel" id="phone" name="phone" inputmode="numeric" maxlength="13" value="<%=member.getPhone() == null ? "" : member.getPhone()%>" placeholder="010-1234-5678" required>
                            </div>
                        </div>
                        <div class="account-field">
                            <label for="email" data-i18n data-ko="이메일" data-en="Email">이메일</label>
                            <input type="email" id="email" name="email" value="<%=member.getEmail() == null ? "" : member.getEmail()%>" required>
                        </div>
                        <div class="account-field">
                            <label for="address" data-i18n data-ko="주소" data-en="Address">주소</label>
                            <input type="text" id="address" name="address" value="<%=member.getAddress() == null ? "" : member.getAddress()%>" required>
                        </div>
                    </section>

                    <div class="account-actions">
                        <a href="mypage.jsp" class="shop-btn-outline" data-i18n data-ko="취소" data-en="Cancel">취소</a>
                        <button type="submit" class="shop-btn-primary border-0" data-i18n data-ko="변경 사항 저장" data-en="Save changes">변경 사항 저장</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
    <script>
        document.querySelectorAll(".password-toggle").forEach(function (button) {
            button.addEventListener("click", function () {
                var input = document.getElementById(this.getAttribute("data-password-target"));
                var isPassword = input.type === "password";
                input.type = isPassword ? "text" : "password";
                this.querySelector("i").className = isPassword ? "fa fa-eye-slash" : "fa fa-eye";
            });
        });
        document.getElementById("phone").addEventListener("input", function () {
            var numbers = this.value.replace(/\D/g, "").slice(0, 11);
            if (numbers.length <= 3) this.value = numbers;
            else if (numbers.length <= 7) this.value = numbers.slice(0, 3) + "-" + numbers.slice(3);
            else this.value = numbers.slice(0, 3) + "-" + numbers.slice(3, 7) + "-" + numbers.slice(7);
        });
    </script>
</body>
</html>
