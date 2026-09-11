<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>

<%
    request.setCharacterEncoding("UTF-8");


    // =====================================================
    // 로그인 여부 확인
    // =====================================================

    String userID =
            (String) session.getAttribute("userID");

    if (userID == null ||
        userID.trim().isEmpty()) {

        response.sendRedirect("cookie.jsp");
        return;
    }


    // =====================================================
    // 장바구니 확인
    // =====================================================

    ArrayList<Product> cartList =
            (ArrayList<Product>) session.getAttribute("cartlist");

    if (cartList == null ||
        cartList.isEmpty()) {

        response.sendRedirect("cart.jsp");
        return;
    }


    // =====================================================
    // 배송 정보 받기
    // =====================================================

    String cartId =
            request.getParameter("cartId");

    String name =
            request.getParameter("name");

    String phone =
            request.getParameter("phone");

    String zipCode =
            request.getParameter("zipCode");

    String address =
            request.getParameter("address");

    String shippingDate =
            request.getParameter("shippingDate");


    // =====================================================
    // 입력값 검사
    // =====================================================

    if (name == null ||
        name.trim().isEmpty() ||

        phone == null ||
        phone.trim().isEmpty() ||

        zipCode == null ||
        zipCode.trim().isEmpty() ||

        address == null ||
        address.trim().isEmpty() ||

        shippingDate == null ||
        shippingDate.trim().isEmpty()) {

        response.sendRedirect("shippingInfo.jsp");
        return;
    }


    // =====================================================
    // cartId가 없는 경우
    // 현재 장바구니 세션이 있으므로 주문 진행 가능
    // =====================================================

    if (cartId == null) {
        cartId = "";
    }


    // =====================================================
    // 배송정보 쿠키 생성
    // 한글을 UTF-8로 인코딩
    // =====================================================

    Cookie cookieCartId =
            new Cookie(
                "Shipping_cartId",
                URLEncoder.encode(cartId, "UTF-8")
            );

    Cookie cookieName =
            new Cookie(
                "Shipping_name",
                URLEncoder.encode(name, "UTF-8")
            );

    Cookie cookiePhone =
            new Cookie(
                "Shipping_phone",
                URLEncoder.encode(phone, "UTF-8")
            );

    Cookie cookieZipCode =
            new Cookie(
                "Shipping_zipCode",
                URLEncoder.encode(zipCode, "UTF-8")
            );

    Cookie cookieAddress =
            new Cookie(
                "Shipping_address",
                URLEncoder.encode(address, "UTF-8")
            );

    Cookie cookieShippingDate =
            new Cookie(
                "Shipping_shippingDate",
                URLEncoder.encode(shippingDate, "UTF-8")
            );


    // =====================================================
    // 쿠키 유효기간
    // 24시간
    // =====================================================

    int maxAge =
            24 * 60 * 60;

    cookieCartId.setMaxAge(maxAge);
    cookieName.setMaxAge(maxAge);
    cookiePhone.setMaxAge(maxAge);
    cookieZipCode.setMaxAge(maxAge);
    cookieAddress.setMaxAge(maxAge);
    cookieShippingDate.setMaxAge(maxAge);


    // =====================================================
    // 쿠키 저장
    // =====================================================

    response.addCookie(cookieCartId);
    response.addCookie(cookieName);
    response.addCookie(cookiePhone);
    response.addCookie(cookieZipCode);
    response.addCookie(cookieAddress);
    response.addCookie(cookieShippingDate);


    // =====================================================
    // 주문 확인 페이지 이동
    // =====================================================

    response.sendRedirect("orderConfirmation.jsp");

    return;
%>