package vn.hcmuaf.fit.drillsell.controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.hcmuaf.fit.drillsell.GoogleLogin.Constants;
import vn.hcmuaf.fit.drillsell.model.UserGoogleDto;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginGoogle {

    // Phương thức thực hiện đăng nhập bằng Google
    public static void loginGoogle(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy mã xác thực từ request
        String code = request.getParameter("code");

        // Lấy access token từ mã xác thực
        String accessToken = getToken(code);

        // Lấy thông tin người dùng từ access token
        UserGoogleDto user = getUserInfo(accessToken);
        System.out.println(user.toString());
        // Lưu thông tin người dùng vào session
        HttpSession session = request.getSession();
        session.setAttribute("auth-google", user);
        session.setAttribute("logged", true);

        // Chuyển hướng đến trang chính sau khi đăng nhập thành công
        response.sendRedirect("home.jsp");
    }

    // Phương thức lấy access token từ mã xác thực
    public static String getToken(String code) throws ClientProtocolException, IOException {
        // Gọi API để lấy token từ mã xác thực
        String response = Request.Post(Constants.getLinkToken())
                .bodyForm(Form.form().add("client_id", Constants.getClientID())
                        .add("client_secret", Constants.getClientSecret())
                        .add("redirect_uri", Constants.getRedirectURI())
                        .add("code", code)
                        .add("grant_type", Constants.getGrantType())
                        .build())
                .execute().returnContent().asString();

        // Chuyển đổi phản hồi từ API thành access token
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    // Phương thức lấy thông tin người dùng từ access token
    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        // Gọi API để lấy thông tin người dùng từ access token
        String link = Constants.getUserInfor() + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        // Chuyển đổi phản hồi từ API thành đối tượng UserGoogleDto
        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

        return googlePojo;
    }
}
