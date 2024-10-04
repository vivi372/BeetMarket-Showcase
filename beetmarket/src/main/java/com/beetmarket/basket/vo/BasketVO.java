package com.beetmarket.basket.vo;

import lombok.Data;

@Data
public class BasketVO {
	private Long basketNo,goodsNo,goodsPrice,merchant_delivery,optNo,amount,optPrice,free_ship_limit;

	private String id,optName,goodsName,goodsPublicher,goodsMainImage,store_name;	

}
