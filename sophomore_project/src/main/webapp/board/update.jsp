<%@ page import="mvc.model.BoardDTO"%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    BoardDTO board =
        (BoardDTO) request.getAttribute("board");

    String contextPath =
        request.getContextPath();
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>게시글 수정 | 게시판</title>

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
           상단 제목
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
           수정 카드
        ========================= */

        .form-card {
            background-color: #ffffff;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.06);
            overflow: hidden;
        }

        /* =========================
           카드 상단
        ========================= */

        .form-header {
            padding: 28px 35px;
            border-bottom: 1px solid #edf0f2;
        }

        .form-header-title {
            margin: 0;
            font-size: 18px;
            font-weight: 700;
            color: #212529;
        }

        .form-header-text {
            margin: 7px 0 0;
            color: #adb5bd;
            font-size: 13px;
        }

        /* =========================
           폼 영역
        ========================= */

        .form-body {
            padding: 35px;
        }

        .form-group-custom {
            margin-bottom: 25px;
        }

        .form-group-custom:last-child {
            margin-bottom: 0;
        }

        .form-label-custom {
            display: block;
            margin-bottom: 9px;
            color: #343a40;
            font-size: 14px;
            font-weight: 600;
        }

        .required-mark {
            margin-left: 2px;
            color: #dc3545;
        }

        /* 제목 */

        .subject-input {
            width: 100%;
            height: 50px;
            padding: 0 16px;
            border: 1px solid #dee2e6;
            border-radius: 9px;
            background-color: #ffffff;
            color: #212529;
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .subject-input:focus {
            border-color: #adb5bd;
            box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.04);
        }

        /* 내용 */

        .content-textarea {
            display: block;
            width: 100%;
            min-height: 400px;
            padding: 16px;
            border: 1px solid #dee2e6;
            border-radius: 9px;
            background-color: #ffffff;
            color: #212529;
            font-family: inherit;
            font-size: 15px;
            line-height: 1.8;
            resize: vertical;
            outline: none;
            transition: border-color 0.2s ease,
                        box-shadow 0.2s ease;
        }

        .content-textarea:focus {
            border-color: #adb5bd;
            box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.04);
        }

        /* 안내 문구 */

        .form-help {
            margin-top: 8px;
            color: #adb5bd;
            font-size: 12px;
        }

        /* =========================
           하단 버튼
        ========================= */

        .form-footer {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 8px;
            padding: 22px 35px;
            border-top: 1px solid #edf0f2;
            background-color: #fafbfc;
        }

        .form-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 43px;
            min-width: 90px;
            padding: 0 18px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none !important;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-cancel {
            border: 1px solid #dee2e6;
            background-color: #ffffff;
            color: #495057 !important;
        }

        .btn-cancel:hover {
            background-color: #f1f3f5;
            color: #212529 !important;
        }

        .btn-submit {
            border: 1px solid #212529;
            background-color: #212529;
            color: #ffffff;
        }

        .btn-submit:hover {
            background-color: #343a40;
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

            .form-header {
                padding: 25px 22px;
            }

            .form-body {
                padding: 25px 22px;
            }

            .form-footer {
                padding: 20px 22px;
            }

            .content-textarea {
                min-height: 320px;
            }

            .form-button {
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
            작성한 문의사항을 수정할 수 있습니다.
        </p>

    </div>


    <!-- =========================
         수정 폼
    ========================== -->

    <form
        action="<%=contextPath%>/BoardUpdateAction.do"
        method="post"
        class="form-card">


        <!-- 카드 상단 -->

        <div class="form-header">

            <h2 class="form-header-title">
                게시글 수정
            </h2>

            <p class="form-header-text">
                내용을 수정한 후 저장 버튼을 눌러주세요.
            </p>

        </div>


        <!-- 폼 본문 -->

        <div class="form-body">

            <input
                type="hidden"
                name="num"
                value="<%=board.getNum()%>">


            <!-- 제목 -->

            <div class="form-group-custom">

                <label
                    for="subject"
                    class="form-label-custom">

                    제목
                    <span class="required-mark">*</span>

                </label>

                <input
                    type="text"
                    id="subject"
                    name="subject"
                    class="subject-input"
                    value="<%=board.getSubject()%>"
                    maxlength="100"
                    required>

            </div>


            <!-- 내용 -->

            <div class="form-group-custom">

                <label
                    for="content"
                    class="form-label-custom">

                    내용
                    <span class="required-mark">*</span>

                </label>

                <textarea
                    id="content"
                    name="content"
                    class="content-textarea"
                    required><%=board.getContent()%></textarea>

                <div class="form-help">
                    문의사항의 내용을 자세하게 작성해주세요.
                </div>

            </div>

        </div>


        <!-- 하단 버튼 -->

        <div class="form-footer">

            <a
                href="<%=contextPath%>/BoardViewAction.do?num=<%=board.getNum()%>"
                class="form-button btn-cancel">

                취소

            </a>


            <button
                type="submit"
                class="form-button btn-submit">

                수정 완료

            </button>

        </div>

    </form>

</div>


<jsp:include page="/footer.jsp"/>

</body>

</html>