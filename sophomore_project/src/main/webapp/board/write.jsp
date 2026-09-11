<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String userId =
        (String) session.getAttribute("userID");

    if (userId == null
        || userId.trim().isEmpty()) {
%>

<script>

    alert("로그인이 필요합니다.");

    location.href =
        "<%=request.getContextPath()%>/cookie.jsp";

</script>

<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>Q&A 글쓰기</title>

    <link
        rel="stylesheet"
        href="<%=request.getContextPath()%>/css/bootstrap.css">

    <link
        rel="stylesheet"
        href="<%=request.getContextPath()%>/css/myStyle.css">

    <link
        rel="stylesheet"
        href="<%=request.getContextPath()%>/css/board.css">

</head>

<body>

<jsp:include page="/menu.jsp"/>


<div class="board-page">


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


    <div class="board-write-card">

        <div class="board-write-header">

            <h2>
                문의사항 작성
            </h2>

            <p>
                문의 내용을 자세하게 작성해주세요.
            </p>

        </div>


        <form
            action="<%=request.getContextPath()%>/BoardWriteAction.do"
            method="post">


            <div class="board-write-body">


                <!-- 제목 -->

                <div class="board-write-group">

                    <label
                        for="subject">

                        제목

                        <span>*</span>

                    </label>

                    <input
                        type="text"
                        id="subject"
                        name="subject"
                        class="board-write-input"
                        maxlength="100"
                        placeholder="제목을 입력해주세요."
                        required>

                </div>


                <!-- 내용 -->

                <div class="board-write-group">

                    <label
                        for="content">

                        내용

                        <span>*</span>

                    </label>

                    <textarea
                        id="content"
                        name="content"
                        class="board-write-textarea"
                        placeholder="문의하실 내용을 입력해주세요."
                        required></textarea>

                    

                </div>

            </div>


            <div class="board-write-footer">

                <a
                    href="<%=request.getContextPath()%>/BoardListAction.do?pageNum=1"
                    class="board-write-cancel">

                    취소

                </a>

                <button
                    type="submit"
                    class="board-write-submit">

                    등록

                </button>

            </div>


        </form>

    </div>

</div>


<jsp:include page="/footer.jsp"/>

</body>
</html>