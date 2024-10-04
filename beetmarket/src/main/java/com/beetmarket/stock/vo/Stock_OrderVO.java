package com.beetmarket.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Stock_OrderVO {
	
	private Long stock_order_no; 	// 종목 번호
	private String order_status; 	// 주문 상태(체결, 미체결)
	private String order_type; 	// 주문 형태(매수,매도)
	private Integer stock_count; 	// 주문 수량
	private String company_code; 	// 종목 코드
	private String company_name; 	// 종목 이름
	private Integer stck_askp1;   // 매도호가 매수 할떄 필요
	private Integer stck_bidp1;   // 매수호가 매도 할떄 필요
	private Integer price;   // 주문가 (주문한 주식 가격)
	private Integer account_balance;   // 계좌 잔액
	private String id;   // 주문한 ID
	private Date order_date;   //  (주문 일자)
	
}