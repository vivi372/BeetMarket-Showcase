package com.beetmarket.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class StockVO {
	
	
	private Integer company_no; 	// 종목 번호
	private String company_code; 	// 종목 코드
	private String company_name; 	// 종목 이름
	private String startDate; 		// 조회할 시작날짜
	private String endDate; 		// 조회할 종료날짜
	private String period_div_code; // 기간 분류 코드 (D:일봉, W:주봉, M:월봉, Y:년봉)
	private String stock_info_no; 	// 주식 정보 번호
	private String acml_tr_pbmn; 	// 누적 거래 대금
	private String acml_vol; 		// 누적 거래량
	private String prdy_ctrt; 		// 전일 대비율
	private String prdy_vrss; 		// 전일 대비
	private String stck_prpr; 		// 주식 현재가
	private String check_date; 		// 조회 일자
	
}
