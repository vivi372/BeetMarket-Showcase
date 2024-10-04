package com.beetmarket.order.vo;



import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderVO {
	private long orderNo;
	private long orderPrice;
	private long dlvyCharge;
	private String orderState;
	private String cancleReason;
	private String id;
	private String name;
	private String memberTel;
	private String payWay;
	private String payDetail;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date confirmDate;
	private String dlvyMemo;
	private long dlvyAddrNo;
	private long postNo;
	private String recipient;
	private String dlvyName;
	private String tel;
	private String addr;
	private String addrDetail;
	private Long goodsId; //쿠폰의 상품 번호
	private Long stockNo; //쿠폰의 재고 번호
	private Long goodsNo;
	private int reviewExist;

	private String goodsName;
	private String goodsMainImage;
	private String store_name;
	private Long goodsPrice;
	private Integer merchant_delivery;
	private Integer free_ship_limit;
	private Integer goodsSaveRate;
	private Integer sale_rate;
	private Integer discount; //상품 할인 금액

	private long orderOptNo;
	private String optName;
	private Long optNo;
	private long amount;	
	private String paymentKey;
	
}
