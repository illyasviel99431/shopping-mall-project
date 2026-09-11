<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.Connection" %>
<%@ page import="dao.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>DB Test</title>
</head>

<body>

<h2>Oracle DB 연결 테스트</h2>

<%
    Connection conn = null;

    try {

        conn = DBConnection.getConnection();

        out.println("<h3>Oracle DB 연결 성공!</h3>");

    } catch (Exception e) {

        out.println("<h3>Oracle DB 연결 실패!</h3>");

        out.println("<pre>");
        e.printStackTrace(
                new java.io.PrintWriter(out)
        );
        out.println("</pre>");

    } finally {

        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
%>

</body>
</html>