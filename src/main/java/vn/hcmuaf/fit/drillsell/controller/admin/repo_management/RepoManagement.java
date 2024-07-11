package vn.hcmuaf.fit.drillsell.controller.admin.repo_management;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RepoManagement", urlPatterns = {"/admin/show-repo", "/admin/update-quantity"})
public class RepoManagement extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("UTF-8");
        String servletPath = request.getServletPath();
        switch (servletPath) {
            case "/admin/show-repo" -> ShowRepo.showRepo(request, response);
            case "/admin/update-quantity" -> UpdateQuantity.updateQuantity(request, response);
        }
    }


}

