package filter;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentTime = formatter.format(new Date());

        // 웹 페이지(JSP)에서 사용할 수 있도록 request 객체에 값 저장
        req.setAttribute("logTime", currentTime);
        req.setAttribute("clientIp", req.getRemoteAddr());
        req.setAttribute("requestUri", req.getRequestURI());
        req.setAttribute("httpMethod", req.getMethod());

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}