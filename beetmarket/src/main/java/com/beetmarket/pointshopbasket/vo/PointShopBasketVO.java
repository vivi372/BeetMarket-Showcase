package com.beetmarket.pointshopbasket.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PointShopBasketVO {
	private Long pointShopBasketNo;
	private Long goodsId;
	private String goodsName;
	private String goodsImage;
	private Long pointAmount;
	private Long amount;
	private String id;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date writeDate;
}
