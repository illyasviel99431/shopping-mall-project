<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 완료 | ILLYA</title>
    <style>
        	.join-complete-card {
			max-width: 640px;
			margin: 0 auto;
			padding: 55px 38px;
			text-align: center;
		}

		.join-complete-icon {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			width: 80px;
			height: 80px;
			margin-bottom: 22px;
			border-radius: 50%;
			background: #fff6df;
			color: #d98e09;
			font-size: 35px;
		}

		.join-complete-card h2 {
			margin: 0 0 12px;
			color: #202428;
			font-size: 27px;
			font-weight: 900;
		}

		.join-complete-card p {
			margin: 0;
			color: #737a83;
			font-size: 15px;
			line-height: 1.8;
		}

		.join-complete-actions {
			display: flex;
			justify-content: center;
			gap: 9px;
			margin-top: 29px;
		}

		@media (max-width: 575px) {

			.join-complete-card {
				padding: 43px 22px;
			}

			.join-complete-actions {
				flex-direction: column;
			}

			.join-complete-actions a {
				width: 100%;
			}

		}
    </style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="회원가입이 완료되었습니다" data-en="Your account is ready">회원가입이 완료되었습니다</h1>
            <p data-i18n data-ko="이제 ILLYA의 쇼핑을 시작해 보세요." 
            	data-en="You are ready to start shopping with ILLYA.">
            	이제 ILLYA의 쇼핑을 시작해 보세요.
            </p>
        </div>
    </section>
    <main class="shop-page">
        <div class="container">
            <section class="shop-surface join-complete-card">
                <div class="join-complete-icon"><i class="fa fa-check" aria-hidden="true"></i></div>
                <h2 data-i18n data-ko="환영합니다!" data-en="Welcome!">환영합니다!</h2>
                <p data-i18n data-ko="회원가입이 정상적으로 처리되었습니다. 로그인 후 ILLYA의 다양한 상품을 만나보세요." 
                	data-en="Your registration was successful. Sign in to explore ILLYA's selections.">
                	회원가입이 정상적으로 처리되었습니다. 로그인 후 ILLYA의 다양한 상품을 만나보세요.
                </p>
                <div class="join-complete-actions">
                    <a href="productsu.jsp" class="shop-btn-outline" 
                    	data-i18n data-ko="상품 둘러보기" data-en="Explore products">
                    	상품 둘러보기
                    </a>
                    <a href="cookie.jsp" class="shop-btn-primary" 
                    	data-i18n data-ko="로그인하기" data-en="Sign in">
                    	로그인하기
                    </a>
                </div>
            </section>
        </div>
    </main>
    <jsp:include page="footer.jsp" />
</body>
</html>
