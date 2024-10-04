package com.beetmarket.stock.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class Stock_HoldVO {
    private Long stock_hold_no;     // 보유 주식 번호
    private Date order_date;        // 주문 일자
    private int price;              // 체결된 가격
    private int stck_prpr;          // 현재 가격
    private int stock_hold_cnt;     // 보유 주식 수량
    private String id;              // 사용자 ID
    private String company_code;    // 종목 코드
    private String company_name;    // 회사명
    
    // 주문 일자를 포맷팅하여 반환하는 메서드
    public String getFormattedOrderDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(order_date);
    }
}
