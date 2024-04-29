//package vn.hcmuaf.fit.drillsell.authentication;
//
//import javax.servlet.*;
//import javax.servlet.annotation.*;
//import javax.servlet.http.HttpServletRequest;
//import java.io.IOException;
//
//@WebFilter(filterName = "AdminAccessFilter")
//public class AdminAccessFilter implements Filter {
//    public void init(FilterConfig config) throws ServletException {
//    }
//
//    public void destroy() {
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        String path = ((HttpServletRequest) request).getRequestURI().substring(((HttpServletRequest) request).getContextPath().length());
//
//        if (path.startsWith("/admin/")) {
//            // Nếu URL bắt đầu bằng "/admin/", cho phép truy cập
//            chain.doFilter(request, response);
//            return;
//        }
//    }
//}