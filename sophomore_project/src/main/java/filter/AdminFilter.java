package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig)
            throws ServletException {

    }


    @Override
    public void doFilter(
            ServletRequest request,
            ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req =
                (HttpServletRequest) request;

        HttpServletResponse res =
                (HttpServletResponse) response;


        HttpSession session =
                req.getSession(false);



        String userID = null;
        String userRole = null;


        if (session != null) {

            userID =
                    (String) session.getAttribute("userID");

            userRole =
                    (String) session.getAttribute("userRole");

        }


       

        if (userID == null ||
            userID.trim().isEmpty()) {

            res.sendRedirect(
                    req.getContextPath()
                    + "/cookie.jsp"
            );

            return;
        }


        /*
         * 로그인했지만 관리자가 아닌 경우
         */

        if (!"ADMIN".equals(userRole)) {

            res.sendRedirect(
                    req.getContextPath()
                    + "/productsu.jsp"
            );

            return;
        }


        

        chain.doFilter(request, response);
    }


    @Override
    public void destroy() {

    }
}