package myfilter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/cart/*", "/checkout/*", "/profile/*", "/viewOrderCustomer/*"})
public class LoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        String loginUrl = httpRequest.getContextPath() + "/login.jsp";
        boolean loggedIn = (session != null && session.getAttribute("auth") != null),
                loginRequest = httpRequest.getRequestURI().equals(loginUrl);
        if (loggedIn || loginRequest) {
            chain.doFilter(request, response);

        } else {
//            Notify.warningNotify(httpResponse, "Bạn chưa đăng nhập", Page.LOGIN_PAGE);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }

    }
}