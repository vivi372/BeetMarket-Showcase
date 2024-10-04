package com.beetmarket.beetpay.vo;

import lombok.Data;

@Data
public class BeetpayVO {
	private Long BeetpayNo;
	private String id;
	private String cardCompany;
	private String cardBrand;
	private String cardType;
	private String cardNumber;
	private Integer payPassword;
}
