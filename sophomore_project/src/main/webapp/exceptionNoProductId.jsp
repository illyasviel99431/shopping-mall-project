<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품을 찾을 수 없습니다</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<style>
    body, h1, h2, p, a {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    }
    .error-container {
        padding: 60px 15px;
        text-align: center;
    }
    .error-icon {
        font-size: 64px;
        color: #dc3545;
        margin-bottom: 20px;
    }
</style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    
    <div class="container error-container">
        <div class="error-icon">⚠️</div>
        <h1 class="display-4 font-weight-bold mb-3">해당 상품이 존재하지 않습니다</h1>
        <p class="lead text-muted mb-4">
            요청하신 상품 정보가 삭제되었거나, 잘못된 상품 번호입니다.<br>
            입력하신 주소가 올바른지 다시 한번 확인해 주세요.
        </p>
        <div>
            <a href="productsu.jsp" class="btn btn-primary btn-lg px-4 mr-2">상품 목록으로 이동</a>
            <a href="welcome.jsp" class="btn btn-outline-secondary btn-lg px-4">메인으로 이동</a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>