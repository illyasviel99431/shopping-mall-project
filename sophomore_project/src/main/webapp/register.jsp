<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>

    <style>
        html,
        body {
            min-height: 100%;
        }

        body {
            background-color: #f5f5f5;
            display: flex;
            flex-direction: column;
        }

        .register-page {
            flex: 1;
            padding: 60px 15px 80px;
        }

        .register-container {
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 3px 15px rgba(0,0,0,0.1);
        }

        .register-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-label {
            font-weight: bold;
        }

        .email-box {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .email-box input,
        .email-box select {
            flex: 1;
        }

        .password-box {
            position: relative;
        }

        .password-box input {
            padding-right: 52px;
        }

        .password-toggle {
            position: absolute;
            top: 50%;
            right: 10px;
            width: 34px;
            height: 34px;
            transform: translateY(-50%);
            border: 0;
            border-radius: 50%;
            background: transparent;
            color: #6c757d;
            cursor: pointer;
        }

        .password-toggle:hover {
            background: #f1f3f5;
            color: #212529;
        }

        .birth-box {
            display: grid;
            grid-template-columns: 1.4fr 1fr 1fr;
            gap: 8px;
        }

        .gender-options {
            display: flex;
            gap: 10px;
        }

        .gender-option {
            position: relative;
            flex: 1;
            margin: 0;
            cursor: pointer;
            user-select: none;
        }

        .gender-option input {
            position: absolute;
            opacity: 0;
        }

        .gender-option span {
            display: block;
            padding: 11px 14px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            color: #6c757d;
            text-align: center;
            font-size: 14px;
            font-weight: 600;
            transition: .2s ease;
        }

        .gender-option input:checked + span {
            border-color: #ffbe33;
            background: #fff8e6;
            color: #8a5b00;
        }

        .email-box {
            flex-wrap: wrap;
        }

        .email-fields {
            display: flex;
            flex: 1 1 300px;
            align-items: center;
            gap: 8px;
        }

        .email-domain-select {
            flex: 1 1 165px !important;
        }

        .address-search-row {
            display: flex;
            gap: 8px;
            margin-bottom: 8px;
        }

        .address-search-row input {
            max-width: 130px;
        }

        .address-search-button {
            flex: none;
            border: 0;
            border-radius: 6px;
            padding: 0 15px;
            background: #212529;
            color: #fff;
            font-size: 13px;
            font-weight: 700;
            white-space: nowrap;
            cursor: pointer;
        }

        .address-search-button:hover {
            background: #ffbe33;
            color: #212529;
        }

        .address-input + .address-input {
            margin-top: 8px;
        }

        .readonly-input {
            background: #f8f9fa !important;
        }

        .button-box {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }

        .button-box button {
            width: 50%;
        }

        .error {
            color: red;
            font-size: 13px;
            margin-top: 5px;
        }

        @media (max-width: 576px) {
            .register-page {
                padding: 35px 15px 55px;
            }

            .register-container {
                padding: 28px 22px;
            }

            .button-box {
                flex-direction: column;
            }

            .button-box button {
                width: 100%;
            }

            .birth-box {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<jsp:include page="menu.jsp" />

<main class="register-page">

<div class="register-container">

    <h2 class="register-title">회원가입</h2>

    <form name="newMember"
      action="processRegister.jsp"
      method="post"
      onsubmit="return checkForm();">

        <!-- 아이디 -->
        <div class="form-group">
            <label class="form-label">아이디</label>

            <input type="text"
                   class="form-control"
                   id="id"
                   name="id"
                   minlength="4"
                   maxlength="20"
                   pattern="[A-Za-z0-9_]{4,20}"
                   required>

            <div class="form-text">
                4~20자의 영문, 숫자, _만 사용할 수 있습니다.
            </div>
        </div>


        <!-- 비밀번호 -->
        <div class="form-group">
            <label class="form-label">비밀번호</label>

            <div class="password-box">
                <input type="password"
                       class="form-control"
                       id="password"
                       name="password"
                       minlength="8"
                       maxlength="20"
                       required>

                <button type="button"
                        class="password-toggle"
                        data-target="password"
                        aria-label="비밀번호 표시"
                        title="비밀번호 표시">
                    <i class="fa fa-eye" aria-hidden="true"></i>
                </button>
            </div>

            <div class="form-text">
                8~20자이며 영문과 숫자를 포함해야 합니다.
            </div>
        </div>


        <!-- 비밀번호 확인 -->
        <div class="form-group">
            <label class="form-label">비밀번호 확인</label>

            <div class="password-box">
                <input type="password"
                       class="form-control"
                       id="password_confirm"
                       name="password_confirm"
                       minlength="8"
                       maxlength="20"
                       required>

                <button type="button"
                        class="password-toggle"
                        data-target="password_confirm"
                        aria-label="비밀번호 표시"
                        title="비밀번호 표시">
                    <i class="fa fa-eye" aria-hidden="true"></i>
                </button>
            </div>
        </div>


        <!-- 이름 -->
        <div class="form-group">
            <label class="form-label">성명</label>

            <input type="text"
                   class="form-control"
                   id="name"
                   name="name"
                   maxlength="30"
                   required>
        </div>


        <!-- 생년월일 -->
        <div class="form-group">
            <label class="form-label">생년월일</label>

            <div class="birth-box">
                <select class="form-control" id="birthYear" aria-label="출생 연도" required></select>
                <select class="form-control" id="birthMonth" aria-label="출생 월" required></select>
                <select class="form-control" id="birthDay" aria-label="출생 일" required></select>
            </div>

            <input type="hidden" id="birth" name="birth">
        </div>


        <!-- 성별 -->
        <div class="form-group">

            <label class="form-label">성별</label>

            <div class="gender-options">
                <label class="gender-option" for="genderMale">
                    <input type="radio"
                           id="genderMale"
                           name="gender"
                           value="남"
                           required>
                    <span>남</span>
                </label>

                <label class="gender-option" for="genderFemale">
                    <input type="radio"
                           id="genderFemale"
                           name="gender"
                           value="여">
                    <span>여</span>
                </label>
            </div>
        </div>


        <!-- 이메일 -->
        <div class="form-group">

            <label class="form-label">이메일</label>

            <div class="email-box">
                <div class="email-fields">
                    <input type="text"
                           class="form-control"
                           id="mail1"
                           name="mail1"
                           maxlength="20"
                           placeholder="이메일"
                           pattern="[A-Za-z0-9._%+-]{1,20}"
                           required>

                    <span>@</span>

                    <input type="text"
                           class="form-control"
                           id="mail2"
                           name="mail2"
                           maxlength="50"
                           placeholder="직접 입력"
                           required>
                </div>

                <select class="form-control email-domain-select"
                        id="emailDomain"
                        aria-label="이메일 도메인 선택">

                    <option value="">직접 입력</option>
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                    <option value="hanmail.net">hanmail.net</option>

                </select>

            </div>
        </div>


        <!-- 전화번호 -->
        <div class="form-group">

            <label class="form-label">전화번호</label>

            <input type="text"
                   class="form-control"
                   id="phone"
                   name="phone"
                   placeholder="010-1234-5678"
                   inputmode="numeric"
                   maxlength="13"
                   required>

            <div class="form-text">
                예: 010-1234-5678
            </div>

        </div>


        <!-- 주소 -->
        <div class="form-group">

            <label class="form-label">주소</label>

            <div class="address-search-row">
                <input type="text"
                       class="form-control readonly-input"
                       id="postcode"
                       placeholder="우편번호"
                       readonly>

                <button type="button"
                        class="address-search-button"
                        onclick="openAddressSearch();">
                    주소 찾기
                </button>
            </div>

            <input type="text"
                   class="form-control address-input readonly-input"
                   id="roadAddress"
                   placeholder="주소 검색 버튼을 눌러주세요"
                   readonly>

            <input type="text"
                   class="form-control address-input"
                   id="detailAddress"
                   placeholder="상세주소를 입력해주세요. (동, 호수 등)"
                   maxlength="50">

            <input type="hidden" id="address" name="address">

        </div>


        <!-- 버튼 -->
        <div class="button-box">

            <button type="submit"
                    class="btn btn-primary">
                회원가입
            </button>

            <button type="reset"
                    class="btn btn-secondary">
                다시쓰기
            </button>

        </div>

    </form>

</div>

</main>

<%@ include file="footer.jsp" %>

<script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

document.addEventListener("DOMContentLoaded", function () {

    var birthYear = document.getElementById("birthYear");
    var birthMonth = document.getElementById("birthMonth");
    var birthDay = document.getElementById("birthDay");
    var currentYear = new Date().getFullYear();

    birthYear.add(new Option("연도", ""));
    birthMonth.add(new Option("월", ""));
    birthDay.add(new Option("일", ""));

    for (var year = currentYear; year >= 1900; year--) {
        birthYear.add(new Option(year + "년", year));
    }

    for (var month = 1; month <= 12; month++) {
        var monthValue = String(month).padStart(2, "0");
        birthMonth.add(new Option(month + "월", monthValue));
    }

    function updateBirthDays() {
        var selectedDay = birthDay.value;
        var yearValue = parseInt(birthYear.value, 10) || 2000;
        var monthValue = parseInt(birthMonth.value, 10) || 1;
        var lastDay = new Date(yearValue, monthValue, 0).getDate();

        birthDay.options.length = 0;
        birthDay.add(new Option("일", ""));

        for (var day = 1; day <= lastDay; day++) {
            var dayValue = String(day).padStart(2, "0");
            birthDay.add(new Option(day + "일", dayValue));
        }

        if (selectedDay && parseInt(selectedDay, 10) <= lastDay) {
            birthDay.value = selectedDay;
        }
    }

    birthYear.addEventListener("change", updateBirthDays);
    birthMonth.addEventListener("change", updateBirthDays);
    updateBirthDays();

    document.querySelectorAll(".password-toggle").forEach(function (button) {
        button.addEventListener("click", function () {
            var target = document.getElementById(button.dataset.target);
            var icon = button.querySelector("i");
            var isPassword = target.type === "password";

            target.type = isPassword ? "text" : "password";
            button.setAttribute("aria-label", isPassword ? "비밀번호 숨기기" : "비밀번호 표시");
            button.setAttribute("title", isPassword ? "비밀번호 숨기기" : "비밀번호 표시");
            icon.className = isPassword ? "fa fa-eye-slash" : "fa fa-eye";
        });
    });

    document.getElementById("emailDomain").addEventListener("change", function () {
        var mail2 = document.getElementById("mail2");
        var selectedDomain = this.value;

        mail2.value = selectedDomain;
        mail2.readOnly = selectedDomain !== "";

        if (selectedDomain === "") {
            mail2.focus();
        }
    });

    document.getElementById("phone").addEventListener("input", function () {
        var digits = this.value.replace(/[^0-9]/g, "").slice(0, 11);

        if (digits.length <= 3) {
            this.value = digits;
        } else if (digits.length <= 7) {
            this.value = digits.slice(0, 3) + "-" + digits.slice(3);
        } else {
            this.value = digits.slice(0, 3) + "-" + digits.slice(3, 7) + "-" + digits.slice(7);
        }
    });
});

function openAddressSearch() {

    if (!window.kakao || !window.kakao.Postcode) {
        alert("주소 검색 서비스를 불러오지 못했습니다. 잠시 후 다시 시도해주세요.");
        return;
    }

    new kakao.Postcode({
        oncomplete: function (data) {
            var basicAddress = data.userSelectedType === "R"
                    ? data.roadAddress
                    : data.jibunAddress;

            document.getElementById("postcode").value = data.zonecode;
            document.getElementById("roadAddress").value = basicAddress;
            document.getElementById("detailAddress").focus();
        }
    }).open({
        popupTitle: "ILLYA 주소 검색"
    });
}

function checkForm() {

    var id = document.getElementById("id").value.trim();

    var password =
        document.getElementById("password").value;

    var passwordConfirm =
        document.getElementById("password_confirm").value;

    var name =
        document.getElementById("name").value.trim();

    var birthYear =
        document.getElementById("birthYear").value;

    var birthMonth =
        document.getElementById("birthMonth").value;

    var birthDay =
        document.getElementById("birthDay").value;

    var mail1 =
        document.getElementById("mail1").value.trim();

    var mail2 =
        document.getElementById("mail2").value;

    var phone =
        document.getElementById("phone").value.trim();

    var roadAddress =
        document.getElementById("roadAddress").value.trim();

    var detailAddress =
        document.getElementById("detailAddress").value.trim();


    // 아이디
    var idPattern = /^[A-Za-z0-9_]{4,20}$/;

    if (!idPattern.test(id)) {

        alert("아이디는 4~20자의 영문, 숫자, _만 사용할 수 있습니다.");

        document.getElementById("id").focus();

        return false;
    }


    // 비밀번호
    if (password.length < 8 || password.length > 20) {

        alert("비밀번호는 8~20자로 입력해주세요.");

        document.getElementById("password").focus();

        return false;
    }


    // 영문 + 숫자
    var passwordPattern =
        /^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]+$/;

    if (!passwordPattern.test(password)) {

        alert("비밀번호는 영문과 숫자를 포함해야 합니다.");

        document.getElementById("password").focus();

        return false;
    }


    // 비밀번호 확인
    if (password !== passwordConfirm) {

        alert("비밀번호가 일치하지 않습니다.");

        document.getElementById("password_confirm").focus();

        return false;
    }


    // 이름
    if (name.length < 2) {

        alert("성명을 올바르게 입력해주세요.");

        document.getElementById("name").focus();

        return false;
    }


    // 생년월일
    if (birthYear === "" || birthMonth === "" || birthDay === "") {

        alert("생년월일을 선택해주세요.");

        document.getElementById("birthYear").focus();

        return false;
    }

    document.getElementById("birth").value =
        birthYear + "-" + birthMonth + "-" + birthDay;


    // 이메일
    if (mail1.length === 0 || mail2 === "") {

        alert("이메일을 올바르게 입력해주세요.");

        return false;
    }


    // 전화번호
    var phonePattern =
        /^010-[0-9]{4}-[0-9]{4}$/;

    if (!phonePattern.test(phone)) {

        alert("전화번호는 010-1234-5678 형식으로 입력해주세요.");

        document.getElementById("phone").focus();

        return false;
    }


    // 주소
    if (roadAddress === "") {

        alert("주소 찾기 버튼을 눌러 기본주소를 선택해주세요.");

        document.querySelector(".address-search-button").focus();

        return false;
    }

    var fullAddress = roadAddress;

    if (detailAddress !== "") {
        fullAddress += " " + detailAddress;
    }

    if (fullAddress.length > 100) {

        alert("주소는 100자 이내로 입력해주세요.");

        document.getElementById("detailAddress").focus();

        return false;
    }

    document.getElementById("address").value = fullAddress;


    return true;
}

</script>

</body>
</html>
