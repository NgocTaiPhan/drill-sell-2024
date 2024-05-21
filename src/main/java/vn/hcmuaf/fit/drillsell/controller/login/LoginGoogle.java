package vn.hcmuaf.fit.drillsell.controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.hcmuaf.fit.drillsell.GoogleLogin.Constants;
import vn.hcmuaf.fit.drillsell.model.User;

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
        boolean logged = false;

        // Lấy access token từ mã xác thực
        String accessToken = getToken(code);

        // Lấy thông tin người dùng từ access token sau đó lưu vào user
        UserGoogleDto userGoogleDto = getUserInfo(accessToken);
        User user = new User(userGoogleDto.getId(), userGoogleDto.getName(), userGoogleDto.getEmail());
        System.out.println(userGoogleDto.toString() + "/n" + user.toString());
        // Lưu thông tin người dùng vào session
        HttpSession session = request.getSession();
        session.setAttribute("auth", user);

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
        return jobj.get("access_token").toString().replaceAll("\"", "");
    }

    // Phương thức lấy thông tin người dùng từ access token
    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        // Gọi API để lấy thông tin người dùng từ access token
        String link = Constants.getUserInfor() + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        // Chuyển đổi phản hồi từ API thành đối tượng UserGoogleDto

        return new Gson().fromJson(response, UserGoogleDto.class);
    }

    //Inner class để lưu thông tin người dùng khi đăng nhập bằng google
    class UserGoogleDto {

        private String id;

        private String email;

        private boolean verifiedEmail;

        private String name;

        private String givenName;

        private String familyName;

        private String picture;

        public UserGoogleDto() {
        }

        public UserGoogleDto(String id, String email, boolean verifiedEmail, String name, String givenName, String familyName, String picture) {
            this.id = id;
            this.email = email;
            this.verifiedEmail = verifiedEmail;
            this.name = name;
            this.givenName = givenName;
            this.familyName = familyName;
            this.picture = picture;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public boolean isVerifiedEmail() {
            return verifiedEmail;
        }

        public void setVerifiedEmail(boolean verified_email) {
            this.verifiedEmail = verified_email;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getGivenName() {
            return givenName;
        }

        public void setGivenName(String given_name) {
            this.givenName = given_name;
        }

        public String getFamilyName() {
            return familyName;
        }

        public void setFamilyName(String family_name) {
            this.familyName = family_name;
        }

        public String getPicture() {
            return picture;
        }

        public void setPicture(String picture) {
            this.picture = picture;
        }

        @Override
        public String toString() {
            return "UserGoogleDto{" +
                    "id='" + id + '\'' +
                    ", email='" + email + '\'' +
                    ", verifiedEmail=" + verifiedEmail +
                    ", name='" + name + '\'' +
                    ", givenName='" + givenName + '\'' +
                    ", familyName='" + familyName + '\'' +
                    ", picture='" + picture + '\'' +
                    '}';
        }
    }
}
