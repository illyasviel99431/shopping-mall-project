<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>주문 오류 | ILLYA</title>
    <style>
        .order-error-card { max-width: 630px; margin: 0 auto; padding: 54px 38px; text-align: center; }
        .order-error-icon { display: inline-flex; align-items: center; justify-content: center; width: 74px; height: 74px; margin-bottom: 21px; border-radius: 50%; background: #fff1f1; color: #d84349; font-size: 31px; }
        .order-error-card h2 { margin: 0 0 12px; color: #292d32; font-size: 26px; font-weight: 900; }
        .order-error-card p { margin: 0; color: #727982; font-size: 14px; line-height: 1.8; }
        .order-error-actions { display: flex; justify-content: center; gap: 9px; margin-top: 28px; }
        @media (max-width: 575px) { .order-error-card { padding: 42px 22px; } .order-error-actions { flex-direction: column; } .order-error-actions a { width: 100%; } }
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="주문을 완료하지 못했습니다" data-en="We could not complete your order">주문을 완료하지 못했습니다</h1>
            <p data-i18n data-ko="잠시 후 다시 시도해 주세요." data-en="Please try again in a moment.">잠시 후 다시 시도해 주세요.</p>
        </div>
    </section>
    <main class="shop-page">
        <div class="container">
            <section class="shop-surface order-error-card">
                <div class="order-error-icon"><i class="fa fa-exclamation" aria-hidden="true"></i></div>
                <h2 data-i18n data-ko="주문 처리 중 문제가 발생했어요" data-en="Something went wrong while placing your order">주문 처리 중 문제가 발생했어요</h2>
                <p data-i18n data-ko="일시적인 시스템 오류일 수 있습니다. 장바구니는 그대로 보관되어 있으니 다시 시도해 주세요." data-en="This may be a temporary issue. Your cart is still saved, so you can safely try again.">일시적인 시스템 오류일 수 있습니다. 장바구니는 그대로 보관되어 있으니 다시 시도해 주세요.</p>
                <div class="order-error-actions">
                    <a href="productsu.jsp" class="shop-btn-outline" data-i18n data-ko="상품 목록" data-en="Shop">상품 목록</a>
                    <a href="cart.jsp" class="shop-btn-primary" data-i18n data-ko="장바구니로 가기" data-en="Go to cart">장바구니로 가기</a>
                </div>
            </section>
        </div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
