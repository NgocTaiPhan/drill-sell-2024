
package myfilter;

import vn.hcmuaf.fit.drillsell.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {
    public AdminFilter() {
    }

    @Override
    public void destroy() {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
       HttpSession session = req.getSession();
        User acc = (User) session.getAttribute("auth");
        String requestURI = req.getRequestURI();

        if (acc == null || !acc.isRoleUser()) {
            session.setAttribute("redirectAfterLogin", requestURI);
            res.sendRedirect(req.getContextPath() + "/loginAdmin.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }
}
