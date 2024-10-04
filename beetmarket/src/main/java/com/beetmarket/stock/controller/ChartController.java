package com.beetmarket.stock.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beetmarket.stock.service.StockService;
import com.beetmarket.stock.vo.StockVO;

import org.springframework.web.bind.annotation.RequestBody;

import lombok.extern.log4j.Log4j;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/chart")
@Log4j
public class ChartController {
	
	TokenController tc = new TokenController();
	// 자동 DI 
	@Autowired 
	@Qualifier("StockServiceImpl")
	private StockService stockService;
    private final String APP_KEY = "PSdTPt6Y6Y8jlz2bZavylela0LPunIuP9CAq"; // 실제 키로 교체 필요
    private final String APP_SECRET = "5A9NiHMzRkPIxx6rujN5hkpZ/LI4lEU69Yh34G4b9YzUxgrSgQMPTMpztTzoXtdIytjMYr6UwlH+CMNQxI33p04UmV4c4KhKrNnWXmV0Y0Qpjp2+Tn4Jxg6iPNNNU5F0pt+m0NQ0ZDnuW+I0CKgjxYTYdwtu7QDmPF/5Z4CCYDVCqwot0zo="; // 실제 키로 교체 필요


    
    @PostMapping(value = "/getChartDate.do", 
			consumes = "application/json", 
			produces = "text/plain; charset=UTF-8"
			) 
    public ResponseEntity<String> getStockChartData(@RequestBody StockVO vo, HttpSession session) {
        tc.getTokenP(session);
        OkHttpClient client = new OkHttpClient().newBuilder().build();
        String cachedToken = stockService.getTokenFromDB(1);  // token_no를 1로 가정
        Request request = new Request.Builder()
            .url("https://openapivts.koreainvestment.com:29443/uapi/domestic-stock/v1/quotations/"
                + "inquire-daily-itemchartprice?fid_cond_mrkt_div_code=J"
                + "&fid_input_iscd=" + vo.getCompany_code()
                + "&fid_input_date_1=" + vo.getStartDate()
                + "&fid_input_date_2=" + vo.getEndDate()
                + "&fid_period_div_code=" + vo.getPeriod_div_code()
                + "&fid_org_adj_prc=1")
            .get()
            .addHeader("authorization", "Bearer " + cachedToken)
            .addHeader("appkey", APP_KEY)
            .addHeader("appsecret", APP_SECRET)
            .addHeader("tr_id", "FHKST03010100")
            .build();

        try {
            Response response = client.newCall(request).execute();
            String responseBody = response.body().string();  // ResponseBody를 변수에 저장
            log.info("@@@@@@@@@@@@@@@@@ ="+ responseBody);
            if (response.isSuccessful()) {
                return new ResponseEntity<String>(responseBody, HttpStatus.OK);  // 성공 시 JSON 반환
            } else {
                return new ResponseEntity<String>("", HttpStatus.OK);
            }
            
        } catch (IOException e) {
            return new ResponseEntity<String>(e.getMessage(), HttpStatus.OK);
        }
    }
    

}


