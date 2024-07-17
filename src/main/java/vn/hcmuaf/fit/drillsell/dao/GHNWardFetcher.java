package vn.hcmuaf.fit.drillsell.dao;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;


public class GHNWardFetcher {
private static final String TOKEN = "80117275-f321-11ee-8bfa-8a2dda8ec551";
    private static String fetchAPI(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");
        connection.setRequestProperty("Token", TOKEN);

        int responseCode = connection.getResponseCode();
        if (responseCode != 200) {
            throw new IOException("Server returned HTTP response code: " + responseCode + " for URL: " + apiUrl);
        }

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();
        connection.disconnect();

        return content.toString();
    }
    public static String getWardNameById(String districtId, String wardId) {
        String url = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=" + districtId;
        try {
            String jsonResponse = fetchAPI(url);
            JsonObject jsonObject = JsonParser.parseString(jsonResponse).getAsJsonObject();
            JsonArray wardsArray = jsonObject.getAsJsonArray("data");

            for (JsonElement element : wardsArray) {
                JsonObject ward = element.getAsJsonObject();
                String wardCode = ward.get("WardCode").getAsString();
                if (wardCode.equals(wardId)) {
                    return ward.get("WardName").getAsString();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return wardId;
    }
    public static void main(String[] args) {
        String districtId = "1770";
        System.out.println(getWardNameById(districtId, "370614"));
    }
}


