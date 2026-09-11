<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dto.Product"%>
<%@ page import="java.util.ArrayList"%>

<%
    String id =
            request.getParameter("id");


    if (id == null
            || id.trim().isEmpty()) {

        response.sendRedirect("cart.jsp");

        return;
    }


    ArrayList<Product> cartList =
            (ArrayList<Product>)
                    session.getAttribute(
                            "cartlist"
                    );


    if (cartList != null) {

        for (int i = 0;
                i < cartList.size();
                i++) {

            Product product =
                    cartList.get(i);


            if (product
                    .getProductId()
                    .equals(id)) {

                cartList.remove(i);

                break;
            }
        }
    }


    response.sendRedirect("cart.jsp");
%>