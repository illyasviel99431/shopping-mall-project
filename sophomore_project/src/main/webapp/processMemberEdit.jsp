<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.Member" %>

<%
request.setCharacterEncoding("UTF-8");

// =====================================================
// 로그인 확인
// =====================================================

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


// =====================================================
// 기존 회원 정보 가져오기
// =====================================================

MemberDAO dao = new MemberDAO();

Member member = dao.getMemberById(userID);

if (member == null) {

    session.invalidate();
%>

<script>
    alert("회원 정보를 찾을 수 없습니다.");
    location.href = "cookie.jsp";
</script>

<%
    return;
}


// =====================================================
// 입력값
// =====================================================

String password =
        request.getParameter("password");

String passwordConfirm =
        request.getParameter("passwordConfirm");

String name =
        request.getParameter("name");

String gender =
        request.getParameter("gender");

String birth =
        request.getParameter("birth");

String email =
        request.getParameter("email");

String phone =
        request.getParameter("phone");

String address =
        request.getParameter("address");


// =====================================================
// null 검사
// =====================================================

if (name == null ||
    gender == null ||
    birth == null ||
    email == null ||
    phone == null ||
    address == null) {
%>

<script>
    alert("회원정보를 모두 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 공백 제거
// =====================================================

name = name.trim();
birth = birth.trim();
email = email.trim();
phone = phone.trim();
address = address.trim();


// =====================================================
// 이름 검사
// =====================================================

if (name.length() < 2 ||
    name.length() > 30) {
%>

<script>
    alert("이름을 올바르게 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 성별 검사
// =====================================================

if (!gender.equals("남") &&
    !gender.equals("여")) {
%>

<script>
    alert("성별을 올바르게 선택해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 생년월일 검사
// =====================================================

if (!birth.matches("\\d{4}-\\d{2}-\\d{2}")) {
%>

<script>
    alert("생년월일은 YYYY-MM-DD 형식으로 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 이메일 검사
// =====================================================

if (!email.matches(
        "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
)) {
%>

<script>
    alert("이메일 형식이 올바르지 않습니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 전화번호 검사
// =====================================================

if (!phone.matches("010-[0-9]{4}-[0-9]{4}")) {
%>

<script>
    alert("전화번호는 010-1234-5678 형식으로 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 주소 검사
// =====================================================

if (address.length() == 0 ||
    address.length() > 100) {
%>

<script>
    alert("주소를 올바르게 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 이메일 중복 검사
// =====================================================

if (dao.existsEmailExcept(email, userID)) {
%>

<script>
    alert("이미 사용 중인 이메일입니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 전화번호 중복 검사
// =====================================================

if (dao.existsPhoneExcept(phone, userID)) {
%>

<script>
    alert("이미 사용 중인 전화번호입니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 비밀번호 처리
// =====================================================

String newPassword = member.getPassword();


// 새 비밀번호를 입력했다면 변경
if (password != null &&
    !password.trim().isEmpty()) {

    if (password.length() < 8 ||
        password.length() > 20) {
%>

<script>
    alert("비밀번호는 8~20자로 입력해주세요.");
    history.back();
</script>

<%
        return;
    }


    if (!password.matches(
            "^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]+$"
    )) {
%>

<script>
    alert("비밀번호는 영문과 숫자를 포함해야 합니다.");
    history.back();
</script>

<%
        return;
    }


    if (passwordConfirm == null ||
        !password.equals(passwordConfirm)) {
%>

<script>
    alert("새 비밀번호가 일치하지 않습니다.");
    history.back();
</script>

<%
        return;
    }

    newPassword = password;
}


// =====================================================
// Member 객체 갱신
// =====================================================

member.setPassword(newPassword);
member.setName(name);
member.setGender(gender);
member.setBirth(birth);
member.setEmail(email);
member.setPhone(phone);
member.setAddress(address);


// =====================================================
// DB 수정
// =====================================================

boolean result =
        dao.updateMember(member);

if (result) {
    response.sendRedirect("memberEditSuccess.jsp");
    return;
} else {
%>

<script>
    alert("회원정보 수정에 실패했습니다.");
    history.back();
</script>

<%
}
%>
