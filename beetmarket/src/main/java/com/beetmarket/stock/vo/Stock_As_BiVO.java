package com.beetmarket.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Stock_As_BiVO {
	
	private String askp1;  // 매도호가1
    private String askp2;  // 매도호가2
    private String askp3;  // 매도호가3
    private String askp4;  // 매도호가4
    private String askp5;  // 매도호가5
    private String bidp1;  // 매수호가1
    private String bidp2;  // 매수호가2
    private String bidp3;  // 매수호가3
    private String bidp4;  // 매수호가4
    private String bidp5;  // 매수호가5
    private String askp_rsqn1;  // 매도호가 잔량1
    private String askp_rsqn2;  // 매도호가 잔량2
    private String askp_rsqn3;  // 매도호가 잔량3
    private String askp_rsqn4;  // 매도호가 잔량4
    private String askp_rsqn5;  // 매도호가 잔량5
    private String bidp_rsqn1;  // 매수호가 잔량1
    private String bidp_rsqn2;  // 매수호가 잔량2
    private String bidp_rsqn3;  // 매수호가 잔량3
    private String bidp_rsqn4;  // 매수호가 잔량4
    private String bidp_rsqn5;  // 매수호가 잔량5
    private String total_askp_rsqn;  // 총 매도호가 잔량
    private String total_bidp_rsqn;  // 총 매수호가 잔량
    private String company_code;  // 회사 코드
    private Date checkDate;      // 확인 일자
}