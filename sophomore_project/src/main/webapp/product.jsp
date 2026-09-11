<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<%
    String contextPath = request.getContextPath();
    String id = request.getParameter("id");

    if (id == null || id.trim().isEmpty()) {
        response.sendRedirect(contextPath + "/productsu.jsp");
        return;
    }

    ProductRepository dao = ProductRepository.getInstance();
    Product product = dao.getProductById(id);

    if (product == null) {
        response.sendRedirect(contextPath + "/exceptionNoProductId.jsp");
        return;
    }

    DecimalFormat priceFormat = new DecimalFormat("#,###");
    boolean isSoldOut = product.getUnitsInStock() <= 0;
    boolean hasDescription = product.getDescription() != null && !product.getDescription().trim().isEmpty();
    boolean hasCategory = product.getCategory() != null && !product.getCategory().trim().isEmpty();
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=product.getPname()%> | ILLYA</title>
    <link href="<%=contextPath%>/css/myStyle.css" rel="stylesheet">
    <link href="<%=contextPath%>/css/product.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="menu.jsp" />

    <main class="product-detail-page">
        <div class="container">
            <nav class="product-breadcrumb" aria-label="상품 경로">
                <a href="<%=contextPath%>/productsu.jsp" class="product-back-link">
                    <i class="fa fa-arrow-left mr-2" aria-hidden="true"></i>
                    <span data-i18n data-ko="상품 목록" data-en="Shop">상품 목록</span>
                </a>
                <span class="product-breadcrumb-current"><%=product.getPname()%></span>
            </nav>

            <section class="product-detail-shell">
                <div class="row no-gutters align-items-stretch">
                    <div class="col-lg-6">
                        <div class="product-gallery">
                            <div class="product-image-stage">
                                <img
                                    src="<%=contextPath%>/images/<%=product.getFilename()%>"
                                    alt="<%=product.getPname()%>">
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <section class="product-purchase-panel" aria-labelledby="productName">
                            <% if (hasCategory) { %>
                                <p class="product-detail-category"><%=product.getCategory()%></p>
                            <% } %>

                            <h1 id="productName" class="product-detail-name"><%=product.getPname()%></h1>

                            <% if (hasDescription) { %>
                                <p class="product-detail-description"><%=product.getDescription()%></p>
                            <% } %>

                            <div class="product-price-box" aria-label="상품 가격">
                                <span class="product-detail-price"><%=priceFormat.format(product.getUnitPrice())%></span>
                                <span class="product-price-unit" data-i18n data-ko="원" data-en="KRW">원</span>
                            </div>

                            <dl class="product-specs">
                                <div class="product-specs-row">
                                    <dt data-i18n data-ko="브랜드" data-en="Brand">브랜드</dt>
                                    <dd><%=product.getManufacturer()%></dd>
                                </div>
                                <div class="product-specs-row">
                                    <dt data-i18n data-ko="상품 번호" data-en="Product code">상품 번호</dt>
                                    <dd><%=product.getProductId()%></dd>
                                </div>
                                <div class="product-specs-row">
                                    <dt data-i18n data-ko="재고" data-en="Stock">재고</dt>
                                    <dd class="<%=isSoldOut ? "product-stock-soldout" : "product-stock-available"%>">
                                        <strong class="product-stock-count"><%=priceFormat.format(product.getUnitsInStock())%></strong><span data-i18n data-ko="개" data-en=" units">개</span>
                                        <% if (isSoldOut) { %>
                                            <span class="product-stock-status" data-i18n data-ko=" · 품절" data-en=" · Sold out"> · 품절</span>
                                        <% } else { %>
                                            <span class="product-stock-status" data-i18n data-ko=" · 구매 가능" data-en=" · In stock"> · 구매 가능</span>
                                        <% } %>
                                    </dd>
                                </div>
                            </dl>

                            <div class="product-purchase-actions">
                                <button
                                    type="button"
                                    class="product-cart-button"
                                    onclick="addToCart('<%=product.getProductId()%>')"
                                    <%=isSoldOut ? "disabled" : ""%>>
                                    <i class="fa fa-shopping-bag" aria-hidden="true"></i>
                                    <span data-i18n data-ko="장바구니 담기" data-en="Add to cart">장바구니 담기</span>
                                </button>
                                <a href="<%=contextPath%>/productsu.jsp" class="product-back-link">
                                    <span data-i18n data-ko="목록" data-en="Back">목록</span>
                                </a>
                            </div>
                        </section>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <%@ include file="footer.jsp" %>

    <script>
        function addToCart(id) {
            var isEnglish = document.documentElement.lang === "en";
            var message = isEnglish
                ? "Add this product to your cart?"
                : "이 상품을 장바구니에 담을까요?";

            if (window.confirm(message)) {
                window.location.href = "<%=contextPath%>/addCart.jsp?id=" + encodeURIComponent(id);
            }
        }
    </script>
</body>
</html>
