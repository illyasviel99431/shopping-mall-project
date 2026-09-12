<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository"%>

<%
    // 관리자 확인
    String addUserRole = (String) session.getAttribute("userRole");

    if (!"ADMIN".equals(addUserRole)) {
%>

<script>
    alert("관리자만 접근할 수 있습니다.");
    location.href = "productsu.jsp";
</script>

<%
        return;
    }


    request.setCharacterEncoding("UTF-8");


    String realFolder =
            application.getRealPath("/images/");

    String encType = "UTF-8";

    int maxSize =
            5 * 1024 * 1024;


    MultipartRequest multi =
            new MultipartRequest(
                    request,
                    realFolder,
                    maxSize,
                    encType,
                    new DefaultFileRenamePolicy()
            );


    // 상품 정보
    String productId =
            multi.getParameter("productId");

    String pname =
            multi.getParameter("pname");

    String unitPrice =
            multi.getParameter("unitPrice");

    String description =
            multi.getParameter("description");

    String manufacturer =
            multi.getParameter("manufacturer");

    String category =
            multi.getParameter("category");

    String unitsInStock =
            multi.getParameter("unitsInStock");

    String condition =
            multi.getParameter("condition");


    // 가격
    int price = 0;

    if (unitPrice != null &&
        !unitPrice.trim().isEmpty()) {

        price = Integer.parseInt(unitPrice);

    }


    // 재고
    long stock = 0;

    if (unitsInStock != null &&
        !unitsInStock.trim().isEmpty()) {

        stock = Long.parseLong(unitsInStock);

    }


    int productQuantity = 1;

    String fileName = null;

    Enumeration files =
            multi.getFileNames();

    if (files.hasMoreElements()) {

        String fname =
                (String) files.nextElement();

        fileName =
                multi.getFilesystemName(fname);

    }


    ProductRepository dao =
            ProductRepository.getInstance();

    if (productId != null
            && dao.getProductById(productId.trim()) != null) {
%>

<script>
    alert("이미 있는 상품 코드입니다.");
    history.back();
</script>

<%
        return;
    }

    Product newProduct =
            new Product();

    newProduct.setProductId(productId);
    newProduct.setPname(pname);
    newProduct.setUnitPrice(price);
    newProduct.setDescription(description);
    newProduct.setManufacturer(manufacturer);
    newProduct.setCategory(category);
    newProduct.setUnitsInStock(stock);
    newProduct.setCondition(condition);
    newProduct.setFilename(fileName);
    newProduct.setQuantity(productQuantity);


    boolean isAdded =
            dao.addProduct(newProduct);

    if (!isAdded) {
%>

<script>
    alert("상품 등록에 실패했습니다. 입력 내용을 다시 확인해주세요.");
    history.back();
</script>

<%
        return;
    }

    response.sendRedirect("productsu.jsp");
%>
