<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="dao.MemberDAO" %>
<%@ page import="dto.Member" %>

<%
request.setCharacterEncoding("UTF-8");

// =====================================================
// 입력값 가져오기
// =====================================================

String id = request.getParameter("id");
String password = request.getParameter("password");
String passwordConfirm = request.getParameter("password_confirm");
String name = request.getParameter("name");
String birth = request.getParameter("birth");
String gender = request.getParameter("gender");

String mail1 = request.getParameter("mail1");
String mail2 = request.getParameter("mail2");

String phone = request.getParameter("phone");
String address = request.getParameter("address");


// =====================================================
// null 검사
// =====================================================

if (id == null ||
    password == null ||
    passwordConfirm == null ||
    name == null ||
    birth == null ||
    gender == null ||
    mail1 == null ||
    mail2 == null ||
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

id = id.trim();
name = name.trim();
mail1 = mail1.trim();
mail2 = mail2.trim();
phone = phone.trim();
address = address.trim();


// =====================================================
// 아이디 검사
// =====================================================

if (!id.matches("[A-Za-z0-9_]{4,20}")) {
%>

<script>
    alert("아이디는 4~20자의 영문, 숫자, _만 사용할 수 있습니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 비밀번호 검사
// =====================================================

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


// 영문 + 숫자 포함
if (!password.matches("^(?=.*[A-Za-z])(?=.*[0-9])[A-Za-z0-9]+$")) {
%>

<script>
    alert("비밀번호는 영문과 숫자를 포함해야 합니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 비밀번호 확인
// =====================================================

if (!password.equals(passwordConfirm)) {
%>

<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 이름 검사
// =====================================================

if (name.length() < 2 ||
    name.length() > 30) {
%>

<script>
    alert("성명을 올바르게 입력해주세요.");
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
    alert("성별을 선택해주세요.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 이메일 검사
// =====================================================

if (mail1.length() == 0 ||
    mail2.length() == 0) {
%>

<script>
    alert("이메일을 올바르게 입력해주세요.");
    history.back();
</script>

<%
    return;
}


// 이메일 앞부분 기본 형식 검사
if (!mail1.matches("[A-Za-z0-9._%+-]{1,20}")) {
%>

<script>
    alert("이메일을 올바르게 입력해주세요.");
    history.back();
</script>

<%
    return;
}

String email = mail1 + "@" + mail2;


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
// Member 객체 생성
// =====================================================

Member member = new Member();

member.setId(id);
member.setPassword(password);
member.setName(name);
member.setGender(gender);
member.setBirth(birth);
member.setEmail(email);
member.setPhone(phone);
member.setAddress(address);


// =====================================================
// DB 처리
// =====================================================

MemberDAO dao = new MemberDAO();


// =====================================================
// 아이디 중복 검사
// =====================================================

if (dao.existsId(id)) {
%>

<script>
    alert("이미 사용 중인 아이디입니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 이메일 중복 검사
// =====================================================

if (dao.existsEmail(email)) {
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

if (dao.existsPhone(phone)) {
%>

<script>
    alert("이미 등록된 전화번호입니다.");
    history.back();
</script>

<%
    return;
}


// =====================================================
// 회원가입
// =====================================================

boolean result = dao.insertMember(member);


// =====================================================
// 성공
// =====================================================

if (result) {
%>

<script>
    location.href = "registerSuccess.jsp";
</script>

<%
    return;
}


// =====================================================
// 실패
// =====================================================

else {
%>

<script>
    alert("회원가입에 실패했습니다.");
    history.back();
</script>

<%
}
%>
