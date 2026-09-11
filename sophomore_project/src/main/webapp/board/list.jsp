<%@ page import="java.util.List"%>
<%@ page import="mvc.model.BoardDTO"%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    List<BoardDTO> boardList =
        (List<BoardDTO>) request.getAttribute("boardlist");

    int pageNum =
        (Integer) request.getAttribute("pageNum");

    int totalCount =
        (Integer) request.getAttribute("totalCount");

    int totalPage =
        (Integer) request.getAttribute("totalPage");

    int startPage =
        (Integer) request.getAttribute("startPage");

    int endPage =
        (Integer) request.getAttribute("endPage");

    String searchType =
        (String) request.getAttribute("searchType");

    String keyword =
        (String) request.getAttribute("keyword");

    if (searchType == null || searchType.trim().isEmpty()) {
        searchType = "all";
    }

    if (keyword == null) {
        keyword = "";
    }

    String contextPath =
        request.getContextPath();

    String loginUser =
        (String) session.getAttribute("userID");

    String encodedKeyword =
        java.net.URLEncoder.encode(keyword, "UTF-8");

    String encodedSearchType =
        java.net.URLEncoder.encode(searchType, "UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>게시판 | Web Market</title>

    <link
        rel="stylesheet"
        href="<%=contextPath%>/css/bootstrap.css">

    <link
        rel="stylesheet"
        href="<%=contextPath%>/css/myStyle.css">

    <!-- 게시판 전용 CSS -->
    <link
        rel="stylesheet"
        href="<%=contextPath%>/css/board.css">

</head>

<body>

<jsp:include page="/menu.jsp"/>


<div class="board-page">

    <!-- =====================================
         게시판 제목
    ====================================== -->

    <div class="board-header">

        <div class="board-label">
            CUSTOMER SERVICE
        </div>

        <h1 class="board-title">
            게시판
        </h1>

        <p class="board-description">
            궁금한 점이나 상품에 대한 문의사항을 남겨주세요.
        </p>

    </div>


    <!-- =====================================
         게시판 카드
    ====================================== -->

    <div class="board-card">


        <!-- 게시판 상단 -->

        <div class="board-top">

            <div class="board-count">

                전체 게시글

                <strong>
                    <%= totalCount %>
                </strong>

                개

            </div>


            <%
                if (loginUser != null
                    && !loginUser.trim().isEmpty()) {
            %>

                <a
                    href="<%=contextPath%>/BoardWriteForm.do"
                    class="write-button">

                    글쓰기

                </a>

            <%
                }
            %>

        </div>


        <!-- =====================================
             게시글 목록
        ====================================== -->

        <div class="board-table-wrap">

            <table class="board-table">

                <colgroup>

                    <col style="width: 75px;">

                    <col style="width: auto;">

                    <col style="width: 120px;">

                    <col style="width: 145px;">

                    <col style="width: 145px;">

                    <col style="width: 75px;">

                </colgroup>


                <thead>

                    <tr>

                        <th>
                            번호
                        </th>

                        <th>
                            제목
                        </th>

                        <th>
                            작성자
                        </th>

                        <th>
                            작성일
                        </th>

                        <th>
                            수정일
                        </th>

                        <th>
                            조회
                        </th>

                    </tr>

                </thead>


                <tbody>

                <%
                    if (boardList == null
                        || boardList.isEmpty()) {
                %>

                    <tr>

                        <td
                            colspan="6"
                            class="empty-board">

                            <div class="empty-icon">
                                !
                            </div>

                            <div class="empty-title">
                                등록된 게시글이 없습니다.
                            </div>

                            <p class="empty-text">
                                첫 번째 문의글을 작성해보세요.
                            </p>

                        </td>

                    </tr>

                <%
                    } else {

                        for (BoardDTO board : boardList) {
                %>

                    <tr>

                        <!-- 번호 -->

                        <td class="board-number">

                            <%= board.getNum() %>

                        </td>


                        <!-- 제목 -->

                        <td class="board-subject">

                            <a
                                href="<%=contextPath%>/BoardViewAction.do?num=<%=board.getNum()%>&pageNum=<%=pageNum%>&searchType=<%=encodedSearchType%>&keyword=<%=encodedKeyword%>">

                                <%= board.getSubject() %>

                            </a>

                        </td>


                        <!-- 작성자 -->

                        <td class="board-author">

                            <%= board.getName() %>

                        </td>


                        <!-- 작성일 -->

                        <td class="board-date">

                            <%= board.getRegist_day() %>

                        </td>


                        <!-- 수정일 -->

                        <td class="board-date">

                            <%= board.getUpdate_day() %>

                        </td>


                        <!-- 조회 -->

                        <td class="board-hit">

                            <%= board.getHit() %>

                        </td>

                    </tr>

                <%
                        }

                    }
                %>

                </tbody>

            </table>

        </div>


        <!-- =====================================
             검색
        ====================================== -->

        <form
            action="<%=contextPath%>/BoardListAction.do"
            method="get"
            class="search-area">

            <input
                type="hidden"
                name="pageNum"
                value="1">


            <!-- =================================
                 검색 조건 드롭다운
            ================================== -->

            <div class="search-dropdown">

                <button
                    type="button"
                    id="searchDropdownButton"
                    class="search-dropdown-button">

                    <span id="searchDropdownText">

                        <%
                            if ("subject".equals(searchType)) {
                        %>

                            제목

                        <%
                            } else if ("content".equals(searchType)) {
                        %>

                            내용

                        <%
                            } else if ("name".equals(searchType)) {
                        %>

                            작성자

                        <%
                            } else {
                        %>

                            전체

                        <%
                            }
                        %>

                    </span>

                    <span class="search-arrow"></span>

                </button>


                <div
                    id="searchDropdownMenu"
                    class="search-dropdown-menu">

                    <button
                        type="button"
                        class="search-dropdown-item
                            <%= "all".equals(searchType)
                                ? "selected"
                                : "" %>"
                        data-value="all">

                        전체

                    </button>


                    <button
                        type="button"
                        class="search-dropdown-item
                            <%= "subject".equals(searchType)
                                ? "selected"
                                : "" %>"
                        data-value="subject">

                        제목

                    </button>


                    <button
                        type="button"
                        class="search-dropdown-item
                            <%= "content".equals(searchType)
                                ? "selected"
                                : "" %>"
                        data-value="content">

                        내용

                    </button>


                    <button
                        type="button"
                        class="search-dropdown-item
                            <%= "name".equals(searchType)
                                ? "selected"
                                : "" %>"
                        data-value="name">

                        작성자

                    </button>

                </div>

            </div>


            <!-- 실제 서버로 전달될 검색 조건 -->

            <input
                type="hidden"
                name="searchType"
                id="searchType"
                value="<%=searchType%>">


            <!-- =================================
                 검색어
            ================================== -->

            <input
                type="text"
                name="keyword"
                class="search-input"
                placeholder="검색어를 입력하세요."
                value="<%=keyword%>">


            <!-- =================================
                 검색 버튼
            ================================== -->

            <button
                type="submit"
                class="search-button">

                검색

            </button>

        </form>

    </div>


    <!-- =====================================
         페이지네이션
    ====================================== -->

    <div class="pagination-area">

        <nav>

            <ul class="pagination">


            <%
                if (startPage > 1) {
            %>

                <li class="page-item">

                    <a
                        class="page-link"
                        href="<%=contextPath%>/BoardListAction.do?pageNum=<%=startPage - 1%>&searchType=<%=encodedSearchType%>&keyword=<%=encodedKeyword%>">

                        ‹

                    </a>

                </li>

            <%
                }


                for (
                    int i = startPage;
                    i <= endPage;
                    i++
                ) {
            %>

                <li
                    class="page-item
                    <%= i == pageNum ? "active" : "" %>">

                    <a
                        class="page-link"
                        href="<%=contextPath%>/BoardListAction.do?pageNum=<%=i%>&searchType=<%=encodedSearchType%>&keyword=<%=encodedKeyword%>">

                        <%=i%>

                    </a>

                </li>

            <%
                }


                if (endPage < totalPage) {
            %>

                <li class="page-item">

                    <a
                        class="page-link"
                        href="<%=contextPath%>/BoardListAction.do?pageNum=<%=endPage + 1%>&searchType=<%=encodedSearchType%>&keyword=<%=encodedKeyword%>">

                        ›

                    </a>

                </li>

            <%
                }
            %>

            </ul>

        </nav>

    </div>

</div>


<jsp:include page="/footer.jsp"/>


<!-- =====================================
     검색 드롭다운 JS
====================================== -->

<script>

document.addEventListener("DOMContentLoaded", function () {

    const dropdownButton =
        document.getElementById(
            "searchDropdownButton"
        );

    const dropdownMenu =
        document.getElementById(
            "searchDropdownMenu"
        );

    const dropdownText =
        document.getElementById(
            "searchDropdownText"
        );

    const searchType =
        document.getElementById(
            "searchType"
        );

    const items =
        document.querySelectorAll(
            ".search-dropdown-item"
        );


    /* =====================================
       드롭다운 열기 / 닫기
    ====================================== */

    dropdownButton.addEventListener(
        "click",
        function (event) {

            event.preventDefault();
            event.stopPropagation();

            dropdownMenu.classList.toggle("show");

            dropdownButton.classList.toggle(
                "active"
            );

        }
    );


    /* =====================================
       검색 조건 선택
    ====================================== */

    items.forEach(function (item) {

        item.addEventListener(
            "click",
            function (event) {

                event.preventDefault();
                event.stopPropagation();


                const value =
                    this.getAttribute(
                        "data-value"
                    );


                const text =
                    this.textContent.trim();


                searchType.value =
                    value;


                dropdownText.textContent =
                    text;


                items.forEach(
                    function (otherItem) {

                        otherItem.classList.remove(
                            "selected"
                        );

                    }
                );


                this.classList.add(
                    "selected"
                );


                dropdownMenu.classList.remove(
                    "show"
                );

                dropdownButton.classList.remove(
                    "active"
                );

            }
        );

    });


    /* =====================================
       바깥 클릭
    ====================================== */

    document.addEventListener(
        "click",
        function (event) {

            const dropdown =
                document.querySelector(
                    ".search-dropdown"
                );


            if (
                dropdown
                && !dropdown.contains(event.target)
            ) {

                dropdownMenu.classList.remove(
                    "show"
                );

                dropdownButton.classList.remove(
                    "active"
                );

            }

        }
    );

});

</script>

</body>
</html>