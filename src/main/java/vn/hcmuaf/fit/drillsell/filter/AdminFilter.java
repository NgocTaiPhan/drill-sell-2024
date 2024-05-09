//package vn.hcmuaf.fit.drillsell.filter;
//
//
//import vn.hcmuaf.fit.drillsell.model.User;
//
//import javax.servlet.*;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//
//public class AdminFilter implements Filter {
//    private ServletContext context;
//    public AdminFilter() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//    @Override
//    public void init(FilterConfig config) throws ServletException {
//    }
//
//    public void destroy() {
//    }
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
//        chain.doFilter(request, response);
//        HttpServletRequest httpRequest = (HttpServletRequest) request;
//        HttpServletResponse httpResponse = (HttpServletResponse) response;
//        HttpSession session = httpRequest.getSession();
//        User user = (User) session.getAttribute("auth");
//        if (user == null) {
//            httpResponse.sendRedirect("LoginController");
//            return;
//        }
//        chain.doFilter(request, response);
//    }
//}
