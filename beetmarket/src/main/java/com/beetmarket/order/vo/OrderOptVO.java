package com.beetmarket.order.vo;

import lombok.Data;

@Data
public class OrderOptVO {
	private Long orderOptNo;
	private Long optNo;
	private String optName;
	private Long optPrice;
	private Long amount;
	private Long orderNo;
	private Long goodsNo;
}
