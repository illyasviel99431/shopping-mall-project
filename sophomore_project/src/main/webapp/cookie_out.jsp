<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    Cookie idCookie = new Cookie("userID", "");
    idCookie.setMaxAge(0);
    response.addCookie(idCookie);

    Cookie roleCookie = new Cookie("userRole", "");
    roleCookie.setMaxAge(0);
    response.addCookie(roleCookie);

    // 세션 삭제
    session.invalidate();

    response.sendRedirect("productsu.jsp");
%>