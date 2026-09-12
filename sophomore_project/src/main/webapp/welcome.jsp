<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%
    String contextPath = request.getContextPath();
    String loginUser = (String) session.getAttribute("userID");
    ProductRepository productDao = ProductRepository.getInstance();
    ArrayList<Product> featuredProducts = productDao.getAllProducts();
    DecimalFormat priceFormat = new DecimalFormat("#,###");
%>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="일상을 더 특별하게 만드는 셀렉트숍 ILLYA">
    <link href="css/welcome.css" rel="stylesheet" />
    <title>ILLYA | welcome</title>

</head>
<body>
    <jsp:include page="menu.jsp" />
	<main class="home-main">

		<section class="home-hero">

			<div class="container">

				<h1>
					<span
						data-i18n
						data-ko="평범한 일상에"
						data-en="Make everyday"
					>
						평범한 일상에
					</span>
					<br>
					<strong
						data-i18n
						data-ko="취향"
						data-en="your taste"
					>
						취향
					</strong>
					<span
						data-i18n
						data-ko="을 더하다."
						data-en="matter."
					>
						을 더하다.
					</span>
				</h1>

				<p
					class="home-hero-text"
					data-i18n
					data-ko="ILLYA가 직접 고른 상품으로 당신만의 특별한 일상을 시작해 보세요. 필요한 순간에, 오래 만족할 선택을 제안합니다."
					data-en="Start a more personal everyday with products selected by ILLYA. We suggest choices you will enjoy for a long time."
				>
					ILLYA가 직접 고른 상품으로 당신만의 특별한 일상을 시작해 보세요. 필요한 순간에, 오래 만족할 선택을 제안합니다.
				</p>

				<a class="home-button" href="productsu.jsp">
					<span
						data-i18n
						data-ko="지금 쇼핑하기"
						data-en="Shop now"
					>
						지금 쇼핑하기
					</span>
					<i class="fa fa-long-arrow-right" aria-hidden="true"></i>
				</a>

				<% if (loginUser == null) { %>
					<a
						class="home-button home-button-outline"
						href="register.jsp"
						data-i18n
						data-ko="회원가입"
						data-en="Join ILLYA"
					>
						회원가입
					</a>
				<% } %>

			</div>

			<div class="hero-product-wrap" aria-hidden="true">
				<img src="<%=contextPath%>/images/bg.png" alt="">
			</div>

		</section>


		<section class="home-trust">

			<div class="container home-trust-inner">

				<div class="trust-item">
					<i class="fa fa-truck" aria-hidden="true"></i>
					<div>
						<strong
							data-i18n
							data-ko="빠르고 안전한 배송"
							data-en="Fast, careful delivery"
						>
							빠르고 안전한 배송
						</strong>
					</div>
				</div>

				<div class="trust-item">
					<i class="fa fa-check-circle" aria-hidden="true"></i>
					<div>
						<strong
							data-i18n
							data-ko="엄선한 상품"
							data-en="Curated products"
						>
							엄선한 상품
						</strong>
					</div>
				</div>

				<div class="trust-item">
					<i class="fa fa-commenting-o" aria-hidden="true"></i>
					<div>
						<strong
							data-i18n
							data-ko="친절한 고객 지원"
							data-en="Helpful support"
						>
							친절한 고객 지원
						</strong>
					</div>
				</div>

			</div>

		</section>


		<section class="home-section home-section-soft">

			<div class="container">

				<div class="home-section-head">

					<div>
						<h2
							class="home-section-title"
							data-i18n
							data-ko="지금 가장 주목받는 상품"
							data-en="Trending at ILLYA"
						>
							지금 가장 주목받는 상품
						</h2>
					</div>

					<a class="home-all-link" href="productsu.jsp">
						<span
							data-i18n
							data-ko="전체 상품 보기"
							data-en="View all products"
						>
							전체 상품 보기
						</span>
						<i class="fa fa-arrow-right"></i>
					</a>

				</div>

				<div class="row">

					<%
						for (int i = 0; i < featuredProducts.size() && i < 3; i++) {
							Product product = featuredProducts.get(i);
					%>

						<div class="col-md-4 mb-4 mb-md-0">

							<a
								class="featured-card d-block"
								href="product.jsp?id=<%=product.getProductId()%>"
							>

								<div class="featured-image">
									<img
										src="<%=contextPath%>/images/<%=product.getFilename()%>"
										alt="<%=product.getPname()%>"
									>
								</div>

								<div class="featured-body">

									<h3 class="featured-name">
										<%=product.getPname()%>
									</h3>

									<p class="featured-price">
										<%=priceFormat.format(product.getUnitPrice())%>원
									</p>

									<span class="featured-action">

										<span
											data-i18n
											data-ko="상품 보기"
											data-en="View product"
										>
											상품 보기
										</span>

										<i
											class="fa fa-arrow-right"
											aria-hidden="true"
										></i>

									</span>

								</div>

							</a>

						</div>

					<% } %>


					<% if (featuredProducts.isEmpty()) { %>

						<div class="col-12 text-center py-5">

							<p
								class="mb-3"
								data-i18n
								data-ko="아직 등록된 상품이 없습니다."
								data-en="There are no products yet."
							>
								아직 등록된 상품이 없습니다.
							</p>

							<a
								class="home-button"
								href="productsu.jsp"
								data-i18n
								data-ko="상품 보러 가기"
								data-en="Explore products"
							>
								상품 보러 가기
							</a>

						</div>

					<% } %>

				</div>

			</div>

		</section>


		<section class="home-section">

			<div class="container">

				<div class="home-section-head">

					<div>
						<h2
							class="home-section-title"
							data-i18n
							data-ko="무엇을 찾고 있나요?"
							data-en="What are you looking for?"
						>
							무엇을 찾고 있나요?
						</h2>
					</div>

				</div>

				<div class="row">

					<div class="col-md-4 mb-3 mb-md-0">

						<a class="home-category-card d-block" href="productsu.jsp">

							<i class="fa fa-laptop" aria-hidden="true"></i>

							<strong
								data-i18n
								data-ko="디지털 라이프"
								data-en="Digital life"
							>
								디지털 라이프
							</strong>

						</a>

					</div>

					<div class="col-md-4 mb-3 mb-md-0">

						<a class="home-category-card d-block" href="productsu.jsp">

							<i class="fa fa-camera" aria-hidden="true"></i>

							<strong
								data-i18n
								data-ko="취미와 기록"
								data-en="Hobbies & memories"
							>
								취미와 기록
							</strong>

						</a>

					</div>

					<div class="col-md-4">

						<a class="home-category-card d-block" href="productsu.jsp">

							<i class="fa fa-gift" aria-hidden="true"></i>

							<strong
								data-i18n
								data-ko="특별한 선물"
								data-en="Special gifts"
							>
								특별한 선물
							</strong>

						</a>

					</div>

				</div>

			</div>

		</section>


		<section class="home-membership">

			<div class="container">

				<div class="row align-items-center">

					<div class="col-lg-8">

						<h2>

							<span
								data-i18n
								data-ko="ILLYA와 함께"
								data-en="Make shopping more enjoyable"
							>
								ILLYA와 함께
							</span>

							<br>

							<span
								data-i18n
								data-ko="더 즐거운 쇼핑을 시작하세요."
								data-en="with ILLYA."
							>
								더 즐거운 쇼핑을 시작하세요.
							</span>

						</h2>

						<p
							data-i18n
							data-ko="회원만을 위한 새로운 상품 소식과 쇼핑 혜택을 가장 먼저 만나볼 수 있어요."
							data-en="Be the first to receive new product news and member-only shopping benefits."
						>
							회원만을 위한 새로운 상품 소식과 쇼핑 혜택을 가장 먼저 만나볼 수 있어요.
						</p>

					</div>

					<div class="col-lg-4 text-lg-right">

						<a
							class="home-button"
							href="<%=loginUser == null ? "register.jsp" : "productsu.jsp"%>"
						>

							<span
								data-i18n
								data-ko="<%=loginUser == null ? "회원가입하기" : "상품 둘러보기"%>"
								data-en="<%=loginUser == null ? "Join ILLYA" : "Explore products"%>"
							>
								<%=loginUser == null ? "회원가입하기" : "상품 둘러보기"%>
							</span>

							<i
								class="fa fa-long-arrow-right"
								aria-hidden="true"
							></i>

						</a>

					</div>

				</div>

			</div>

		</section>

	</main>
	<%@ include file="footer.jsp" %>
</body>
</html>
