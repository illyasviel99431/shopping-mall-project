<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
    String sessionUserRole =
        (String) session.getAttribute("userRole");

    if (!"ADMIN".equals(sessionUserRole)) {
%>

<script>
    alert("관리자만 접근할 수 있습니다.");
    location.href =
        "<%=request.getContextPath()%>/productsu.jsp";
</script>

<%
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="UTF-8">

    <title>상품 등록</title>

    <link
    	rel="stylesheet"
    	href="<%=request.getContextPath()%>/css/bootstrap.css">

	<link
    	rel="stylesheet"
    	href="<%=request.getContextPath()%>/css/myStyle.css">

	<link
    	rel="stylesheet"
    	href="<%=request.getContextPath()%>/css/prodcut-form.css">

</head>

<body>

<fmt:setLocale
    value='<%=request.getParameter("language")%>'/>

<fmt:bundle basename="bundle.message">

<jsp:include page="menu.jsp"/>


<div class="container product-form-page">

    <div class="product-form-card">

        <h1 class="product-form-title">
            상품 등록
        </h1>

        <p class="product-form-description">
            새로운 상품의 정보를 입력해주세요.
        </p>


        <!-- 언어 -->

        <div class="product-language">

            <a href="?language=ko">한국어</a>

            &nbsp;|&nbsp;

            <a href="?language=en">English</a>

        </div>


        <form
            action="processAddProduct.jsp"
            method="post"
            name="newProduct"
            enctype="multipart/form-data">


            <!-- 상품 ID -->

            <div class="product-form-group">

                <label
                    for="productId"
                    class="product-form-label">

                    <fmt:message key="productId"/>

                </label>

                <input
                    type="text"
                    id="productId"
                    name="productId"
                    class="product-form-input"
                    placeholder="예) P1234"
                    required>

            </div>


            <!-- 상품명 -->

            <div class="product-form-group">

                <label
                    for="pname"
                    class="product-form-label">

                    <fmt:message key="pname"/>

                </label>

                <input
                    type="text"
                    id="pname"
                    name="pname"
                    class="product-form-input"
                    placeholder="상품명을 입력하세요"
                    required>

            </div>


            <!-- 가격 -->

            <div class="product-form-group">

                <label
                    for="unitPrice"
                    class="product-form-label">

                    <fmt:message key="unitPrice"/>

                </label>

                <input
                    type="number"
                    id="unitPrice"
                    name="unitPrice"
                    class="product-form-input"
                    min="0"
                    placeholder="가격을 입력하세요"
                    required>

            </div>


            <!-- 설명 -->

            <div class="product-form-group">

                <label
                    for="description"
                    class="product-form-label">

                    <fmt:message key="description"/>

                </label>

                <textarea
                    id="description"
                    name="description"
                    class="product-form-textarea"
                    placeholder="상품 설명을 입력하세요"
                    required></textarea>

            </div>


            <!-- 제조사 -->

            <div class="product-form-group">

                <label
                    for="manufacturer"
                    class="product-form-label">

                    <fmt:message key="manufacturer"/>

                </label>

                <input
                    type="text"
                    id="manufacturer"
                    name="manufacturer"
                    class="product-form-input"
                    required>

            </div>


            <!-- 카테고리 -->

            <div class="product-form-group">

                <label
                    for="category"
                    class="product-form-label">

                    <fmt:message key="category"/>

                </label>

                <input
                    type="text"
                    id="category"
                    name="category"
                    class="product-form-input"
                    placeholder="예) 노트북, 스마트폰"
                    required>

            </div>


            <!-- 재고 -->

            <div class="product-form-group">

                <label
                    for="unitsInStock"
                    class="product-form-label">

                    <fmt:message key="unitsInStock"/>

                </label>

                <input
                    type="number"
                    id="unitsInStock"
                    name="unitsInStock"
                    class="product-form-input"
                    min="0"
                    required>

            </div>


            <!-- 상태 -->

            <div class="product-form-group">

                <label class="product-form-label">
                    상품 상태
                </label>

                <div class="product-condition-group">

                    <label class="product-condition-item">
                        <input
                            type="radio"
                            name="condition"
                            value="New"
                            checked>
                        신상품
                    </label>

                    <label class="product-condition-item">
                        <input
                            type="radio"
                            name="condition"
                            value="Old">
                        중고품
                    </label>

                    <label class="product-condition-item">
                        <input
                            type="radio"
                            name="condition"
                            value="Refurbished">
                        재생품
                    </label>

                </div>

            </div>


            <!-- 이미지 -->

            <div class="product-form-group">

    <label
        for="productImage"
        class="product-form-label">

        상품 이미지

    </label>


    <input
        type="file"
        id="productImage"
        name="productImage"
        class="product-file-input"
        accept="image/*">


    <div
        id="productFileName"
        class="product-file-name">

        선택된 이미지가 없습니다.

    </div>


    <div class="product-preview-title">

        이미지 미리보기

    </div>


    <div class="product-preview-box">

        <span
            id="previewText"
            class="product-preview-placeholder">

            이미지를 선택하면
            <br>
            이곳에 미리보기가 표시됩니다.

        </span>


        <img
            id="imagePreview"
            src=""
            alt="상품 이미지 미리보기">

    </div>

</div>

            <!-- 버튼 -->

            <div class="product-form-buttons">

                <button
                    type="reset"
                    class="product-form-button product-form-cancel">

                    다시 입력

                </button>

                <button
                    type="submit"
                    class="product-form-button product-form-submit">

                    상품 등록

                </button>

            </div>

        </form>

    </div>

</div>


<%@ include file="footer.jsp"%>

</fmt:bundle>


<script>

document.addEventListener(
    "DOMContentLoaded",
    function () {

        const input =
            document.getElementById("productImage");

        const preview =
            document.getElementById("imagePreview");

        const previewText =
            document.getElementById("previewText");

        const fileName =
            document.getElementById("productFileName");


        input.addEventListener(
            "change",
            function () {

                const file =
                    this.files[0];


                if (!file) {

                    preview.src = "";

                    preview.style.display =
                        "none";

                    previewText.style.display =
                        "block";

                    fileName.textContent =
                        "선택된 이미지가 없습니다.";

                    return;
                }


                if (!file.type.startsWith("image/")) {

                    alert(
                        "이미지 파일만 선택할 수 있습니다."
                    );

                    this.value = "";

                    preview.src = "";

                    preview.style.display =
                        "none";

                    previewText.style.display =
                        "block";

                    fileName.textContent =
                        "선택된 이미지가 없습니다.";

                    return;
                }


                fileName.textContent =
                    "선택한 이미지: "
                    + file.name;


                const reader =
                    new FileReader();


                reader.onload =
                    function(event) {

                        preview.src =
                            event.target.result;

                        preview.style.display =
                            "block";

                        previewText.style.display =
                            "none";
                    };


                reader.readAsDataURL(file);

            }
        );

    }
);

</script>


</body>
</html>