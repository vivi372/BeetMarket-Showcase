package com.beetmarket.pointshoporder.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SearchVO {
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate minDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate maxDate;
	private String category;
	private String stockState;
	private String word;
	private String key;
	private String id;
	private String goodsName;
	private boolean detailSearchExist;
	
	public String getQuery() throws UnsupportedEncodingException {
		return "minDate="+toStr(minDate)+"&maxDate="+toStr(maxDate)+"&category="+URLEncoder.encode(toStr(category),"utf-8") +"&stockState="+URLEncoder.encode(toStr(stockState),"utf-8")
				+"&key="+toStr(key)+"&word="+URLEncoder.encode(toStr(word),"utf-8")+"&detailSearchExist="+toStr(detailSearchExist);
	}
	
	private String toStr(Object obj) {
		return (obj==null)?"":obj.toString();
	}
}
