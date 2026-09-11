<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.Member" %>
<%
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

    String memberName = member.getName() == null ? "" : member.getName();
    String profileInitial = memberName.isEmpty() ? "I" : memberName.substring(0, 1);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 프로필 | ILLYA</title>
    <style>
        .profile-layout { display: grid; grid-template-columns: 258px minmax(0, 1fr); gap: 0; overflow: hidden; }
        .profile-identity { padding: 35px 24px; background: #20242a; color: #fff; text-align: center; }
        .profile-avatar { display: inline-flex; align-items: center; justify-content: center; width: 76px; height: 76px; margin-bottom: 17px; border: 3px solid rgba(255, 190, 51, .65); border-radius: 50%; background: #2d333b; color: #ffbe33; font-size: 30px; font-weight: 900; }
        .profile-identity h2 { margin: 0 0 6px; color: #fff; font-size: 22px; font-weight: 800; }
        .profile-id { margin: 0; color: rgba(255, 255, 255, .62); font-size: 13px; }
        .profile-id i { margin-right: 5px; color: #ffbe33; }
        .profile-menu { display: grid; gap: 8px; margin-top: 29px; padding-top: 24px; border-top: 1px solid rgba(255, 255, 255, .15); text-align: left; }
        .profile-menu a { display: flex; align-items: center; gap: 10px; min-height: 43px; padding: 0 13px; border: 1px solid rgba(255, 255, 255, .16); border-radius: 8px; background: rgba(255, 255, 255, .04); color: #fff !important; font-size: 13px; font-weight: 800; text-decoration: none; transition: .2s ease; }
        .profile-menu a i { width: 17px; color: #ffbe33; text-align: center; }
        .profile-menu a:hover { border-color: #ffbe33; background: rgba(255, 190, 51, .12); color: #fff !important; transform: translateY(-1px); }
        .profile-details { padding: 0 31px 29px; }
        .profile-details-title { display: flex; align-items: center; min-height: 87px; }
        .profile-details-title h2 { margin: 0; color: #202124; font-size: 22px; font-weight: 900; }
        .profile-table-wrap { overflow-x: auto; border: 1px solid #e1e5e9; border-radius: 12px; }
        .profile-table { width: 100%; min-width: 520px; border-collapse: separate; border-spacing: 0; }
        .profile-table th, .profile-table td { padding: 17px 19px; border-bottom: 1px solid #e9edf0; text-align: left; vertical-align: middle; }
        .profile-table tr:last-child th, .profile-table tr:last-child td { border-bottom: 0; }
        .profile-table th { width: 145px; background: #f7f8fa; color: #69727c; font-size: 13px; font-weight: 900; }
        .profile-table td { overflow-wrap: anywhere; color: #292d32; font-size: 14px; font-weight: 700; }
        .profile-actions { display: flex; flex-wrap: wrap; gap: 9px; padding-top: 24px; }
        .profile-actions .shop-btn-danger { margin-left: auto; }
        @media (max-width: 767px) {
            .profile-layout { grid-template-columns: 1fr; }
            .profile-identity { padding: 29px 21px; }
            .profile-menu { grid-template-columns: repeat(3, minmax(0, 1fr)); }
            .profile-menu a { justify-content: center; padding: 0 8px; }
            .profile-menu a i { display: none; }
            .profile-details { padding: 0 20px 25px; }
            .profile-details-title { min-height: 76px; }
            .profile-table th, .profile-table td { padding: 15px 16px; }
            .profile-actions a { width: 100%; }
            .profile-actions .shop-btn-danger { margin-left: 0; }
        }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="내 프로필" data-en="My profile">내 프로필</h1>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <div class="shop-surface profile-layout">
                <aside class="profile-identity">
                    <div class="profile-avatar"><%=profileInitial%></div>
                    <h2><%=memberName%></h2>
                    <p class="profile-id"><i class="fa fa-user-circle-o" aria-hidden="true"></i><%=member.getId()%></p>
                    <nav class="profile-menu" aria-label="프로필 메뉴">
                        <a href="productsu.jsp"><i class="fa fa-shopping-bag" aria-hidden="true"></i><span data-i18n data-ko="상품 둘러보기" data-en="Shop products">상품 둘러보기</span></a>
                        <a href="cart.jsp"><i class="fa fa-shopping-cart" aria-hidden="true"></i><span data-i18n data-ko="장바구니" data-en="Your cart">장바구니</span></a>
                        <a href="cookie_out.jsp"><i class="fa fa-sign-out" aria-hidden="true"></i><span data-i18n data-ko="로그아웃" data-en="Sign out">로그아웃</span></a>
                    </nav>
                </aside>

                <section class="profile-details">
                    <div class="profile-details-title">
                        <h2 data-i18n data-ko="회원 정보" data-en="Account details">회원 정보</h2>
                    </div>
                    <div class="profile-table-wrap">
                        <table class="profile-table">
                            <tbody>
                                <tr><th scope="row" data-i18n data-ko="아이디" data-en="User ID">아이디</th><td><%=member.getId()%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="이름" data-en="Name">이름</th><td><%=memberName%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="성별" data-en="Gender">성별</th><td><%=member.getGender() == null ? "" : member.getGender()%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="생년월일" data-en="Date of birth">생년월일</th><td><%=member.getBirth() == null ? "" : member.getBirth()%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="이메일" data-en="Email">이메일</th><td><%=member.getEmail() == null ? "" : member.getEmail()%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="전화번호" data-en="Phone">전화번호</th><td><%=member.getPhone() == null ? "" : member.getPhone()%></td></tr>
                                <tr><th scope="row" data-i18n data-ko="주소" data-en="Address">주소</th><td><%=member.getAddress() == null ? "" : member.getAddress()%></td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="profile-actions">
                        <a href="productsu.jsp" class="shop-btn-outline" data-i18n data-ko="상품 목록" data-en="Shop">상품 목록</a>
                        <a href="memberEdit.jsp" class="shop-btn-primary" data-i18n data-ko="프로필 수정" data-en="Edit profile">프로필 수정</a>
                        <a href="memberDelete.jsp" class="shop-btn-danger" data-i18n data-ko="계정 삭제" data-en="Delete account">계정 삭제</a>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
