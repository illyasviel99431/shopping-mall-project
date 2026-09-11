<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>배송 정보 | ILLYA</title>
    <style>
        .checkout-wrap { max-width: 760px; margin: 0 auto; }
        .checkout-steps { display: flex; justify-content: center; gap: 0; margin: -8px 0 30px; }
        .checkout-step { position: relative; min-width: 112px; padding-top: 31px; color: #a2a8ae; font-size: 12px; font-weight: 800; text-align: center; }
        .checkout-step::before { content: ""; position: absolute; top: 10px; left: 50%; width: 20px; height: 20px; border: 5px solid #dfe3e7; border-radius: 50%; background: #fff; transform: translateX(-50%); }
        .checkout-step + .checkout-step::after { content: ""; position: absolute; top: 18px; right: 50%; width: 100%; height: 2px; background: #dfe3e7; z-index: -1; }
        .checkout-step.is-active { color: #25282d; }
        .checkout-step.is-active::before { border-color: #ffbe33; }
        .checkout-form { padding: 32px 34px 35px; }
        .checkout-form-title { margin: 0 0 7px; font-size: 22px; font-weight: 800; }
        .checkout-form-desc { margin: 0 0 28px; color: #7d858e; font-size: 13px; }
        .checkout-field { margin-bottom: 19px; }
        .checkout-field label { display: block; margin-bottom: 8px; color: #3d4248; font-size: 13px; font-weight: 800; }
        .checkout-field input { width: 100%; height: 47px; padding: 0 14px; border: 1px solid #dce1e5; border-radius: 7px; background: #fff; color: #25282d; font-size: 14px; outline: none; transition: .2s; }
        .checkout-field input:focus { border-color: #ffbe33; box-shadow: 0 0 0 3px rgba(255, 190, 51, .16); }
        .checkout-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
        .checkout-actions { display: flex; justify-content: space-between; gap: 10px; margin-top: 29px; padding-top: 24px; border-top: 1px solid #edf0f2; }
        @media (max-width: 575px) { .checkout-form { padding: 26px 21px; } .checkout-grid { grid-template-columns: 1fr; gap: 0; } .checkout-actions { flex-direction: column-reverse; } .checkout-actions a, .checkout-actions button { width: 100%; } }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="배송 정보" data-en="Delivery details">배송 정보</h1>
            <p data-i18n data-ko="주문 상품을 받을 곳을 알려주세요." data-en="Tell us where your order should be delivered.">주문 상품을 받을 곳을 알려주세요.</p>
        </div>
    </section>

    <main class="shop-page">
        <div class="container">
            <div class="checkout-wrap">
                <div class="checkout-steps" aria-label="주문 단계">
                    <div class="checkout-step is-active" data-i18n data-ko="배송 정보" data-en="Delivery">배송 정보</div>
                    <div class="checkout-step" data-i18n data-ko="주문 확인" data-en="Review">주문 확인</div>
                    <div class="checkout-step" data-i18n data-ko="주문 완료" data-en="Complete">주문 완료</div>
                </div>

                <form action="processShippingInfo.jsp" method="post" class="shop-surface checkout-form">
                    <input type="hidden" name="cartId" value="<%= request.getParameter("cartId") == null ? "" : request.getParameter("cartId") %>">
                    <h2 class="checkout-form-title" data-i18n data-ko="수령인 정보" data-en="Recipient details">수령인 정보</h2>
                    <p class="checkout-form-desc" data-i18n data-ko="정확한 연락처와 주소를 입력해 주세요." data-en="Please enter an accurate phone number and address.">정확한 연락처와 주소를 입력해 주세요.</p>

                    <div class="checkout-field">
                        <label for="name" data-i18n data-ko="수령인 이름" data-en="Recipient name">수령인 이름</label>
                        <input type="text" id="name" name="name" placeholder="홍길동" required>
                    </div>
                    <div class="checkout-grid">
                        <div class="checkout-field">
                            <label for="phone" data-i18n data-ko="연락처" data-en="Phone number">연락처</label>
                            <input type="tel" id="phone" name="phone" inputmode="numeric" placeholder="010-1234-5678" maxlength="13" required>
                        </div>
                        <div class="checkout-field">
                            <label for="shippingDate" data-i18n data-ko="배송 요청일" data-en="Preferred delivery date">배송 요청일</label>
                            <input type="date" id="shippingDate" name="shippingDate" required>
                        </div>
                    </div>
                    <div class="checkout-grid">
                        <div class="checkout-field">
                            <label for="zipCode" data-i18n data-ko="우편번호" data-en="Postal code">우편번호</label>
                            <input type="text" id="zipCode" name="zipCode" inputmode="numeric" maxlength="5" placeholder="12345" required>
                        </div>
                        <div class="checkout-field">
                            <label for="address" data-i18n data-ko="주소" data-en="Address">주소</label>
                            <input type="text" id="address" name="address" placeholder="서울특별시 강남구 테헤란로 123" required>
                        </div>
                    </div>
                    <div class="checkout-actions">
                        <a href="cart.jsp" class="shop-btn-outline" data-i18n data-ko="장바구니로 돌아가기" data-en="Back to cart">장바구니로 돌아가기</a>
                        <button type="submit" class="shop-btn-primary border-0" data-i18n data-ko="주문 확인으로 이동" data-en="Review order">주문 확인으로 이동</button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <jsp:include page="footer.jsp" />

    <script>
        document.getElementById("phone").addEventListener("input", function () {
            var numbers = this.value.replace(/\D/g, "").slice(0, 11);
            if (numbers.length <= 3) this.value = numbers;
            else if (numbers.length <= 7) this.value = numbers.slice(0, 3) + "-" + numbers.slice(3);
            else this.value = numbers.slice(0, 3) + "-" + numbers.slice(3, 7) + "-" + numbers.slice(7);
        });
    </script>
</body>
</html>
