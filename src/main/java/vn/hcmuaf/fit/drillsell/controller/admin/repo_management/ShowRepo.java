package vn.hcmuaf.fit.drillsell.controller.admin.repo_management;

import com.google.gson.Gson;
import vn.hcmuaf.fit.drillsell.utils.RepoUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class ShowRepo {

    protected static void showRepo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Map<String, Object>> repoValue = RepoUtils.getRepo();
        Gson gson = new Gson();

//        Chuyển đổi dữ liệu của kho sang json gửi đi
        String json = gson.toJson(repoValue);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
        System.out.println(json);
    }
}