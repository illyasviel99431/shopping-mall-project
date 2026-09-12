<%@ page
    language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="dto.Product"%>
<%@ page import="java.util.ArrayList"%>

<%
    String userId =
            (String) session.getAttribute("userID");

    if (userId == null
            || userId.trim().isEmpty()) {
        response.sendRedirect("cookie.jsp");
        return;
    }

    String id =
            request.getParameter("id");

    String quantityValue =
            request.getParameter("quantity");

    int requestedQuantity = 0;

    try {
        requestedQuantity =
                Integer.parseInt(quantityValue);
    } catch (Exception e) {
        requestedQuantity = 0;
    }

    if (id == null
            || id.trim().isEmpty()
            || requestedQuantity <= 0) {
%>

<script>
    alert("수량은 1개 이상 선택해주세요.");
    location.href = "cart.jsp";
</script>

<%
        return;
    }

    ProductRepository dao =
            ProductRepository.getInstance();

    Product currentProduct =
            dao.getProductById(id);

    if (currentProduct == null
            || requestedQuantity > currentProduct.getUnitsInStock()) {
%>

<script>
    alert("현재 재고보다 많은 수량을 선택할 수 없습니다.");
    location.href = "cart.jsp";
</script>

<%
        return;
    }

    ArrayList<Product> cartList =
            (ArrayList<Product>) session.getAttribute("cartlist");

    boolean isUpdated = false;

    if (cartList != null) {
        for (Product cartProduct : cartList) {
            if (cartProduct.getProductId().equals(id)) {
                cartProduct.setQuantity(requestedQuantity);
                isUpdated = true;
                break;
            }
        }
    }

    if (!isUpdated) {
%>

<script>
    alert("장바구니에서 상품을 찾을 수 없습니다.");
    location.href = "cart.jsp";
</script>

<%
        return;
    }

    response.sendRedirect("cart.jsp");
%>
