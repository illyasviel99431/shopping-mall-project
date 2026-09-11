<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.Member" %>

<%
request.setCharacterEncoding("UTF-8");

String userId = request.getParameter("id");
String userPassword = request.getParameter("passwd");


// 입력값 검사
if (userId == null || userId.trim().isEmpty()
        || userPassword == null || userPassword.trim().isEmpty()) {
%>

<script>
    alert("아이디와 비밀번호를 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// 로그인 처리
MemberDAO memberDAO = new MemberDAO();

Member member = memberDAO.login(userId, userPassword);


// 로그인 실패
if (member == null) {
%>

<script>
    alert("아이디 또는 비밀번호가 틀렸습니다.");
    history.back();
</script>

<%
    return;
}


// ==================================================
// 로그인 성공
// ==================================================

// 세션에 로그인 정보 저장
session.setAttribute("userID", member.getId());
session.setAttribute("userRole", member.getRole());


// 로그인 성공 후 상품 페이지로 이동
response.sendRedirect("productsu.jsp");

%>