package com.beetmarket.basket.vo;

import lombok.Data;

@Data
public class BasketOptVO {
	private Long orderOptNo,optNo,amount,orderNo,basketOptNo,basketNo,lefOrder,goodsPrice,optPrice;
	private String optName;
	
	public int getOptionPrice() {
		return (int) (goodsPrice+(optPrice==null?0:optPrice));
	}
	
	
}
