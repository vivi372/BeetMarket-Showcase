package com.beetmarket.pointshoporder.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PointShopOrderVO {
	
	private Long pointShopOrderNo;
	private Long goodsId;
	private String goodsImage;
	private String goodsName;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderDate;
	private Long orderPoint;
	private String category;
	private String stockState;
	private String id;
	private Long amount;
	private Long pointShopBasketNo;
	private Long stockNo;
	
	
	
	private List<PointShopOrderVO> list;

}
