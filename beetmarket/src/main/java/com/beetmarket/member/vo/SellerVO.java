package com.beetmarket.member.vo;

import lombok.Data;

@Data
public class SellerVO {
	
	private Integer gradeNo;
	private Integer merchant_delivery;
	private Integer free_ship_limit;
	private String id;
	private String store_name;
	private String is_pending;
	private Integer sell_no;
}
