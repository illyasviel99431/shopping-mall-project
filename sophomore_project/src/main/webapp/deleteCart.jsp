<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dto.Product"%>
<%@ page import="java.util.ArrayList"%>

<%
    ArrayList<Product> cartList =
            (ArrayList<Product>)
                    session.getAttribute(
                            "cartlist"
                    );


    if (cartList != null) {

        cartList.clear();
    }


    response.sendRedirect("cart.jsp");
%>