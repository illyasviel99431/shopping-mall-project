<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지를 찾을 수 없습니다</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<style>
    body, h1, h2, p, a {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    }
    .error-container {
        padding: 60px 15px;
        text-align: center;
    }
    .error-code {
        font-size: 72px;
        font-weight: 800;
        color: #6c757d;
        line-height: 1;
        margin-bottom: 10px;
    }
</style>
</head>
<body>
    <jsp:include page="menu.jsp" />
    
    <div class="container error-container">
        <div class="error-code">404</div>
        <h1 class="display-4 font-weight-bold mb-3">요청하신 페이지를 찾을 수 없습니다</h1>
        <p class="lead text-muted mb-4">
            방문하시려는 페이지의 주소가 잘못 입력되었거나,<br>
            페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.
        </p>
        <div>
            <a href="welcome.jsp" class="btn btn-primary btn-lg px-4 mr-2">메인으로 이동</a>
            <a href="productsu.jsp" class="btn btn-outline-secondary btn-lg px-4">상품 목록</a>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>