package com.beetmarket.stock.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Stock_InfoVO {
	
	private Long stock_info_no;
	private String company_code; 	// 종목 코드
	private Integer stck_prpr;   // 현재가 (현재 주식 가격)
	private Integer prdy_vrss;   // 전일 대비 (전일 주식 가격 대비 상승 또는 하락 금액)
	private String prdy_ctrt;    // 전일 대비율 (전일 대비 주식 가격의 비율, 퍼센트로 표현)
	private Long acml_tr_pbmn;   // 누적 거래 대금 (당일의 총 거래 금액)
	private Long acml_vol;       // 누적 거래량 (당일의 총 거래된 주식 수)
	private Integer stck_oprc;   // 시가 (당일 첫 거래가 이루어진 가격)
	private Integer stck_hgpr;   // 고가 (당일 가장 높은 가격)
	private Integer stck_lwpr;   // 저가 (당일 가장 낮은 가격)
	private Integer stck_mxpr;   // 최고가 (역대 주식의 최고 가격)
	private Integer stck_llam;   // 최저가 (역대 주식의 최저 가격)
	private Double per;          // PER (주가수익비율, 주가를 주당순이익으로 나눈 값)
	private Double pbr;          // PBR (주가순자산비율, 주가를 주당순자산으로 나눈 값)
	private Double eps;          // EPS (주당순이익, 기업이 발행한 주식 1주당 벌어들인 순이익)
	private Double bps;          // BPS (주당순자산, 기업이 보유한 자산에서 부채를 뺀 순자산을 발행 주식수로 나눈 값)
	private Date checkDate;      // 확인 일자

}