package com.utils;

import okhttp3.*;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.concurrent.TimeUnit;

public class TEST {

    public static final String API_KEY = "ql21uVftf13jXL0FGEkFCCzH";
    public static final String SECRET_KEY = "81L7L2FRTMcEkuMr3opuyx8cccXsEw20";

    public static final OkHttpClient HTTP_CLIENT = new OkHttpClient().newBuilder().readTimeout(300, TimeUnit.SECONDS).build();

    public static void main(String[] args) throws IOException {
        // 读取 F 盘的 1.jpg 文件并转换为 Base64 编码
        String base64Image = encodeImageToBase64("F:\\aa2.jpg");

        // 假设的 group_id 和 user_id，你可以根据实际情况修改
        String groupId = "aabb";
        String userId = "2";

        MediaType mediaType = MediaType.parse("application/json");
        // 使用 Base64 编码替换请求体中的 "BASE64"，并添加 group_id 和 user_id
        RequestBody body = RequestBody.create(mediaType, "{\"image_type\":\"BASE64\",\"image\":\"" + base64Image + "\",\"group_id\":\"" + groupId + "\",\"user_id\":\"" + userId + "\"}");
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/rest/2.0/face/v3/faceset/user/add?access_token=" + getAccessToken())
                .method("POST", body)
                .addHeader("Content-Type", "application/json")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        System.out.println(response.body().string());
    }

    private static String encodeImageToBase64(String filePath) throws IOException {
        File file = new File(filePath);
        try (FileInputStream imageInFile = new FileInputStream(file)) {
            byte[] imageData = new byte[(int) file.length()];
            imageInFile.read(imageData);
            return Base64.getEncoder().encodeToString(imageData);
        }
    }


    /**
     * 从用户的AK，SK生成鉴权签名（Access Token）
     *
     * @return 鉴权签名（Access Token）
     * @throws IOException IO异常
     */
    static String getAccessToken() throws IOException {
        MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
        RequestBody body = RequestBody.create(mediaType, "grant_type=client_credentials&client_id=" + API_KEY
                + "&client_secret=" + SECRET_KEY);
        Request request = new Request.Builder()
                .url("https://aip.baidubce.com/oauth/2.0/token")
                .method("POST", body)
                .addHeader("Content-Type", "application/x-www-form-urlencoded")
                .build();
        Response response = HTTP_CLIENT.newCall(request).execute();
        return new JSONObject(response.body().string()).getString("access_token");
    }
}
