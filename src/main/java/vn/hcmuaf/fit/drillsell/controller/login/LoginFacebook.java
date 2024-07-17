package vn.hcmuaf.fit.drillsell.controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.hc.client5.http.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.hcmuaf.fit.drillsell.Login.FacebookProp;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.LoginUtils;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFacebook {
    public static void loginFacebook(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        HttpSession session = request.getSession();
        LoginUtils.UserFacebook userFacebook = getUserInfo(accessToken);
        User user = new User(userFacebook.getName(), "", "", userFacebook.getEmail(), "", "", true, "");

//        if (!UserUtils.checkExistEmail(userFacebook.getEmail())) {
//            UserUtils.addUser(user);
//            user = UserUtils.getUserByEmail(userFacebook.getEmail());
//        } else {
//            user = UserUtils.getUserByEmail(userFacebook.getEmail());
//        }

        session.setAttribute("auth", user);
        response.sendRedirect("home.jsp");
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(FacebookProp.getLinkToken())
                .bodyForm(Form.form()
                        .add("client_id", FacebookProp.getClientID())
                        .add("client_secret", FacebookProp.getClientSecret())
                        .add("redirect_uri", FacebookProp.getRedirectURI())
                        .add("code", code)
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").getAsString();
        return accessToken;
    }

    public static LoginUtils.UserFacebook getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = FacebookProp.getUserInfor() + accessToken + "&fields=email,name"; // Đảm bảo yêu cầu cả email và name từ Facebook
        String response = Request.Get(link).execute().returnContent().asString();
        LoginUtils.UserFacebook facebookAccount = new Gson().fromJson(response, LoginUtils.UserFacebook.class);
        return facebookAccount;
    }

}
