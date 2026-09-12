<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%
    String userID = (String) session.getAttribute("userID");
    if (userID == null || userID.trim().isEmpty()) {
        response.sendRedirect("cookie.jsp");
        return;
    }

    ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
    if (cartList == null || cartList.isEmpty()) {
        response.sendRedirect("cart.jsp");
        return;
    }

    try {
        ProductRepository.getInstance().completePurchase(cartList);
    } catch (RuntimeException e) {
        e.printStackTrace();
        response.sendRedirect("orderError.jsp");
        return;
    }

    String name = "";
    String address = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("Shipping_name".equals(cookie.getName())) name = URLDecoder.decode(cookie.getValue(), "UTF-8");
            if ("Shipping_address".equals(cookie.getName())) address = URLDecoder.decode(cookie.getValue(), "UTF-8");
        }
    }

    session.removeAttribute("cartlist");
    String[] shippingCookies = { "Shipping_cartId", "Shipping_name", "Shipping_phone", "Shipping_zipCode", "Shipping_address", "Shipping_shippingDate" };
    for (String cookieName : shippingCookies) {
        Cookie cookie = new Cookie(cookieName, "");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 완료 | ILLYA</title>
    <style>
		.complete-card {
			max-width: 650px;
			margin: 0 auto;
			padding: 55px 38px;
			text-align: center;
		}

		.complete-icon {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 82px;
			height: 82px;
			margin-bottom: 22px;
			border-radius: 50%;
			background: #fff6dc;
			color: #d48b0b;
			font-size: 37px;
		}

		.complete-card h2 {
			margin: 0 0 13px;
			color: #202124;
			font-size: 27px;
			font-weight: 900;
		}

		.complete-card > p {
			margin: 0;
			color: #707780;
			font-size: 15px;
			line-height: 1.7;
		}

		.complete-address {
			margin: 28px 0;
			padding: 18px 21px;
			border: 1px solid #e9ecef;
			border-radius: 9px;
			background: #fafbfc;
			text-align: left;
		}

		.complete-address-label {
			display: block;
			margin-bottom: 7px;
			color: #858c95;
			font-size: 12px;
			font-weight: 800;
		}

		.complete-address-value {
			overflow-wrap: anywhere;
			color: #30353b;
			font-size: 14px;
			font-weight: 700;
		}

		.complete-actions {
			display: flex;
			justify-content: center;
			gap: 9px;
		}

		@media (max-width: 575px) {

			.complete-card {
				padding: 42px 22px;
			}

			.complete-actions {
				flex-direction: column;
			}

			.complete-actions a {
				width: 100%;
			}

		}
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="주문이 완료되었습니다" data-en="Your order is complete">주문이 완료되었습니다</h1>
            <p data-i18n data-ko="ILLYA를 선택해 주셔서 감사합니다." data-en="Thank you for choosing ILLYA.">ILLYA를 선택해 주셔서 감사합니다.</p>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <section class="shop-surface complete-card">
                <div class="complete-icon"><i class="fa fa-check" aria-hidden="true"></i></div>
                <h2><%=name%><span data-i18n data-ko="님, 주문해 주셔서 감사합니다." data-en=", thank you for your order.">님, 주문해 주셔서 감사합니다.</span></h2>
                <p data-i18n data-ko="주문이 정상적으로 접수되었습니다. 배송 준비가 시작되면 안내해 드릴게요." data-en="Your order has been received. We will let you know when it starts preparing for delivery.">주문이 정상적으로 접수되었습니다. 배송 준비가 시작되면 안내해 드릴게요.</p>
                <div class="complete-address">
                    <span class="complete-address-label" data-i18n data-ko="배송지" data-en="Delivery address">배송지</span>
                    <span class="complete-address-value"><%=address%></span>
                </div>
                <div class="complete-actions">
                    <a href="mypage.jsp" class="shop-btn-outline" data-i18n data-ko="내 프로필" data-en="My profile">내 프로필</a>
                    <a href="productsu.jsp" class="shop-btn-primary" data-i18n data-ko="계속 쇼핑하기" data-en="Continue shopping">계속 쇼핑하기</a>
                </div>
            </section>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
