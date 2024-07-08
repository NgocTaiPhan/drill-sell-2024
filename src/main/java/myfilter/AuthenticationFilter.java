
package myfilter;

import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter({"/profile.jsp","/viewOrderCustomer", "/cart.jsp", "/order.jsp", "/checkOut/*"}) // Áp dụng cho tất cả các URL để kiểm tra xác thực
public class AuthenticationFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User acc = (User) (session != null ? session.getAttribute("auth") : null);
        String requestURI = req.getRequestURI();

        if (acc == null) {
            session.setAttribute("redirectAfterLogin", requestURI);
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
    }
}
