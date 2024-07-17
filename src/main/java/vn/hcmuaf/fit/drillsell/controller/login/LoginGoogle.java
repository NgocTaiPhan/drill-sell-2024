package vn.hcmuaf.fit.drillsell.controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.hcmuaf.fit.drillsell.Login.Constants;
import vn.hcmuaf.fit.drillsell.model.User;
import vn.hcmuaf.fit.drillsell.utils.LoginUtils;
import vn.hcmuaf.fit.drillsell.utils.UserUtils;

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
        HttpSession session = request.getSession();

        try {
            // Lấy access token từ mã xác thực
            String accessToken = getToken(code);

            // Lấy thông tin người dùng từ access token sau đó lưu vào user
            LoginUtils.UserGoogleDTO userGoogleDTO = getUserInfo(accessToken);
            User user = UserUtils.getUserByEmail(userGoogleDTO.getEmail());

            if (user == null) {
                UserUtils.addUser(new User(userGoogleDTO.getId(), userGoogleDTO.getName(), userGoogleDTO.getEmail()));
                user = UserUtils.getUserByEmail(userGoogleDTO.getEmail());
            }

            // Lưu thông tin người dùng vào session
            session.setAttribute("auth", user);

            // Chuyển hướng đến trang chính sau khi đăng nhập thành công
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (IOException | ServletException e) {
            // Xử lý các exception có thể xảy ra
            e.printStackTrace();
            throw new ServletException("Error processing Google login", e);
        }
    }

    // Phương thức lấy access token từ mã xác thực
    public static String getToken(String code) throws IOException {
        // Gọi API để lấy token từ mã xác thực
        String response = Request.Post(Constants.getLinkToken())
                .bodyForm(Form.form()
                        .add("client_id", Constants.getClientID())
                        .add("client_secret", Constants.getClientSecret())
                        .add("redirect_uri", Constants.getRedirectURI())
                        .add("code", code)
                        .add("grant_type", Constants.getGrantType())
                        .build())
                .execute().returnContent().asString();

        // Chuyển đổi phản hồi từ API thành access token
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        return jobj.get("access_token").getAsString();
    }

    // Phương thức lấy thông tin người dùng từ access token
    public static LoginUtils.UserGoogleDTO getUserInfo(final String accessToken) throws IOException {
        // Gọi API để lấy thông tin người dùng từ access token
        String link = Constants.getUserInfor() + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        // Chuyển đổi phản hồi từ API thành đối tượng UserGoogleDto
        return new Gson().fromJson(response, LoginUtils.UserGoogleDTO.class);
    }
}
