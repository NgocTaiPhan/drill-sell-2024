package vn.hcmuaf.fit.drillsell.Login;

import java.io.IOException;
import java.util.Properties;

public class FacebookProp {
    static Properties prop = new Properties();

    static {
        try {
            prop.load(Constants.class.getClassLoader().getResourceAsStream("facebooklogin.properties"));
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static String getClientID() {
        return prop.getProperty("FACEBOOK_CLIENT_ID");
    }

    public static String getClientSecret() {
        return prop.getProperty("FACEBOOK_CLIENT_SECRET");
    }

    public static String getRedirectURI() {
        return prop.getProperty("FACEBOOK_REDIRECT_URI");
    }

    public static String getLinkToken() {
        return prop.getProperty("FACEBOOK_LINK_GET_TOKEN");
    }

    public static String getUserInfor() {
        return prop.getProperty("FACEBOOK_LINK_GET_USER_INFO");
    }


    public static void main(String[] args) {
        System.out.println(getLinkToken());
    }
}
