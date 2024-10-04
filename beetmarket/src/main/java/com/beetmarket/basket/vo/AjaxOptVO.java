package com.beetmarket.basket.vo;

import lombok.Data;

@Data
public class AjaxOptVO {
	Long optNo,optPrice,goodsNo,goodsPrice;
	String optName;
	String[] optNames;
	
	public void splitName() {
		this.optNames = optName.split("/");
	}
}
