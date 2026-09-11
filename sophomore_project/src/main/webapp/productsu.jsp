<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%
    String contextPath = request.getContextPath();
    String searchKeyword = request.getParameter("searchKeyword");
    boolean hasSearch = searchKeyword != null && !searchKeyword.trim().isEmpty();

    ProductRepository dao = ProductRepository.getInstance();
    ArrayList<Product> listOfProducts = hasSearch
        ? dao.searchProducts(searchKeyword.trim())
        : dao.getAllProducts();

    DecimalFormat priceFormat = new DecimalFormat("#,###");
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>상품 목록 | ILLYA</title>
    <link href="<%=contextPath%>/css/myStyle.css" rel="stylesheet">
    <link href="<%=contextPath%>/css/product.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="상품 목록" data-en="Shop">상품 목록</h1>
            <p data-i18n data-ko="ILLYA가 고른 상품을 만나보세요." data-en="Discover ILLYA's selected products.">ILLYA가 고른 상품을 만나보세요.</p>
        </div>
    </section>

    <main class="shop-page product-list-page">
        <div class="container">
            <div class="product-list-toolbar">
                <p class="product-list-count">
                    <% if (hasSearch) { %>
                        <span data-i18n data-ko="검색 결과" data-en="Search results">검색 결과</span>
                    <% } else { %>
                        <span data-i18n data-ko="전체 상품" data-en="All products">전체 상품</span>
                    <% } %>
                    <strong><%=listOfProducts.size()%></strong><span data-i18n data-ko="개" data-en="items">개</span>
                </p>

                <% if (hasSearch) { %>
                    <a href="<%=contextPath%>/productsu.jsp" class="product-clear-search">
                        <span data-i18n data-ko="전체 상품 보기" data-en="View all products">전체 상품 보기</span>
                    </a>
                <% } %>
            </div>

            <% if (listOfProducts.isEmpty()) { %>
                <section class="product-empty" aria-live="polite">
                    <i class="fa fa-search" aria-hidden="true"></i>
                    <p data-i18n data-ko="찾으시는 상품이 없습니다." data-en="No products matched your search.">찾으시는 상품이 없습니다.</p>
                    <a href="<%=contextPath%>/productsu.jsp" class="product-clear-search">
                        <span data-i18n data-ko="전체 상품 보기" data-en="View all products">전체 상품 보기</span>
                    </a>
                </section>
            <% } else { %>
                <div class="row">
                    <% for (Product product : listOfProducts) { %>
                        <div class="col-12 col-sm-6 col-lg-4 product-card-wrap">
                            <article class="product-card">
                                <a
                                    class="product-card-link"
                                    href="<%=contextPath%>/product.jsp?id=<%=product.getProductId()%>"
                                    aria-label="<%=product.getPname()%> 상세 보기">
                                    <div class="product-card-media">
                                        <img
                                            src="<%=contextPath%>/images/<%=product.getFilename()%>"
                                            alt="<%=product.getPname()%>">
                                    </div>
                                    <div class="product-card-content">
                                        <h2 class="product-card-name"><%=product.getPname()%></h2>
                                        <p class="product-card-price"><%=priceFormat.format(product.getUnitPrice())%><span class="product-price-unit" data-i18n data-ko="원" data-en="KRW">원</span></p>
                                        <span class="product-card-action">
                                            <span data-i18n data-ko="상품 보기" data-en="View product">상품 보기</span>
                                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                                        </span>
                                    </div>
                                </a>
                            </article>
                        </div>
                    <% } %>
                </div>
            <% } %>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>
