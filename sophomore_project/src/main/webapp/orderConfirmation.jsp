<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
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

    String name = "", phone = "", zipCode = "", address = "", shippingDate = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            String cookieName = cookie.getName();
            if ("Shipping_name".equals(cookieName)) 
            	name = URLDecoder.decode(cookie.getValue(), "UTF-8");
            if ("Shipping_phone".equals(cookieName)) 
            	phone = URLDecoder.decode(cookie.getValue(), "UTF-8");
            if ("Shipping_zipCode".equals(cookieName)) 
            	zipCode = URLDecoder.decode(cookie.getValue(), "UTF-8");
            if ("Shipping_address".equals(cookieName)) 
            	address = URLDecoder.decode(cookie.getValue(), "UTF-8");
            if ("Shipping_shippingDate".equals(cookieName)) 
            	shippingDate = URLDecoder.decode(cookie.getValue(), "UTF-8");
        }
    }

    int sum = 0;
    for (Product product : cartList) {
        sum += product.getUnitPrice() * product.getQuantity();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 확인 | ILLYA</title>
    <style>
		.order-check-wrap {
			max-width: 1010px;
			margin: 0 auto;
		}
		.order-check-grid {
			display: grid;
			grid-template-columns: minmax(0, 1.18fr) minmax(310px, .82fr);
			gap: 20px;
			align-items: start;
		}
		.order-card {
			overflow: hidden;
		}
		.order-card-title {
			display: flex;
			align-items: center;
			min-height: 78px;
			margin: 0;
			padding: 0 27px;
			border-bottom: 1px solid #e7ebee;
			color: #24282e;
			font-size: 20px;
			font-weight: 900;
		}
		.order-card-title i {
			margin-right: 9px;
			color: #e23a48;
		}
		.order-table-wrap {
			overflow: hidden;
		}
		.order-detail-table,
		.order-summary-table {
			width: 100%;
			border-collapse: separate;
			border-spacing: 0;
		}
		.order-detail-table th,
		.order-detail-table td {
			padding: 16px 19px;
			border-bottom: 1px solid #e9edf0;
			text-align: left;
			vertical-align: middle;
		}
		.order-detail-table tr:last-child th,
		.order-detail-table tr:last-child td {
			border-bottom: 0;
		}
		.order-detail-table th {
			width: 124px;
			background: #f7f8fa;
			color: #69727c;
			font-size: 13px;
			font-weight: 900;
		}
		.order-detail-table td {
			overflow-wrap: anywhere;
			color: #282d32;
			font-size: 14px;
			font-weight: 700;
		}
		.order-summary-table th,
		.order-summary-table td {
			padding: 16px 19px;
			border-bottom: 1px solid #e9edf0;
			vertical-align: middle;
		}
		.order-summary-table th {
			color: #34383e;
			font-size: 14px;
			font-weight: 800;
			text-align: left;
		}
		.order-summary-table td {
			color: #e23a48;
			font-size: 14px;
			font-weight: 900;
			text-align: right;
			white-space: nowrap;
		}
		.order-item-qty {
			margin-left: 5px;
			color: #9299a1;
			font-size: 12px;
			font-weight: 700;
		}
		.order-summary-table tfoot th,
		.order-summary-table tfoot td {
			border-bottom: 0;
			background: #fff7f7;
		}
		.order-summary-table tfoot th {
			color: #35393e;
			font-size: 14px;
		}
		.order-summary-table tfoot td {
			color: #e23a48;
			font-size: 22px;
			font-weight: 900;
		}
		.order-actions {
			display: flex;
			justify-content: space-between;
			gap: 10px;
			margin-top: 20px;
		}
		.order-actions-right {
			display: flex;
			gap: 9px;
		}
		@media (max-width: 767px) {
			.order-check-grid {
				grid-template-columns: 1fr;
			}
			.order-card-title {
				min-height: 71px;
				padding: 0 20px;
			}
			.order-detail-table th,
			.order-detail-table td,
			.order-summary-table th,
			.order-summary-table td {
				padding: 15px;
			}
			.order-detail-table th {
				width: 106px;
			}
			.order-actions,
			.order-actions-right {
				flex-direction: column;
			}
			.order-actions a {
				width: 100%;
			}
		}    
	</style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="주문 확인" data-en="Review your order">주문 확인</h1>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <div class="order-check-wrap">
                <div class="order-check-grid">
                    <section class="shop-surface order-card">
                        <h2 class="order-card-title"><i class="fa fa-map-marker" aria-hidden="true"></i><span data-i18n data-ko="배송지 정보" data-en="Delivery address">배송지 정보</span></h2>
                        <div class="order-table-wrap">
                            <table class="order-detail-table">
                                <tbody>
                                    <tr><th scope="row" data-i18n data-ko="수령인" data-en="Recipient">수령인</th><td><%=name%></td></tr>
                                    <tr><th scope="row" data-i18n data-ko="연락처" data-en="Phone">연락처</th><td><%=phone%></td></tr>
                                    <tr><th scope="row" data-i18n data-ko="우편번호" data-en="Postal code">우편번호</th><td><%=zipCode%></td></tr>
                                    <tr><th scope="row" data-i18n data-ko="주소" data-en="Address">주소</th><td><%=address%></td></tr>
                                    <tr><th scope="row" data-i18n data-ko="배송 요청일" data-en="Delivery date">배송 요청일</th><td><%=shippingDate%></td></tr>
                                </tbody>
                            </table>
                        </div>
                    </section>

                    <aside class="shop-surface order-card">
                        <h2 class="order-card-title"><i class="fa fa-shopping-bag" aria-hidden="true"></i><span data-i18n data-ko="결제 정보" data-en="Order summary">결제 정보</span></h2>
                        <div class="order-table-wrap">
                            <table class="order-summary-table">
                                <tbody>
                                    <% for (Product product : cartList) { %>
                                    <tr>
                                        <th scope="row"><%=product.getPname()%><span class="order-item-qty">× <%=product.getQuantity()%></span></th>
                                        <td><%=String.format("%,d", product.getUnitPrice() * product.getQuantity())%><span data-i18n data-ko="원" data-en=" KRW">원</span></td>
                                    </tr>
                                    <% } %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th scope="row" data-i18n data-ko="총 결제 금액" data-en="Total">총 결제 금액</th>
                                        <td><%=String.format("%,d", sum)%><span data-i18n data-ko="원" data-en=" KRW">원</span></td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </aside>
                </div>
                <div class="order-actions">
                    <a href="shippingInfo.jsp" class="shop-btn-outline" data-i18n data-ko="배송 정보 수정" data-en="Edit delivery">배송 정보 수정</a>
                    <div class="order-actions-right">
                        <a href="orderError.jsp" class="shop-btn-danger" data-i18n data-ko="주문 취소" data-en="Cancel">주문 취소</a>
                        <a href="thankCustomer.jsp" class="shop-btn-primary" data-i18n data-ko="결제하기" data-en="Place order">결제하기</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
</body>
</html>
