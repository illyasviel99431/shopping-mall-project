<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>


<%

    /* ==========================================
       로그인 정보
    ========================================== */

    String loginUser =
            (String) session.getAttribute("userID");

    String userRole =
            (String) session.getAttribute("userRole");


    /* ==========================================
       경로 정보
    ========================================== */

    String contextPath =
            request.getContextPath();

    String requestUri =
            request.getRequestURI();


    /* ==========================================
       게시판 활성화
    ========================================== */

    boolean boardActive =
            requestUri.contains("/Board")
            || requestUri.contains("/board/");

%>




<link rel="stylesheet"
      type="text/css"
      href="<%=contextPath%>/css/bootstrap.css" />

<link href="<%=contextPath%>/css/font-awesome.min.css"
      rel="stylesheet" />

<link href="<%=contextPath%>/css/style.css"
      rel="stylesheet" />

<link href="<%=contextPath%>/css/responsive.css"
      rel="stylesheet" />

<link rel="stylesheet"
      href="<%=contextPath%>/css/myStyle.css" />


<style>


    /* ==========================================
       관리자 모드
    ========================================== */

    .admin-mode-bar {

        width: 100%;

        background: #111111;

        border-bottom: 1px solid #333333;

        padding: 10px 0;

    }


    .admin-mode-bar .container {

        display: flex;

        align-items: center;

        justify-content: center;

        gap: 35px;

    }


    .admin-mode-title {

        color: #ffffff;

        font-size: 18px;

        font-weight: 800;

        letter-spacing: 1px;

        white-space: nowrap;

        transform: translateX(-50px);

    }


    .admin-mode-menu {

        display: flex;

        align-items: center;

        gap: 25px;

    }


    .admin-mode-menu a {

        color: #ffffff;

        text-decoration: none;

        font-size: 14px;

        font-weight: 600;

        transition: 0.2s;

    }


    .admin-mode-menu a:hover {

        color: #ffbe33;

    }





    .header_section .navbar-nav
    .nav-item.active > .nav-link {

        color: #ffbe33 !important;

        font-weight: 800;

        position: relative;

    }


    .header_section .navbar-nav
    .nav-item.active > .nav-link::after {

        content: "";

        position: absolute;

        left: 12px;

        right: 12px;

        bottom: 5px;

        height: 2px;

        border-radius: 2px;

        background: #ffbe33;

    }


</style>





<header class="header_section">


    <!-- ==========================================
         관리자 전용 메뉴
    ========================================== -->

    <%

        if ("ADMIN".equals(userRole)) {

    %>


    <div class="admin-mode-bar">

        <div class="container">


            <div class="admin-mode-title">

                관리자 모드

            </div>


            <div class="admin-mode-menu">


                <a href="<%=contextPath%>/addproduct.jsp">

                    상품 등록

                </a>


                <a href="<%=contextPath%>/productEdit.jsp">

                    상품 수정

                </a>


                <a href="<%=contextPath%>/deleteproduct.jsp">

                    상품 삭제

                </a>


            </div>


        </div>

    </div>


    <%

        }

    %>





    <div class="container">


        <nav class="navbar navbar-expand-lg custom_nav-container">




            <a class="navbar-brand"
               href="<%=contextPath%>/welcome.jsp">

                <span>

                    ILLYA

                </span>

            </a>



            <!-- ==================================
                 모바일 메뉴 버튼
            ================================== -->

            <button class="navbar-toggler"
                    type="button"
                    data-toggle="collapse"
                    data-target="#navbarsupportedcontent"
                    aria-controls="navbarsupportedcontent"
                    aria-expanded="false"
                    aria-label="toggle navigation">

                <span class="navbar-toggler-icon"></span>

            </button>



            <div class="collapse navbar-collapse"
                 id="navbarsupportedcontent">



                <ul class="navbar-nav mx-auto">


             

                    <li class="nav-item"
                        id="menu-home">

                        <a class="nav-link"
                           href="<%=contextPath%>/welcome.jsp"
                           data-i18n
                           data-ko="홈"
                           data-en="Home">

                            홈

                        </a>

                    </li>



     

                    <li class="nav-item"
                        id="menu-list">

                        <a class="nav-link"
                           href="<%=contextPath%>/productsu.jsp"
                           data-i18n
                           data-ko="상품 목록"
                           data-en="Shop">

                            상품 목록

                        </a>

                    </li>




                    <li class="nav-item
                        <%= boardActive ? "active" : "" %>">

                        <a class="nav-link"
                           href="<%=contextPath%>/BoardListAction.do?pageNum=1"
                           data-i18n
                           data-ko="게시판"
                           data-en="Community">

                            게시판

                        </a>

                    </li>



       

                    <li class="nav-item dropdown">


                        <button class="nav-link dropdown-toggle account-menu-toggle"
                           type="button"
                           id="accountMenuToggle"
                           aria-haspopup="true"
                           aria-controls="accountMenu"
                           aria-expanded="false"
                           data-i18n
                           data-ko="마이페이지"
                           data-en="My Account">

                            마이페이지

                        </button>



                        <div class="dropdown-menu account-menu"
                             id="accountMenu"
                             aria-labelledby="accountMenuToggle"
                             aria-hidden="true">


                            <%

                                if (loginUser == null) {

                            %>


                            <!-- 로그인 -->

                            <a class="dropdown-item"
                               href="<%=contextPath%>/cookie.jsp"
                               data-i18n
                               data-ko="로그인"
                               data-en="Sign in">

                                로그인

                            </a>



                            <!-- 회원가입 -->

                            <a class="dropdown-item"
                               href="<%=contextPath%>/register.jsp"
                               data-i18n
                               data-ko="회원가입"
                               data-en="Create account">

                                회원가입

                            </a>


                            <%

                                }

                                else {

                            %>


                            <!-- 프로필 -->

                            <a class="dropdown-item"
                               href="<%=contextPath%>/mypage.jsp">

                                <i class="fa fa-user"></i>

                                <span data-i18n
                                      data-ko="프로필"
                                      data-en="Profile">프로필</span>

                            </a>



                            <!-- 장바구니 -->

                            <a class="dropdown-item"
                               href="<%=contextPath%>/cart.jsp">

                                <i class="fa fa-shopping-cart"></i>

                                <span data-i18n
                                      data-ko="장바구니"
                                      data-en="Cart">장바구니</span>

                            </a>



                            <div class="dropdown-divider"></div>



                            <!-- 로그아웃 -->

                            <a class="dropdown-item"
                               href="<%=contextPath%>/cookie_out.jsp">

                                <i class="fa fa-sign-out"></i>

                                <span data-i18n
                                      data-ko="로그아웃"
                                      data-en="Sign out">로그아웃</span>

                            </a>


                            <%

                                }

                            %>


                        </div>

                    </li>



                </ul>



                <!-- ==================================
                     검색
                ================================== -->

                <div class="user_option">


                    <form class="nav-search-form"
                          action="<%=contextPath%>/productsu.jsp"
                          method="get">


                        <input
                            class="form-control nav-search-input"
                            type="search"
                            name="searchKeyword"
                            placeholder="상품 검색..."
                            data-i18n-placeholder
                            data-ko-placeholder="상품 검색..."
                            data-en-placeholder="Search products..."
                            aria-label="Search">


                        <button
                            class="nav-search-btn"
                            type="submit">

                            <i class="fa fa-search"
                               aria-hidden="true">
                            </i>

                        </button>


                    </form>

                    <button type="button"
                            class="language-switch"
                            id="languageSwitcher"
                            aria-label="언어를 영어로 변경">

                        <i class="fa fa-globe" aria-hidden="true"></i>

                        <span id="languageSwitcherLabel">EN</span>

                    </button>


                </div>


            </div>

        </nav>

    </div>


</header>

<script
    src="<%=contextPath%>/js/language.js?v=20260912"
    charset="UTF-8">
</script>

<script>
/*
 * Bootstrap 4의 dropdown은 Popper.js가 있어야 열립니다. 이 프로젝트에는
 * Popper가 포함되어 있지 않아 로그인 화면에서 메뉴 클릭 시 오류가 났습니다.
 * 계정 메뉴는 외부 라이브러리에 기대지 않는 작은 접근성 메뉴로 처리합니다.
 */
(function () {
    function setAccountMenu(open) {
        var toggle = document.getElementById("accountMenuToggle");
        var menu = document.getElementById("accountMenu");

        if (!toggle || !menu) {
            return;
        }

        menu.classList.toggle("show", open);
        toggle.setAttribute("aria-expanded", open ? "true" : "false");
        menu.setAttribute("aria-hidden", open ? "false" : "true");
    }

    function initializeAccountMenu() {
        var toggle = document.getElementById("accountMenuToggle");
        var menu = document.getElementById("accountMenu");

        if (!toggle || !menu || toggle.dataset.menuReady === "true") {
            return;
        }

        toggle.dataset.menuReady = "true";

        toggle.addEventListener("click", function (event) {
            event.preventDefault();
            event.stopPropagation();
            setAccountMenu(!menu.classList.contains("show"));
        });

        document.addEventListener("click", function (event) {
            if (!menu.contains(event.target) && !toggle.contains(event.target)) {
                setAccountMenu(false);
            }
        });

        document.addEventListener("keydown", function (event) {
            if (event.key === "Escape") {
                setAccountMenu(false);
                toggle.focus();
            }
        });
    }

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", initializeAccountMenu);
    } else {
        initializeAccountMenu();
    }
})();
</script>





<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {


        /* ======================================
           현재 페이지 이름 가져오기
        ====================================== */

        var path =
            window.location.pathname;


        var page =
            path.substring(
                path.lastIndexOf("/") + 1
            );



        /* ======================================
           메뉴 가져오기
        ====================================== */

        var homeMenu =
            document.getElementById("menu-home");


        var listMenu =
            document.getElementById("menu-list");



        /* ======================================
           기존 active 제거
        ====================================== */

        if (homeMenu) {

            homeMenu.classList.remove("active");

        }


        if (listMenu) {

            listMenu.classList.remove("active");

        }



        /* ======================================
           홈 활성화
        ====================================== */

        if (page === "welcome.jsp") {

            if (homeMenu) {

                homeMenu.classList.add("active");

            }

        }



        /* ======================================
           상품 목록 활성화
        ====================================== */

        else if (

            page === "productsu.jsp" ||

            page === "product.jsp"

        ) {

            if (listMenu) {

                listMenu.classList.add("active");

            }

        }



  

        else if (page === "") {

            if (homeMenu) {

                homeMenu.classList.add("active");

            }

        }


    }

);

</script>
