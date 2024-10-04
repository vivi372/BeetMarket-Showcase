package com.beetmarket.faq.vo;

import lombok.Data;

@Data
public class FaqSearchVO {
	private String searchword;
	private String searchkey;
	private Long cateno;
	private Long ismain;
}