<%@ page import="mvc.model.BoardDTO"%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    BoardDTO board =
        (BoardDTO) request.getAttribute("board");

    String userId =
        (String) session.getAttribute("userID");

    String userRole =
        (String) session.getAttribute("userRole");

    String contextPath =
        request.getContextPath();

    int pageNum = 1;

    try {
        pageNum =
            Integer.parseInt(
                request.getParameter("pageNum")
            );
    } catch (Exception e) {
        pageNum = 1;
    }

    String searchType =
        request.getParameter("searchType");

    String keyword =
        request.getParameter("keyword");

    if (searchType == null) {
        searchType = "all";
    }

    if (keyword == null) {
        keyword = "";
    }

    String encodedKeyword =
        java.net.URLEncoder.encode(
            keyword,
            "UTF-8"
        );

    boolean canManage =
        "ADMIN".equals(userRole)
        || (
            userId != null
            && userId.equals(board.getId())
        );
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title><%= board.getSubject() %> | 게시판</title>

    <link
        rel="stylesheet"
        href="../css/bootstrap.css">

    <link
        rel="stylesheet"
        href="../css/myStyle.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            background-color: #f7f8fa;
            color: #212529;
        }

        /* =========================
           전체 영역
        ========================= */

        .board-page {
            width: 100%;
            max-width: 1050px;
            margin: 0 auto;
            padding: 65px 25px 80px;
        }

        /* =========================
           상단
        ========================= */

        .board-header {
            margin-bottom: 28px;
        }

        .board-label {
            display: inline-block;
            margin-bottom: 10px;
            padding: 6px 12px;
            border-radius: 20px;
            background-color: #eef2f7;
            color: #495057;
            font-size: 13px;
            font-weight: 600;
        }

        .board-title {
            margin: 0;
            font-size: 36px;
            font-weight: 800;
            letter-spacing: -1px;
            color: #212529;
        }

        .board-description {
            margin-top: 10px;
            margin-bottom: 0;
            color: #868e96;
            font-size: 15px;
        }

        /* =========================
           게시글 카드
        ========================= */

        .post-card {
            background-color: #ffffff;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        /* =========================
           게시글 제목 영역
        ========================= */

        .post-header {
            padding: 30px 35px 25px;
            border-bottom: 1px solid #edf0f2;
        }

        .post-subject {
            margin: 0 0 20px;
            color: #212529;
            font-size: 27px;
            font-weight: 700;
            line-height: 1.4;
            word-break: break-word;
        }

        /* =========================
           게시글 정보
        ========================= */

        .post-info {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 7px 18px;
            color: #868e96;
            font-size: 13px;
        }

        .post-info-item {
            display: inline-flex;
            align-items: center;
        }

        .post-info-label {
            margin-right: 5px;
            color: #adb5bd;
        }

        .post-info-value {
            color: #495057;
            font-weight: 500;
        }

        .post-divider {
            color: #dee2e6;
        }

        /* =========================
           게시글 내용
        ========================= */

        .post-content {
            min-height: 350px;
            padding: 40px 35px;
            color: #343a40;
            font-size: 15px;
            line-height: 1.9;
            word-break: break-word;
            white-space: pre-wrap;
        }

        /* =========================
           하단 버튼 영역
        ========================= */

        .post-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            padding: 22px 35px;
            border-top: 1px solid #edf0f2;
            background-color: #fafbfc;
        }

        .left-buttons,
        .right-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .board-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 42px;
            padding: 0 17px;
            border-radius: 8px;
            text-decoration: none !important;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .btn-list {
            border: 1px solid #dee2e6;
            background-color: #ffffff;
            color: #495057 !important;
        }

        .btn-list:hover {
            background-color: #f1f3f5;
            color: #212529 !important;
        }

        .btn-edit {
            border: 1px solid #212529;
            background-color: #212529;
            color: #ffffff !important;
        }

        .btn-edit:hover {
            background-color: #343a40;
            color: #ffffff !important;
        }

        .btn-delete {
            border: 1px solid #dc3545;
            background-color: #ffffff;
            color: #dc3545 !important;
        }

        .btn-delete:hover {
            background-color: #dc3545;
            color: #ffffff !important;
        }

        /* =========================
           조회수 영역
        ========================= */

        .hit-box {
            color: #868e96;
            font-size: 13px;
        }

        .hit-number {
            color: #495057;
            font-weight: 600;
        }

        /* =========================
           반응형
        ========================= */

        @media (max-width: 700px) {

            .board-page {
                padding: 40px 15px 60px;
            }

            .board-title {
                font-size: 28px;
            }

            .post-header {
                padding: 25px 22px 20px;
            }

            .post-subject {
                font-size: 22px;
            }

            .post-content {
                min-height: 280px;
                padding: 30px 22px;
                font-size: 14px;
            }

            .post-footer {
                display: block;
                padding: 20px 22px;
            }

            .left-buttons,
            .right-buttons {
                width: 100%;
            }

            .left-buttons {
                margin-bottom: 8px;
            }

            .right-buttons {
                justify-content: flex-end;
            }

            .board-btn {
                flex: 1;
            }
        }

    </style>

</head>

<body>

<jsp:include page="/menu.jsp"/>


<div class="board-page">

    <!-- =========================
         페이지 제목
    ========================== -->

    <div class="board-header">

        <div class="board-label">
            CUSTOMER SERVICE
        </div>

        <h1 class="board-title">
            게시판
        </h1>

        <p class="board-description">
            문의사항의 자세한 내용을 확인할 수 있습니다.
        </p>

    </div>


    <!-- =========================
         게시글
    ========================== -->

    <div class="post-card">


        <!-- =========================
             제목 + 게시글 정보
        ========================== -->

        <div class="post-header">

            <h2 class="post-subject">
                <%= board.getSubject() %>
            </h2>


            <div class="post-info">

                <div class="post-info-item">

                    <span class="post-info-label">
                        작성자
                    </span>

                    <span class="post-info-value">
                        <%= board.getName() %>
                    </span>

                </div>


                <span class="post-divider">
                    |
                </span>


                <div class="post-info-item">

                    <span class="post-info-label">
                        작성일
                    </span>

                    <span class="post-info-value">
                        <%= board.getRegist_day() %>
                    </span>

                </div>


                <span class="post-divider">
                    |
                </span>


                <div class="post-info-item">

                    <span class="post-info-label">
                        수정일
                    </span>

                    <span class="post-info-value">
                        <%= board.getUpdate_day() %>
                    </span>

                </div>


                <span class="post-divider">
                    |
                </span>


                <div class="post-info-item">

                    <span class="post-info-label">
                        조회
                    </span>

                    <span class="post-info-value">
                        <%= board.getHit() %>
                    </span>

                </div>

            </div>

        </div>


        <!-- =========================
             게시글 내용
        ========================== -->

        <div class="post-content"><%= board.getContent() %></div>


        <!-- =========================
             하단 버튼
        ========================== -->

        <div class="post-footer">


            <!-- 왼쪽 -->

            <div class="left-buttons">

                <a
                    href="<%=contextPath%>/BoardListAction.do?pageNum=<%=pageNum%>&searchType=<%=searchType%>&keyword=<%=encodedKeyword%>"
                    class="board-btn btn-list">

                    목록

                </a>

            </div>


            <!-- 오른쪽 -->

            <div class="right-buttons">

            <%
                if (canManage) {
            %>

                <a
                    href="<%=contextPath%>/BoardUpdateForm.do?num=<%=board.getNum()%>"
                    class="board-btn btn-edit">

                    수정

                </a>


                <a
                    href="#"
                    class="board-btn btn-delete"
                    onclick="deleteBoard(); return false;">

                    삭제

                </a>

            <%
                }
            %>

            </div>

        </div>

    </div>

</div>


<jsp:include page="/footer.jsp"/>


<script>

    function deleteBoard() {

        const result =
            confirm(
                "정말 이 게시글을 삭제하시겠습니까?"
            );

        if (!result) {
            return;
        }

        location.href =
            "<%=contextPath%>/BoardDeleteAction.do?num=<%=board.getNum()%>";

    }

</script>

</body>
</html>