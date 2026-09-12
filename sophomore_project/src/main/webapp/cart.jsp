<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
<%
    String userID = (String) session.getAttribute("userID");

    if (userID == null || userID.trim().isEmpty()) {
        response.sendRedirect("cookie.jsp");
        return;
    }

    int sum = 0;
    DecimalFormat df = new DecimalFormat("#,###");
    ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
    if (cartList == null) cartList = new ArrayList<Product>();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>장바구니 | ILLYA</title>
<style>
    		.cart-surface {
			overflow: hidden;
		}
		.cart-table {
			width: 100%;
			margin: 0;
			border-collapse: collapse;
		}
		.cart-table th {
			padding: 17px 20px;
			background: #f8f9fa;
			color: #7a818b;
			font-size: 12px;
			font-weight: 800;
			letter-spacing: .3px;
		}
		.cart-table td {
			padding: 20px;
			border-top: 1px solid #edf0f2;
			vertical-align: middle;
			font-size: 14px;
		}
		.cart-product-id {
			color: #8a919a;
			font-size: 12px;
		}
		.cart-product-name {
			color: #202124;
			font-weight: 800;
		}
		.cart-price {
			color: #363a40;
			font-weight: 700;
		}
		.cart-total {
			color: #e23a48;
			font-size: 16px;
			font-weight: 900;
		}
		.cart-quantity-form {
			display: inline-flex;
			align-items: center;
			gap: 6px;
		}
		.cart-quantity-input {
			width: 62px;
			height: 36px;
			padding: 0 6px;
			border: 1px solid #cfd5da;
			border-radius: 5px;
			color: #2e3339;
			font-weight: 700;
			text-align: center;
		}
		.cart-quantity-input:focus {
			border-color: #ffbe33;
			outline: 0;
		}
		.cart-quantity-button {
			height: 36px;
			padding: 0 10px;
			border: 1px solid #343a40;
			border-radius: 5px;
			background: #343a40;
			color: #fff;
			font-size: 12px;
			font-weight: 800;
			cursor: pointer;
			transition: .2s;
		}
		.cart-quantity-button:hover {
			border-color: #ffbe33;
			background: #ffbe33;
			color: #1d2025;
		}
		.cart-remove {
			color: #9aa1a9;
			font-size: 18px;
			transition: .2s;
		}
		.cart-remove:hover {
			color: #e5484d;
		}
		.cart-summary {
			display: flex;
			align-items: center;
			justify-content: flex-end;
			gap: 24px;
			padding: 23px 28px;
			border-top: 1px solid #e8ebee;
			background: #fff7f7;
		}
		.cart-summary-label {
			color: #737a83;
			font-size: 13px;
			font-weight: 700;
		}
		.cart-summary-price {
			color: #e23a48;
			font-size: 25px;
			font-weight: 900;
			letter-spacing: -1px;
		}
		.cart-actions {
			display: flex;
			align-items: center;
			justify-content: space-between;
			gap: 16px;
			margin-top: 20px;
		}
		.cart-actions-right {
			display: flex;
			gap: 9px;
		}
		.cart-empty {
			padding: 80px 20px;
			text-align: center;
		}
		.cart-empty-icon {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 64px;
			height: 64px;
			margin-bottom: 16px;
			border-radius: 50%;
			background: #fff7e3;
			color: #dd920d;
			font-size: 27px;
		}
		.cart-empty h2 {
			margin: 0 0 8px;
			font-size: 22px;
			font-weight: 800;
		}
		.cart-empty p {
			margin-bottom: 23px;
			color: #777e87;
		}
		@media (max-width: 767px) {
			.cart-table thead {
				display: none;
			}
			.cart-table,
			.cart-table tbody,
			.cart-table tr,
			.cart-table td {
				display: block;
				width: 100%;
			}
			.cart-table tr {
				position: relative;
				padding: 16px 20px;
				border-top: 1px solid #edf0f2;
			}
			.cart-table td {
				padding: 4px 0;
				border: 0;
			}
			.cart-table td:first-child {
				position: absolute;
				top: 14px;
				right: 18px;
				width: auto;
			}
			.cart-table td:nth-child(2) {
				padding-right: 35px;
			}
			.cart-summary {
				padding: 20px;
			}
			.cart-actions,
			.cart-actions-right {
				flex-direction: column;
				align-items: stretch;
				width: 100%;
			}
			.cart-actions a {
				width: 100%;
			}
		}
</style>
<script>
    function deleteCart() {
        if (confirm("장바구니의 모든 상품을 삭제하시겠습니까?")) {
            location.href = "deleteCart.jsp";
        }
    }
</script>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="장바구니" data-en="Your cart">장바구니</h1>
            <p data-i18n data-ko="마음에 담은 상품을 확인하고 주문을 준비하세요." data-en="Review your selections before checkout.">마음에 담은 상품을 확인하고 주문을 준비하세요.</p>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <div class="shop-surface cart-surface">
                <% if (cartList.isEmpty()) { %>
                    <div class="cart-empty">
                        <div class="cart-empty-icon"><i class="fa fa-shopping-bag" aria-hidden="true"></i></div>
                        <h2 data-i18n data-ko="장바구니가 비어 있어요" data-en="Your cart is empty">장바구니가 비어 있어요</h2>
                        <p data-i18n data-ko="새로운 취향을 발견하러 상품 목록으로 가볼까요?" data-en="Discover something you will love in our shop.">새로운 취향을 발견하러 상품 목록으로 가볼까요?</p>
                        <a href="productsu.jsp" class="shop-btn-primary" data-i18n data-ko="상품 둘러보기" data-en="Explore products">상품 둘러보기</a>
                    </div>
                <% } else { %>
                    <div class="table-responsive">
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th scope="col"><span data-i18n data-ko="삭제" data-en="Remove">삭제</span></th>
                                    <th scope="col"><span data-i18n data-ko="상품" data-en="Product">상품</span></th>
                                    <th scope="col"><span data-i18n data-ko="상품명" data-en="Item">상품명</span></th>
                                    <th scope="col" class="text-right"><span data-i18n data-ko="단가" data-en="Price">단가</span></th>
                                    <th scope="col" class="text-center"><span data-i18n data-ko="수량" data-en="Qty">수량</span></th>
                                    <th scope="col" class="text-right"><span data-i18n data-ko="소계" data-en="Subtotal">소계</span></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (int i = 0; i < cartList.size(); i++) {
                                    Product product = cartList.get(i);
                                    int total = product.getUnitPrice() * product.getQuantity();
                                    sum += total;
                                %>
                                <tr>
                                    <td>
                                        <a href="removeCart.jsp?id=<%=product.getProductId()%>" class="cart-remove" aria-label="상품 삭제">
                                            <i class="fa fa-times-circle-o" aria-hidden="true"></i>
                                        </a>
                                    </td>
                                    <td class="cart-product-id"><%=product.getProductId()%></td>
                                    <td class="cart-product-name"><%=product.getPname()%></td>
                                    <td class="cart-price text-right"><%=df.format(product.getUnitPrice())%>원</td>
                                    <td class="text-center">
                                        <form
                                            action="updateCart.jsp"
                                            method="post"
                                            class="cart-quantity-form">
                                            <input
                                                type="hidden"
                                                name="id"
                                                value="<%=product.getProductId()%>">
                                            <input
                                                type="number"
                                                name="quantity"
                                                class="cart-quantity-input"
                                                min="1"
                                                max="<%=product.getUnitsInStock()%>"
                                                value="<%=product.getQuantity()%>"
                                                aria-label="상품 수량">
                                            <button
                                                type="submit"
                                                class="cart-quantity-button"
                                                data-i18n
                                                data-ko="변경"
                                                data-en="Update">
                                                변경
                                            </button>
                                        </form>
                                    </td>
                                    <td class="cart-total text-right"><%=df.format(total)%>원</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                    <div class="cart-summary">
                        <span class="cart-summary-label" data-i18n data-ko="주문 예상 금액" data-en="Order total">주문 예상 금액</span>
                        <strong class="cart-summary-price"><%=df.format(sum)%>원</strong>
                    </div>
                <% } %>
            </div>

            <% if (!cartList.isEmpty()) { %>
            <div class="cart-actions">
                <a href="javascript:deleteCart()" class="shop-btn-danger" data-i18n data-ko="장바구니 비우기" data-en="Clear cart">장바구니 비우기</a>
                <div class="cart-actions-right">
                    <a href="productsu.jsp" class="shop-btn-outline" data-i18n data-ko="계속 쇼핑하기" data-en="Continue shopping">계속 쇼핑하기</a>
                    <a href="shippingInfo.jsp" class="shop-btn-primary" data-i18n data-ko="주문하기" data-en="Checkout">주문하기</a>
                </div>
            </div>
            <% } %>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
