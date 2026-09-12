<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%
    Connection conn = null;

    try {
        Class.forName("oracle.jdbc.OracleDriver");
		
        String url = "jdbc:oracle:thin:@localhost:1521:xe";
        
        // 자신의 오라클 아이디랑 비밀번호로 바꾸세요
        String user = "system";
        String password = "oracle";

        conn = DriverManager.getConnection(url, user, password);

        out.println("Oracle DB 연결 성공!");

    } catch (Exception e) {
        out.println("Oracle DB 연결 실패!");
        e.printStackTrace();
    }
%>