<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="dao.MemberDAO" %>

<%
request.setCharacterEncoding("UTF-8");


// =====================================================
// 로그인 확인
// =====================================================

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


// =====================================================
// 비밀번호 가져오기
// =====================================================

String password =
        request.getParameter("password");

if (password == null ||
    password.trim().isEmpty()) {
%>

<script>
    alert("비밀번호를 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 계정 삭제
// =====================================================

MemberDAO dao = new MemberDAO();

boolean result =
        dao.deleteMember(userID, password);


// =====================================================
// 결과
// =====================================================

if (result) {

    // 현재 로그인 세션 삭제
    session.invalidate();
%>

<script>
    alert("계정이 삭제되었습니다.");
    location.href = "productsu.jsp";
</script>

<%
} else {
%>

<script>
    alert("비밀번호가 올바르지 않거나 계정 삭제에 실패했습니다.");
    history.back();
</script>

<%
}
%>
