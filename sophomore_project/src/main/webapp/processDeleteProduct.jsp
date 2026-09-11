<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dao.ProductRepository" %>


<%
    // 관리자 확인
    String deleteUserRole =
            (String) session.getAttribute("userRole");


    if (!"ADMIN".equals(deleteUserRole)) {
%>

<script>
    alert("관리자만 접근할 수 있습니다.");
    location.href = "productsu.jsp";
</script>

<%
        return;
    }


    // 상품 ID
    String productId =
            request.getParameter("id");


    if (productId == null ||
        productId.trim().isEmpty()) {
%>

<script>
    alert("상품 정보가 없습니다.");
    location.href = "deleteproduct.jsp";
</script>

<%
        return;
    }


    // 삭제
    ProductRepository dao =
            ProductRepository.getInstance();

    dao.deleteProduct(productId);


    // 삭제 완료
    response.sendRedirect(
            "deleteproduct.jsp"
    );
%>