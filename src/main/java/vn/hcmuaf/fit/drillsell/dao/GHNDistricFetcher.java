package vn.hcmuaf.fit.drillsell.dao;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

public class GHNDistricFetcher {

private static final String API_URL = "https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district";
    private static final String TOKEN = "80117275-f321-11ee-8bfa-8a2dda8ec551"; // Replace with your actual token
    private static final Map<String, String> districtNameMap = new HashMap<>();

    static {
        fetchDistricts();
    }

    public static void fetchDistricts() {
        try {
            URL url = new URL(API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Token", TOKEN);

            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            BufferedReader in;
            if (responseCode == HttpURLConnection.HTTP_OK) {
                in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else {
                in = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }

            StringBuilder response = new StringBuilder();
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // Parse JSON response
            Gson gson = new Gson();
            JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
            JsonArray data = jsonResponse.getAsJsonArray("data");

            // Populate districtNameMap with district IDs and names
            for (JsonElement element : data) {
                JsonObject district = element.getAsJsonObject();
                String districtId = district.get("DistrictID").getAsString();
                String districtName = district.get("DistrictName").getAsString();
                districtNameMap.put(districtId, districtName);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getDistrictNameById(String districtId) {
        // Retrieve district name from the map
        return districtNameMap.getOrDefault(districtId, districtId);
    }

    public static void main(String[] args) {
        System.out.println(getDistrictNameById("1770"));
    }
}
