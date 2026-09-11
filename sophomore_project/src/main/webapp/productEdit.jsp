<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%
    String userRole = (String) session.getAttribute("userRole");
    String contextPath = request.getContextPath();

    if (!"ADMIN".equals(userRole)) {
        response.sendRedirect(contextPath + "/productsu.jsp");
        return;
    }

    ArrayList<Product> products = ProductRepository.getInstance().getAllProducts();
    DecimalFormat priceFormat = new DecimalFormat("#,###");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 수정 | ILLYA 관리자</title>
    <link rel="stylesheet" href="<%=contextPath%>/css/admin-product.css">
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="상품 수정" data-en="Edit products">상품 수정</h1>
            <p data-i18n data-ko="수정할 상품을 선택하세요." data-en="Choose a product to update.">수정할 상품을 선택하세요.</p>
        </div>
    </section>

    <main class="admin-product-page">
        <div class="container">
            <div class="admin-product-toolbar">
                <h2 data-i18n data-ko="등록된 상품" data-en="Products">등록된 상품</h2>
                <p class="admin-product-count"><strong><%=products.size()%></strong><span data-i18n data-ko="개" data-en=" items">개</span></p>
            </div>

            <% if (products.isEmpty()) { %>
                <div class="admin-product-empty" data-i18n data-ko="등록된 상품이 없습니다." data-en="No products have been registered.">등록된 상품이 없습니다.</div>
            <% } else { %>
                <div class="row">
                    <% for (Product product : products) { %>
                    <div class="col-12 col-sm-6 col-lg-4 admin-product-card-wrap">
                        <article class="admin-product-card">
                            <div class="admin-product-image">
                                <img src="<%=contextPath%>/images/<%=product.getFilename()%>" alt="<%=product.getPname()%>">
                            </div>
                            <div class="admin-product-body">
                                <h2 class="admin-product-name"><%=product.getPname()%></h2>
                                <div class="admin-product-meta">
                                    <p class="admin-product-price"><%=priceFormat.format(product.getUnitPrice())%><span data-i18n data-ko="원" data-en=" KRW">원</span></p>
                                    <span class="admin-product-stock"><span data-i18n data-ko="재고" data-en="Stock">재고</span> <strong><%=priceFormat.format(product.getUnitsInStock())%></strong><span data-i18n data-ko="개" data-en=" units">개</span></span>
                                </div>
                                <a href="productEditForm.jsp?id=<%=product.getProductId()%>" class="admin-product-action admin-product-action-edit" data-i18n data-ko="상품 수정" data-en="Edit product">상품 수정</a>
                            </div>
                        </article>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
