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


    if (id == null
            || id.trim().isEmpty()) {

        response.sendRedirect("productsu.jsp");

        return;
    }


    ProductRepository dao =
            ProductRepository.getInstance();


    Product product =
            dao.getProductById(id);


    if (product == null) {

        response.sendRedirect(
                "exceptionNoProductId.jsp"
        );

        return;
    }


    // 실제 DB 재고 확인
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

            // 장바구니에 넣을 때는 DB 재고를 차감하지 않는다.
            // 결제하기를 눌렀을 때만 차감한다.

            if (cartProduct.getQuantity() + 1
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
                    cartProduct.getQuantity() + 1
            );

            exists = true;

            break;
        }
    }


    if (!exists) {

        product.setQuantity(1);

        cartList.add(product);
    }


    response.sendRedirect("cart.jsp");
%>