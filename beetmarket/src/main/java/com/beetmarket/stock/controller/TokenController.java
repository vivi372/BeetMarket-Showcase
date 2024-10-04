package com.beetmarket.stock.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.stock.service.StockService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


@Controller
@RequestMapping("/token")
@Log4j
public class TokenController {
	
	@Autowired
	@Qualifier("StockServiceImpl") // 만약 여러 구현체가 있을 경우 이 어노테이션을 사용
	private StockService stockService;
   
    private final String APP_KEY = "PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq"; // 실제 키로 교체 필요
    private final String APP_SECRET = "5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo="; // 실제 키로 교체 필요
    
    //(웹소켓) 접속키 
    @GetMapping("/get-token-webSocket")
    public String getToken(Model model) {
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        MediaType mediaType = MediaType.parse("application/json");

        // 요청 바디 생성
        RequestBody body = RequestBody.create(mediaType, "{\r\n    \"grant_type\": \"client_credentials\",\r\n    \"appkey\": \"PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq\",\r\n    \"secretkey\": \"5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo=\"\r\n}");
        
        // 요청 생성
        Request request = new Request.Builder()
                .url("https://openapivts.koreainvestment.com:29443/oauth2/Approval")
                .post(body)
                .addHeader("content-type", "application/json")
                .build();

        try {
            // 요청 보내기
            Response response = client.newCall(request).execute();

            if (response.isSuccessful()) {
                // 응답 본문을 모델에 추가
                String responseBody = response.body().string();
                model.addAttribute("tokenData", responseBody);
            } else {
                model.addAttribute("tokenData", "Request failed: " + response.code());
            }

            response.close();
        } catch (IOException e) {
            log.error("Error occurred: " + e.getMessage(), e);
            model.addAttribute("tokenData", "Error: " + e.getMessage());
        }

        // JSP로 전달
        return "stock/token";
    }
    // 접근토큰발급 세션에 집어넣는다.
    @GetMapping("/get-token-p")
    public String getTokenP(HttpSession session) {
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        MediaType mediaType = MediaType.parse("application/json");

        String requestBodyContent = String.format(
            "{\r\n    \"grant_type\": \"client_credentials\",\r\n    \"appkey\": \"%s\",\r\n    \"appsecret\": \"%s\"\r\n}",
            APP_KEY,
            APP_SECRET
        );

        RequestBody body = RequestBody.create(mediaType, requestBodyContent);
        Request request = new Request.Builder()
                .url("https://openapivts.koreainvestment.com:29443/oauth2/tokenP")
                .post(body)
                .addHeader("content-type", "application/json")
                .build();

        try {
            Response response = client.newCall(request).execute();

            if (response.isSuccessful()) {
                String responseBody = response.body().string();
                ObjectMapper mapper = new ObjectMapper();
                JsonNode rootNode = mapper.readTree(responseBody);
                String accessToken = rootNode.path("access_token").asText();

                // 세션에 토큰 저장
                session.setAttribute("token", accessToken);

                // 토큰 만료 시간 계산 (현재 시간 + 1시간)
                Date expiryTime = new Date(System.currentTimeMillis() + (60 * 60 * 1000)); // 1시간 후
                Timestamp expiryTimestamp = new Timestamp(expiryTime.getTime());  // Timestamp로 변환

                // DB에 토큰 저장 (token_no는 예시로 1로 사용)
                stockService.insertOrUpdateToken(expiryTimestamp, accessToken);

                response.close();
                return accessToken;
            } else {
                response.close();
                return "Request failed: " + response.code();
            }

        } catch (IOException e) {
            return "Error: " + e.getMessage();
        }
    }

}

