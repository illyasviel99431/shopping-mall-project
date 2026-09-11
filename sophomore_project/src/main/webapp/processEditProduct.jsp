<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>

<%
    String editUserRole =
            (String) session.getAttribute("userRole");


    if (!"ADMIN".equals(editUserRole)) {
%>

<script>

alert("관리자만 접근할 수 있습니다.");

location.href =
    "<%=request.getContextPath()%>/productsu.jsp";

</script>

<%
        return;
    }


    String realFolder =
            application.getRealPath("/images/");


    int maxSize =
            5 * 1024 * 1024;


    MultipartRequest multi;

    try {

        multi =
                new MultipartRequest(
                        request,
                        realFolder,
                        maxSize,
                        "UTF-8",
                        new DefaultFileRenamePolicy()
                );

    } catch (Exception e) {
%>

<script>

alert("이미지 업로드 중 오류가 발생했습니다.");

history.back();

</script>

<%
        return;
    }


    String productId =
            multi.getParameter("productId");


    if (productId == null
            || productId.trim().isEmpty()) {
%>

<script>

alert("상품 정보가 없습니다.");

location.href =
    "<%=request.getContextPath()%>/productEdit.jsp";

</script>

<%
        return;
    }


    ProductRepository dao =
            ProductRepository.getInstance();


    Product product =
            dao.getProductById(productId);


    if (product == null) {
%>

<script>

alert("존재하지 않는 상품입니다.");

location.href =
    "<%=request.getContextPath()%>/productEdit.jsp";

</script>

<%
        return;
    }


    String newFileName =
            multi.getFilesystemName("productImage");


    if (newFileName != null
            && !newFileName.trim().isEmpty()) {

        product.setFilename(
                newFileName
        );
    }


    product.setPname(
            multi.getParameter("pname")
    );


    product.setUnitPrice(
            Integer.parseInt(
                    multi.getParameter("unitPrice")
            )
    );


    product.setDescription(
            multi.getParameter("description")
    );


    product.setManufacturer(
            multi.getParameter("manufacturer")
    );


    product.setCategory(
            multi.getParameter("category")
    );


    product.setUnitsInStock(
            Long.parseLong(
                    multi.getParameter("unitsInStock")
            )
    );


    product.setCondition(
            multi.getParameter("condition")
    );


    product.setQuantity(
            Integer.parseInt(
                    multi.getParameter("quantity")
            )
    );


    dao.updateProduct(product);


    response.sendRedirect(
            request.getContextPath()
                    + "/productEdit.jsp"
    );
%>
