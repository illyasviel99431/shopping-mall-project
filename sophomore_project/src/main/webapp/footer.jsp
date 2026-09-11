<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<footer
    class="footer_section"
    style="
        background:#111;
        color:#fff;
        padding:70px 0 20px;
    ">

    <div class="container">

        <div class="row">

            <div class="col-md-4 footer-col mb-4">

                <p
                    style="
                    	font-family: 'Dancing Script', cursive;
                        font-size:34px;
                        font-weight:900;
                        text-decoration:none;
                    ">

                    ILLYA

                </p>


                <p
                    style="
                        margin-top:18px;
                        color:rgba(255,255,255,.65);
                        line-height:1.8;
                    ">

                    <span data-i18n
                          data-ko="일상을 즐겁게 만드는 상품을 소개하고 편리한 쇼핑 경험을 제공하는 ILLYA입니다."
                          data-en="ILLYA introduces products that brighten everyday life and make shopping simple.">일상을 즐겁게 만드는 상품을 소개하고 편리한 쇼핑 경험을 제공하는 ILLYA입니다.</span>

                </p>

            </div>


            <div class="col-md-4 footer-col mb-4">

                <h4
                    style="
                        color:#fff;
                        font-weight:800;
                        margin-bottom:22px;
                    ">

                    <span data-i18n
          				data-ko="문의"
          				data-en="Contact Us">
          				문의
          			</span>

                </h4>


                <a
                    href="#"
                    style="
                        color:rgba(255,255,255,.72);
                        display:block;
                        margin-bottom:14px;
                        text-decoration:none;
                    ">

                    <i
                        class="fa fa-map-marker"
                        style="
                            width:22px;
                            color:#ffbe33;
                        ">
                    </i>

                    <span data-i18n
      					data-ko="온라인 쇼핑몰"
      					data-en="Online Shopping Mall">
    					온라인 쇼핑몰
					</span>

                </a>


                <a
                    href="mailto:demo@gmail.com"
                    style="
                        color:rgba(255,255,255,.72);
                        display:block;
                        margin-bottom:14px;
                        text-decoration:none;
                    ">

                    <i
                        class="fa fa-envelope"
                        style="
                            width:22px;
                            color:#ffbe33;
                        ">
                    </i>

                    demo@gmail.com

                </a>


                <a
                    href="#"
                    style="
                        color:rgba(255,255,255,.72);
                        display:block;
                        text-decoration:none;
                    ">

                    <i
                        class="fa fa-phone"
                        style="
                            width:22px;
                            color:#ffbe33;
                        ">
                    </i>

                    <span data-i18n data-ko="고객센터 1234-5678" data-en="Customer service 1234-5678">고객센터 1234-5678</span>

                </a>

            </div>


            <div class="col-md-4 footer-col mb-4">

                <h4
                    style="
                        color:#fff;
                        font-weight:800;
                        margin-bottom:22px;
                    ">

					<span data-i18n
          				data-ko="바로가기"
          				data-en="Quick Menu">바로가기</span>

                </h4>


                <div
                    style="
                        display:grid;
                        grid-template-columns:1fr 1fr;
                        gap:10px;
                    ">

                    <a
                        href="<%=request.getContextPath()%>/productsu.jsp"
                        style="
                            color:rgba(255,255,255,.72);
                            text-decoration:none;
                        ">

                        <span data-i18n data-ko="상품 목록" data-en="Shop">상품 목록</span>

                    </a>


                    <a
                        href="<%=request.getContextPath()%>/BoardListAction.do?pageNum=1"
                        style="
                            color:rgba(255,255,255,.72);
                            text-decoration:none;
                        ">

                        <span data-i18n data-ko="게시판" data-en="Community">게시판</span>

                    </a>


                    <a
                        href="<%=request.getContextPath()%>/cookie.jsp"
                        style="
                            color:rgba(255,255,255,.72);
                            text-decoration:none;
                        ">

                        <span data-i18n data-ko="로그인" data-en="Sign in">로그인</span>

                    </a>


                    <a
                        href="<%=request.getContextPath()%>/register.jsp"
                        style="
                            color:rgba(255,255,255,.72);
                            text-decoration:none;
                        ">

                        <span data-i18n data-ko="회원가입" data-en="Create account">회원가입</span>

                    </a>

                </div>


                <div
                    style="
                        margin-top:25px;
                        display:flex;
                        gap:10px;
                    ">

                    <a
                        href="#"
                        style="
                            width:36px;
                            height:36px;
                            border:1px solid rgba(255,255,255,.15);
                            border-radius:50%;
                            display:flex;
                            align-items:center;
                            justify-content:center;
                            color:#fff;
                        ">

                        <i class="fa fa-facebook"></i>

                    </a>


                    <a
                        href="#"
                        style="
                            width:36px;
                            height:36px;
                            border:1px solid rgba(255,255,255,.15);
                            border-radius:50%;
                            display:flex;
                            align-items:center;
                            justify-content:center;
                            color:#fff;
                        ">

                        <i class="fa fa-instagram"></i>

                    </a>


                    <a
                        href="#"
                        style="
                            width:36px;
                            height:36px;
                            border:1px solid rgba(255,255,255,.15);
                            border-radius:50%;
                            display:flex;
                            align-items:center;
                            justify-content:center;
                            color:#fff;
                        ">

                        <i class="fa fa-twitter"></i>

                    </a>

                </div>

            </div>

        </div>


        <div
            style="
                border-top:1px solid rgba(255,255,255,.1);
                margin-top:25px;
                padding-top:20px;
                text-align:center;
                color:rgba(255,255,255,.45);
                font-size:13px;
            ">

            &copy;

            <span id="displayYear"></span>

            ILLYA.

            All Rights Reserved.

        </div>

    </div>

</footer>


<script
    src="<%=request.getContextPath()%>/js/jquery-3.4.1.min.js">
</script>

<script
    src="<%=request.getContextPath()%>/js/bootstrap.js">
</script>

<script
    src="<%=request.getContextPath()%>/js/custom.js">
</script>


<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {

        document
            .querySelectorAll("#displayYear")
            .forEach(function(element) {

                element.textContent =
                    new Date().getFullYear();

            });

    }
);

</script>
