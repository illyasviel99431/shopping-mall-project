<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>
<%@ page import="java.util.ArrayList"%>

<%
    String userID =
            (String) session.getAttribute("userID");


    if (userID == null
            || userID.trim().isEmpty()) {

        response.sendRedirect("cookie.jsp");

        return;
    }


    String id =
            request.getParameter("id");

    String quantityValue =
            request.getParameter("quantity");


    if (id == null
            || id.trim().isEmpty()) {

        response.sendRedirect("productsu.jsp");

        return;
    }


    ProductRepository dao =
            ProductRepository.getInstance();

    int requestedQuantity = 1;

    try {
        if (quantityValue != null
                && !quantityValue.trim().isEmpty()) {
            requestedQuantity =
                    Integer.parseInt(quantityValue);
        }
    } catch (NumberFormatException e) {
        requestedQuantity = 0;
    }

    if (requestedQuantity <= 0) {
%>

<script>
    alert("수량은 1개 이상 선택해주세요.");
    history.back();
</script>

<%
        return;
    }


    Product product =
            dao.getProductById(id);


    if (product == null) {

        response.sendRedirect(
                "exceptionNoProductId.jsp"
        );

        return;
    }


    if (product.getUnitsInStock() <= 0) {
%>

<script>

alert("재고가 없습니다.");

history.back();

</script>

<%
        return;
    }


    ArrayList<Product> cartList =
            (ArrayList<Product>)
                    session.getAttribute(
                            "cartlist"
                    );


    if (cartList == null) {

        cartList =
                new ArrayList<Product>();

        session.setAttribute(
                "cartlist",
                cartList
        );
    }


    boolean exists = false;


    for (Product cartProduct : cartList) {

        if (cartProduct
                .getProductId()
                .equals(id)) {

            if (cartProduct.getQuantity() + requestedQuantity
                    > product.getUnitsInStock()) {
%>

<script>

alert(
    "현재 재고보다 많은 수량을 담을 수 없습니다."
);

history.back();

</script>

<%
                return;
            }


            cartProduct.setQuantity(
                    cartProduct.getQuantity() + requestedQuantity
            );

            exists = true;

            break;
        }
    }


    if (!exists) {

        if (requestedQuantity > product.getUnitsInStock()) {
%>

<script>
    alert("현재 재고보다 많은 수량을 담을 수 없습니다.");
    history.back();
</script>

<%
            return;
        }

        product.setQuantity(requestedQuantity);

        cartList.add(product);
    }


    response.sendRedirect("cart.jsp");
%>
