package vn.hcmuaf.fit.drillsell.controller.notify;

import com.google.gson.JsonObject;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class Notify {
    public static void successNotify(HttpServletResponse response, String message, Page page) throws IOException {
        sendNotify(response, Type.SUCCESS, message, page);
    }

    public static void errorNotify(HttpServletResponse response, String message, Page page) throws IOException {
        sendNotify(response, Type.ERROR, message, page);
    }

    public static void warningNotify(HttpServletResponse response, String message, Page page) throws IOException {
        sendNotify(response, Type.WARNING, message, page);
    }

    public static void infoNotify(HttpServletResponse response, String message, Page page) throws IOException {
        sendNotify(response, Type.INFO, message, page);
    }

    public static void normalNotify(HttpServletResponse response, String message, Page page) throws IOException {
        sendNotify(response, Type.NO_TYPE, message, page);
    }


    public static void sendNotify(HttpServletResponse response, String type, String message, Page page) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("message", message);
        jsonObject.addProperty("type", type);
        jsonObject.addProperty("namePage", page.getNamePage());
        jsonObject.addProperty("pageUrl", page.getPageUrl());

        response.getWriter().write(jsonObject.toString());
    }


}
