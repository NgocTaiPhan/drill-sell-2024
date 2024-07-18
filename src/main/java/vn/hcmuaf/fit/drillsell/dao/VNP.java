package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.HMACUtil;

import java.util.Map;

public class VNP {

    public static boolean verifyPayment(Map<String, String> vnp_Params) {
        String vnp_SecureHash = vnp_Params.get("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHash");
        vnp_Params.remove("vnp_SecureHashType");

        StringBuilder data = new StringBuilder();
        for (Map.Entry<String, String> entry : vnp_Params.entrySet()) {
            data.append(entry.getKey());
            data.append('=');
            data.append(entry.getValue());
            data.append('&');
        }

        String dataString = data.substring(0, data.length() - 1);
        String vnp_HashSecret = "7F7QGKGNFBCDO74PHBONKLII2BURDKOH";
        String secureHash = HMACUtil.hmacSHA512(vnp_HashSecret, dataString);

        return vnp_SecureHash.equals(secureHash);
    }
}
