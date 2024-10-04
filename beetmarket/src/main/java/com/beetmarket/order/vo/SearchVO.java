package com.beetmarket.order.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;


import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SearchVO {
	private String searchWord;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate minDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate maxDate;
	private String searchKey;
	private String payWay;
	private Long goodsNo;
	private String orderStateSearch;
	private String orderState2;
	private String name;
	private String goodsName;
	private boolean detailSearchExist;
	
	public String getQuery() throws UnsupportedEncodingException {
		return "minDate="+toStr(minDate)+"&maxDate="+toStr(maxDate)+"&orderStateSearch="+URLEncoder.encode(toStr(orderStateSearch),"utf-8")
				+"&searchWord="+URLEncoder.encode(toStr(searchWord),"utf-8")+"&detailSearchExist="+toStr(detailSearchExist);
	}
	
	public String getFullQuery() throws UnsupportedEncodingException {
		return "minDate="+toStr(minDate)+"&maxDate="+toStr(maxDate)+"&searchKey="+toStr(searchKey)+"&orderStateSearch="+URLEncoder.encode(toStr(orderStateSearch),"utf-8")
		+"&searchWord="+URLEncoder.encode(toStr(searchWord),"utf-8")+"&goodsNo="+toStr(goodsNo)+
		"&payWay="+URLEncoder.encode(toStr(payWay),"utf-8")+"&detailSearchExist="+toStr(detailSearchExist);
	}
	
	private String toStr(Object obj) {
		return (obj==null)?"":obj.toString();
	}
}
