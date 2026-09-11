<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%
    String userRole = (String) session.getAttribute("userRole");
    String contextPath = request.getContextPath();

    if (!"ADMIN".equals(userRole)) {
        response.sendRedirect(contextPath + "/productsu.jsp");
        return;
    }

    String productId = request.getParameter("id");
    if (productId == null || productId.trim().isEmpty()) {
        response.sendRedirect(contextPath + "/productEdit.jsp");
        return;
    }

    Product product = ProductRepository.getInstance().getProductById(productId);
    if (product == null) {
        response.sendRedirect(contextPath + "/productEdit.jsp");
        return;
    }

    boolean hasImage = product.getFilename() != null && !product.getFilename().trim().isEmpty();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><%=product.getPname()%> 수정 | ILLYA 관리자</title>
    <link rel="stylesheet" href="<%=contextPath%>/css/admin-product.css">
</head>
<body>
    <jsp:include page="menu.jsp" />

    <section class="shop-page-hero">
        <div class="container">
            <h1 data-i18n data-ko="상품 수정" data-en="Edit product">상품 수정</h1>
            <p data-i18n data-ko="상품 정보를 확인하고 필요한 내용을 변경하세요." data-en="Review product details and update what you need.">상품 정보를 확인하고 필요한 내용을 변경하세요.</p>
        </div>
    </section>

    <main class="admin-product-form-page">
        <div class="container">
            <form action="processEditProduct.jsp" method="post" enctype="multipart/form-data" class="admin-product-form-card">
                <header class="admin-product-form-head">
                    <h2><%=product.getPname()%></h2>
                </header>
                <div class="admin-product-form-grid">
                    <section class="admin-product-image-panel">
                        <div class="admin-product-preview">
                            <img id="productImagePreview" src="<%=hasImage ? contextPath + "/images/" + product.getFilename() : ""%>" alt="상품 이미지 미리 보기" <%=hasImage ? "" : "style=\"display:none;\""%>>
                            <span id="imagePreviewEmpty" class="admin-product-preview-empty" <%=hasImage ? "style=\"display:none;\"" : ""%> data-i18n data-ko="이미지를 선택하세요" data-en="Select an image">이미지를 선택하세요</span>
                        </div>
                        <label for="productImage" class="admin-product-file-label" data-i18n data-ko="새 이미지 선택" data-en="Choose new image">새 이미지 선택</label>
                        <input type="file" id="productImage" name="productImage" class="admin-product-file-input" accept="image/*">
                        <p id="imageFileName" class="admin-product-file-name"><%=hasImage ? product.getFilename() : "이미지를 선택하지 않으면 기존 이미지가 유지됩니다."%></p>
                    </section>

                    <section class="admin-product-fields">
                        <div class="admin-product-field-grid">
                            <div class="admin-product-field">
                                <label for="productId" data-i18n data-ko="상품 번호" data-en="Product ID">상품 번호</label>
                                <input type="text" id="productId" name="productId" value="<%=product.getProductId()%>" readonly>
                            </div>
                            <div class="admin-product-field">
                                <label for="pname" data-i18n data-ko="상품명" data-en="Product name">상품명</label>
                                <input type="text" id="pname" name="pname" value="<%=product.getPname()%>" required>
                            </div>
                            <div class="admin-product-field">
                                <label for="unitPrice" data-i18n data-ko="가격" data-en="Price">가격</label>
                                <input type="number" id="unitPrice" name="unitPrice" value="<%=product.getUnitPrice()%>" min="0" required>
                            </div>
                            <div class="admin-product-field">
                                <label for="unitsInStock" data-i18n data-ko="재고" data-en="Stock">재고</label>
                                <input type="number" id="unitsInStock" name="unitsInStock" value="<%=product.getUnitsInStock()%>" min="0" required>
                            </div>
                            <div class="admin-product-field">
                                <label for="manufacturer" data-i18n data-ko="제조사" data-en="Manufacturer">제조사</label>
                                <input type="text" id="manufacturer" name="manufacturer" value="<%=product.getManufacturer()%>" required>
                            </div>
                            <div class="admin-product-field">
                                <label for="category" data-i18n data-ko="카테고리" data-en="Category">카테고리</label>
                                <input type="text" id="category" name="category" value="<%=product.getCategory()%>" required>
                            </div>
                            <div class="admin-product-field">
                                <label for="condition" data-i18n data-ko="상품 상태" data-en="Condition">상품 상태</label>
                                <select id="condition" name="condition">
                                    <option value="New" <%= "New".equals(product.getCondition()) ? "selected" : "" %> data-i18n data-ko="신규" data-en="New">신규</option>
                                    <option value="Old" <%= "Old".equals(product.getCondition()) ? "selected" : "" %> data-i18n data-ko="중고" data-en="Used">중고</option>
                                    <option value="Refurbished" <%= "Refurbished".equals(product.getCondition()) ? "selected" : "" %> data-i18n data-ko="재생" data-en="Refurbished">재생</option>
                                </select>
                            </div>
                            <div class="admin-product-field">
                                <label for="quantity" data-i18n data-ko="주문 수량" data-en="Order quantity">주문 수량</label>
                                <input type="number" id="quantity" name="quantity" value="<%=product.getQuantity()%>" min="1" required>
                            </div>
                            <div class="admin-product-field full">
                                <label for="description" data-i18n data-ko="상품 설명" data-en="Description">상품 설명</label>
                                <textarea id="description" name="description" required><%=product.getDescription()%></textarea>
                            </div>
                        </div>
                    </section>
                </div>
                <footer class="admin-product-form-actions">
                    <a href="productEdit.jsp" class="admin-product-form-cancel" data-i18n data-ko="취소" data-en="Cancel">취소</a>
                    <button type="submit" class="admin-product-form-save" data-i18n data-ko="변경 사항 저장" data-en="Save changes">변경 사항 저장</button>
                </footer>
            </form>
        </div>
    </main>

    <jsp:include page="footer.jsp" />
    <script>
        (function () {
            var imageInput = document.getElementById("productImage");
            var preview = document.getElementById("productImagePreview");
            var emptyMessage = document.getElementById("imagePreviewEmpty");
            var fileName = document.getElementById("imageFileName");
            var previewUrl;

            imageInput.addEventListener("change", function () {
                var file = this.files && this.files[0];
                if (!file) return;
                if (!file.type || file.type.indexOf("image/") !== 0) {
                    alert("이미지 파일만 선택할 수 있습니다.");
                    this.value = "";
                    return;
                }
                if (previewUrl) URL.revokeObjectURL(previewUrl);
                previewUrl = URL.createObjectURL(file);
                preview.src = previewUrl;
                preview.style.display = "block";
                emptyMessage.style.display = "none";
                fileName.textContent = file.name;
            });

            window.addEventListener("beforeunload", function () {
                if (previewUrl) URL.revokeObjectURL(previewUrl);
            });
        })();
    </script>
</body>
</html>
