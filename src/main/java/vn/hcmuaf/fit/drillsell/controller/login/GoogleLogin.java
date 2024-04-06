package vn.hcmuaf.fit.drillsell.controller.login;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import vn.hcmuaf.fit.drillsell.GoogleLogin.GoogleLoginProperties;
import vn.hcmuaf.fit.drillsell.model.UserGoogleDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "GoogleLogin", urlPatterns = "/login-google")
public class GoogleLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * Xử lý cả yêu cầu HTTP GET và POST.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException nếu có lỗi cụ thể của servlet
     * @throws IOException      nếu có lỗi I/O
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDTO user = getUserInfo(accessToken);
        System.out.println(user);
    }

    /**
     * Lấy token từ mã authorization code.
     *
     * @param code mã authorization code
     * @return token truy cập
     * @throws ClientProtocolException nếu có lỗi giao thức HTTP
     * @throws IOException            nếu có lỗi I/O
     */
    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(GoogleLoginProperties.getTokenLink())
                .bodyForm(Form.form()
                        .add("client_id", GoogleLoginProperties.getClientId())
                        .add("client_secret", GoogleLoginProperties.getClientSecret())
                        .add("redirect_uri", GoogleLoginProperties.getRedirectUri())
                        .add("code", code)
                        .add("grant_type", GoogleLoginProperties.getGrantType())
                        .build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").getAsString();
        return accessToken;
    }

    /**
     * Lấy thông tin người dùng từ token truy cập.
     *
     * @param accessToken token truy cập
     * @return đối tượng UserGoogleDTO chứa thông tin người dùng
     * @throws ClientProtocolException nếu có lỗi giao thức HTTP
     * @throws IOException            nếu có lỗi I/O
     */
    public static UserGoogleDTO getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = GoogleLoginProperties.getUserInfoLink() + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDTO googlePojo = new Gson().fromJson(response, UserGoogleDTO.class);

        return googlePojo;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Xử lý đăng nhập với Google";
    }
}
