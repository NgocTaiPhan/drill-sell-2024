package myfilter;

import vn.hcmuaf.fit.drillsell.controller.notify.Page;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

import static vn.hcmuaf.fit.drillsell.controller.notify.Notify.sendResponseAndRedirect;

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
//            sendResponseText(httpResponse, "Bạn chưa đăng nhập", HttpServletResponse.SC_UNAUTHORIZED);
            sendResponseAndRedirect(httpResponse, "Bạn chưa đăng nhập", new Page("Đăng nhập", "login.jsp"), HttpServletResponse.SC_UNAUTHORIZED);
        }

    }
}