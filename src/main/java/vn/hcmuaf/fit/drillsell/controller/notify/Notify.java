package vn.hcmuaf.fit.drillsell.controller.notify;

import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Notify {
    private Notify() {
    }

    public static void sendResponse(HttpServletResponse resp, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");

    }
    //Gửi respone đến client kèm theo tin nhắn thông báo
    public static void sendResponseText(HttpServletResponse resp, String mess, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        System.out.println(mess);
        resp.getWriter().write(mess);

    }

    public static void sendResponseAndBackHome(HttpServletResponse resp, String mess, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", mess);
        jsonObject.addProperty("namePage", "OK");
        jsonObject.addProperty("pageUrl", "home.jsp");

        resp.getWriter().write(jsonObject.toString());
    }

    public static void sendResponseAndRedirect(HttpServletResponse resp, String message, Page page, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", message);
        jsonObject.addProperty("namePage", page.getNamePage());
        jsonObject.addProperty("pageUrl", page.getPageUrl());

        resp.getWriter().write(jsonObject.toString());
    }




}
