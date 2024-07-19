package vn.hcmuaf.fit.drillsell.model;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
@WebServlet("/VNP")
public class VNPayConfig extends HttpServlet {
    private static String vnp_TmnCode = "P14UJEAQ";
    private static String vnp_HashSecret = "7F7QGKGNFBCDO74PHBONKLII2BURDKOH";
    private static String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
//    private static String vnp_Returnurl = "https://yourdomain.com/vnpay_return";


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    public static String createPaymentUrl(long amount, String orderInfo, String bankCode) throws UnsupportedEncodingException {
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", "2.1.0");
        vnp_Params.put("vnp_Command", "pay");
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount * 100));
        vnp_Params.put("vnp_CurrCode", "VND");
//        vnp_Params.put("vnp_TxnRef", String.valueOf(System.currentTimeMillis()));
        vnp_Params.put("vnp_OrderInfo", orderInfo);
        vnp_Params.put("vnp_OrderType", "other");
        vnp_Params.put("vnp_Locale", "vn");
//        vnp_Params.put("vnp_ReturnUrl", vnp_Returnurl);
        vnp_Params.put("vnp_IpAddr", "127.0.0.1");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }

        StringBuilder query = new StringBuilder();
        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            query.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
            query.append('=');
            query.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
            query.append('&');
        }

        String queryUrl = query.substring(0, query.length() - 1);
        String secureHash = vnp_HashSecret;
        query.append("&vnp_SecureHashType=SHA512");
        query.append("&vnp_SecureHash=");
        query.append(secureHash);

        return vnp_Url + "?" + query;
    }
}
