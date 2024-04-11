//package vn.hcmuaf.fit.drillsell.GoogleLogin;
//
//import java.io.IOException;
//import java.util.Properties;
//
//public class Constants {
//    static Properties prop = new Properties();
//
//    static {
//        try {
//            prop.load(Constants.class.getClassLoader().getResourceAsStream("googlelogin.properties"));
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    public static String getClientID() {
//        return prop.getProperty("GOOGLE_CLIENT_ID");
//    }
//
//    public static String getClientSecret() {
//        return prop.getProperty("GOOGLE_CLIENT_SECRET");
//    }
//
//    public static String getRedirectURI() {
//        return prop.getProperty("GOOGLE_REDIRECT_URI");
//    }
//
//    public static String getLinkToken() {
//        return prop.getProperty("GOOGLE_LINK_GET_TOKEN");
//    }
//
//    public static String getUserInfor() {
//        return prop.getProperty("GOOGLE_LINK_GET_USER_INFO");
//    }
//
//    public static String getGrantType() {
//        return prop.getProperty("GOOGLE_GRANT_TYPE");
//    }
//
//
//}
