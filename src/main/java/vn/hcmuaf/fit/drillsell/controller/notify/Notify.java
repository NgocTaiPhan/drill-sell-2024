package vn.hcmuaf.fit.drillsell.controller.notify;

import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Notify {
    private Notify() {
    }


    //Gửi respone đến client kèm theo tin nhắn thông báo
    public static void sendResponseText(HttpServletResponse resp, String mess, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        System.out.println(mess);
        resp.getWriter().write(mess);

    }

    public static void sendResponseWithRedirect(HttpServletResponse resp, String message, String url, int status) throws IOException {
        resp.setStatus(status);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", message);
        jsonObject.addProperty("url", url);

        resp.getWriter().write(jsonObject.toString());
    }




}
